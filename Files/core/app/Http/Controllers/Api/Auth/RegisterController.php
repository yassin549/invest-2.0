<?php

namespace App\Http\Controllers\Api\Auth;

use App\Models\User;
use App\Constants\Status;
use App\Models\UserLogin;
use App\Models\Transaction;
use Illuminate\Http\Request;
use App\Models\AdminNotification;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rules\Password;
use Illuminate\Foundation\Auth\RegistersUsers;

class RegisterController extends Controller
{
    /*
    |--------------------------------------------------------------------------
    | Register Controller
    |--------------------------------------------------------------------------
    |
    | This controller handles the registration of new users as well as their
    | validation and creation. By default this controller uses a trait to
    | provide this functionality without requiring any additional code.
    |
    */

    use RegistersUsers;


    /**
     * Get a validator for an incoming registration request.
     *
     * @param  array $data
     * @return \Illuminate\Contracts\Validation\Validator
     */
    protected function validator(array $data)
    {
        $passwordValidation = Password::min(6);
        if (gs('secure_password')) {
            $passwordValidation = $passwordValidation->mixedCase()->numbers()->symbols()->uncompromised();
        }
        $agree = 'nullable';
        if (gs('agree')) {
            $agree = 'required';
        }

        $validate     = Validator::make($data, [
            'firstname' => 'required',
            'lastname'  => 'required',
            'email'     => 'required|string|email|unique:users',
            'password'  => ['required', 'confirmed', $passwordValidation],
            'agree'     => $agree
        ],[
            'firstname.required'=>'The first name field is required',
            'lastname.required'=>'The last name field is required'
        ]);

        return $validate;
    }


    public function register(Request $request)
    {

        if (!gs('registration')) {
            $notify[] = 'Registration not allowed';
            return response()->json([
                'remark' => 'validation_error',
                'status' => 'error',
                'message' => ['error' => $notify],
            ]);
        }


        $validator = $this->validator($request->all());
        if ($validator->fails()) {
            return response()->json([
                'remark' => 'validation_error',
                'status' => 'error',
                'message' => ['error' => $validator->errors()->all()],
            ]);
        }

        if ($request->is_web) {
            $request->{'g-recaptcha-response'} = $request->recaptcha;
            if(!verifyCaptcha()){
                $notify[] = 'Invalid captcha provided';
                return response()->json([
                    'remark'=>'captcha_error',
                    'status'=>'error',
                    'message'=>['error'=>$notify],
                ]);
            }
        }

        $user = $this->create($request->all());

        $response['access_token'] =  $user->createToken('auth_token')->plainTextToken;
        $response['user'] = $user;
        $response['token_type'] = 'Bearer';
        $notify[] = 'Registration successful';
        return response()->json([
            'remark' => 'registration_success',
            'status' => 'success',
            'message' => ['success' => $notify],
            'data' => $response
        ]);
    }


    /**
     * Create a new user instance after a valid registration.
     *
     * @param  array $data
     * @return \App\User
     */
    protected function create(array $data)
    {
        $referBy = @$data['reference'];
        if ($referBy) {
            $referUser = User::where('username', $referBy)->first();
        } else {
            $referUser = null;
        }

        $general = gs();

        //User Create
        $user            = new User();
        $user->firstname = $data['firstname'];
        $user->lastname  = $data['lastname'];
        $user->email     = strtolower($data['email']);
        $user->password  = Hash::make($data['password']);
        $user->ref_by    = $referUser ? $referUser->id : 0;
        $user->kv = $general->kv ? Status::UNVERIFIED : Status::VERIFIED;
        $user->ev = $general->ev ? Status::UNVERIFIED : Status::VERIFIED;
        $user->sv = $general->sv ? Status::UNVERIFIED : Status::VERIFIED;
        $user->ts = Status::DISABLE;
        $user->tv = Status::VERIFIED;
        $user->save();


        $adminNotification = new AdminNotification();
        $adminNotification->user_id = $user->id;
        $adminNotification->title = 'New member registered';
        $adminNotification->click_url = urlPath('admin.users.detail', $user->id);
        $adminNotification->save();


        //Login Log Create
        $ip = getRealIP();
        $exist = UserLogin::where('user_ip', $ip)->first();
        $userLogin = new UserLogin();

        //Check exist or not
        if ($exist) {
            $userLogin->longitude =  $exist->longitude;
            $userLogin->latitude =  $exist->latitude;
            $userLogin->city =  $exist->city;
            $userLogin->country_code = $exist->country_code;
            $userLogin->country =  $exist->country;
        } else {
            $info = json_decode(json_encode(getIpInfo()), true);
            $userLogin->longitude =  @implode(',', $info['long']);
            $userLogin->latitude =  @implode(',', $info['lat']);
            $userLogin->city =  @implode(',', $info['city']);
            $userLogin->country_code = @implode(',', $info['code']);
            $userLogin->country =  @implode(',', $info['country']);
        }

        $userAgent = osBrowser();
        $userLogin->user_id = $user->id;
        $userLogin->user_ip =  $ip;

        $userLogin->browser = @$userAgent['browser'];
        $userLogin->os = @$userAgent['os_platform'];
        $userLogin->save();

        if ($general->signup_bonus_control == Status::ENABLE) {
            $userWallet = $user;
            $userWallet->deposit_wallet += $general->signup_bonus_amount;
            $userWallet->save();

            $transaction               = new Transaction();
            $transaction->user_id      = $user->id;
            $transaction->amount       = $general->signup_bonus_amount;
            $transaction->charge       = 0;
            $transaction->post_balance = $userWallet->deposit_wallet;
            $transaction->trx_type     = '+';
            $transaction->trx          = getTrx();
            $transaction->wallet_type  = 'deposit_wallet';
            $transaction->remark       = 'registration_bonus';
            $transaction->details      = 'You have got registration bonus';
            $transaction->save();
        }

        $parentUser = User::find($user->ref_by);

        if ($parentUser) {
            notify($parentUser, 'REFERRAL_JOIN', [
                'ref_username' => $user->username,
            ]);
        }

        $user = User::find($user->id);

        return $user;
    }

}
