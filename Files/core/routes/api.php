<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
 */

Route::namespace('Api')->name('api.')->group(function () {

    Route::controller('AppController')->group(function () {
        Route::get('general-setting', 'generalSetting');
        Route::get('logo-favicon', 'logoFavicon');
        Route::get('get-countries', 'getCountries');
        Route::get('language/{key?}','getLanguage');
        Route::get('policies', 'policies');
        Route::get('policy/{slug}', 'policyContent');
        Route::get('faq', 'faq');
        Route::get('seo', 'seo');
        Route::get('get-extension/{act}','getExtension');
        Route::post('contact', 'submitContact');
        Route::get('cookie', 'cookie');
        Route::post('cookie/accept', 'cookieAccept');
        Route::get('custom-pages', 'customPages');
        Route::get('custom-page/{slug}', 'customPageData');
        Route::get('section-data/{section}', 'sectionData');
        Route::get('ticket/{ticket}', 'viewTicket');
        Route::post('ticket/ticket-reply/{id}', 'replyTicket');
        Route::post('subscribe', 'subscribe')->name('subscribe');
        Route::get('user-rankings', 'userRankings');
        Route::get('top-investors', 'topInvestors');
        Route::get('latest-transaction', 'latestTransaction');
        Route::get('plans', 'plans');
        Route::post('plan-calculator', 'planCalculator');
        Route::get('blog-details/{id}', 'blogDetails');
        Route::get('blogs', 'blogs');
    });

    Route::namespace('Auth')->group(function () {
        Route::controller('LoginController')->group(function () {
            Route::post('login', 'login');
            Route::post('check-token', 'checkToken');
            Route::post('social-login', 'socialLogin');      
        });

        Route::controller('MetamaskController')->group(function () {
            Route::post('login/metamask', 'metamaskLogin');
            Route::post('login/metamask/verify', 'metamaskLoginVerify');
        });

        Route::post('register', 'RegisterController@register');

        Route::controller('ForgotPasswordController')->group(function () {
            Route::post('password/email', 'sendResetCodeEmail');
            Route::post('password/verify-code', 'verifyCode');
            Route::post('password/reset', 'reset');
        });

    });

    Route::middleware('auth:sanctum')->group(function () {

        Route::post('user-data-submit', 'UserController@userDataSubmit');

        //authorization
        Route::middleware('registration.complete')->controller('AuthorizationController')->group(function () {
            Route::get('authorization', 'authorization');
            Route::get('resend-verify/{type}', 'sendVerifyCode');
            Route::post('verify-email', 'emailVerification');
            Route::post('verify-mobile', 'mobileVerification');
            Route::post('verify-g2fa', 'g2faVerification');
        });

        Route::middleware(['check.status'])->group(function () {

            Route::middleware('registration.complete')->group(function () {

                Route::controller('UserController')->group(function () {

                    Route::get('promotional-banners', 'promotionalBanners');
                    Route::get('invest-statistics', 'investStatistics');

                    Route::get('dashboard', 'dashboard');
                    Route::get('user-info', 'userInfo');

                    Route::get('download-attachments/{file_hash}', 'downloadAttachment')->name('download.attachment');
                    Route::post('profile-setting', 'submitProfile');
                    Route::post('change-password', 'submitPassword'); 

                    Route::get('my-referrals', 'myReferrals');
                    Route::post('balance-transfer', 'balanceTransfer');

                    //KYC
                    Route::get('kyc-form', 'kycForm');
                    Route::get('kyc-data','kycData');
                    Route::post('kyc-submit', 'kycSubmit');

                    //Report
                    Route::any('deposit/history', 'depositHistory');
                    Route::get('transactions', 'transactions');

                    Route::post('add-device-token', 'addDeviceToken');
                    Route::get('push-notifications', 'pushNotifications');
                    Route::post('push-notifications/read/{id}', 'pushNotificationsRead');

                    //2FA
                    Route::get('twofactor', 'show2faForm');
                    Route::post('twofactor/enable', 'create2fa');
                    Route::post('twofactor/disable', 'disable2fa');

                    Route::post('account-delete', 'accountDelete');
                });

                Route::controller('InvestController')->group(function () {
                    Route::prefix('invest')->group(function () {
                        Route::get('/', 'invest');
                        Route::get('details/{id}', 'details');
                        Route::get('plans', 'allPlans');
                        Route::post('store', 'storeInvest');
                        Route::post('manage-capital', 'manageCapital');

                        Route::get('schedules', 'scheduleInvests');
                        Route::get('schedule/status/{id}', 'scheduleStatus');
                    });

                    Route::get('staking', 'staking');
                    Route::post('staking/save', 'saveStaking');

                    Route::get('pool/plans', 'pools');
                    Route::get('pools', 'poolInvests');
                    Route::post('pool/save', 'savePoolInvest');

                    Route::get('ranking', 'ranking');
                });

                // Withdraw
                Route::controller('WithdrawController')->group(function () {
                    Route::middleware('kyc')->group(function () {
                        Route::get('withdraw-method', 'withdrawMethod');
                        Route::post('withdraw-request', 'withdrawStore');
                        Route::post('withdraw-request/confirm', 'withdrawSubmit');
                    });
                    Route::get('withdraw/history', 'withdrawLog');
                });

                // Payment
                Route::controller('PaymentController')->group(function () {
                    Route::get('deposit/methods', 'methods');
                    Route::post('deposit/insert', 'depositInsert');
                    Route::post('app/payment/confirm', 'appPaymentConfirm');
                    Route::post('manual/confirm', 'manualDepositConfirm');
                });

                Route::controller('TicketController')->prefix('ticket')->group(function () {
                    Route::get('/', 'supportTicket');
                    Route::post('create', 'storeSupportTicket');
                    Route::get('view/{ticket}', 'viewTicket');
                    Route::post('reply/{id}', 'replyTicket');
                    Route::post('close/{id}', 'closeTicket');
                    Route::get('download/{attachment_id}', 'ticketDownload');
                });

            });
        });

        Route::get('logout', 'Auth\LoginController@logout');
    });
});
