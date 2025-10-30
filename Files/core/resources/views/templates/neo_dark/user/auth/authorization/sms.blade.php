@extends($activeTemplate .'layouts.frontend')
@section('content')
<div class="cmn-section pt-60 pb-60">
    <div class="container">
        <div class="d-flex justify-content-center">
            <div class="verification-code-wrapper">
                <div class="verification-area">
                    <form action="{{route('user.verify.mobile')}}" method="POST" class="submit-form">
                        @csrf
                        <p class="verification-text mt-3 mb-3">@lang('A 6 digit verification code sent to your mobile number') :  +{{ showMobileNumber(auth()->user()->mobileNumber) }}</p>
                        @include($activeTemplate.'partials.verification_code')
                        <div class="mb-3">
                            <button type="submit" class="btn btn--base w-100">@lang('Submit')</button>
                        </div>
                        <div class="form-group">
                            <p>
                                @lang('If you don\'t get any code'), <span class="countdownWrapper">@lang('try again after') <span id="countdown" class="fw-bold">--</span> @lang('seconds')</span> <a href="{{route('user.send.verify.code', 'sms')}}" class="try-again-link forget-pass d-none"> @lang('Try again')</a>
                            </p>
                            <a href="{{ route('user.logout') }}" class="forget-pass">@lang('Logout')</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection

@push('script')
    <script>
        var distance =Number("{{@$user->ver_code_send_at->addMinutes(2)->timestamp-time()}}");
        var x = setInterval(function() {
            distance--;
            document.getElementById("countdown").innerHTML = distance;
            if (distance <= 0) {
                clearInterval(x);
                document.querySelector('.countdownWrapper').classList.add('d-none');
                document.querySelector('.try-again-link').classList.remove('d-none');
            }
        }, 1000);
    </script>
@endpush