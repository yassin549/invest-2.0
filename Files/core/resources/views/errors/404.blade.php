<!-- meta tags and other links -->
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{{ gs()->siteName($pageTitle ?? '404 | page not found') }}</title>
    <link rel="shortcut icon" type="image/png" href="{{ siteFavicon() }}">
    <!-- bootstrap 4  -->
    <link rel="stylesheet" href="{{ asset('assets/global/css/bootstrap.min.css') }}">
    <!-- dashdoard main css -->
    <link rel="stylesheet" href="{{ asset('assets/errors/css/main.css') }}">
</head>

<body>
    <!-- error-404 start -->
    <div class="error" style="background-image: url({{ asset('assets/errors/images/bg-404.png') }})">
        <div class="container">
            <div class="row justify-content-center align-items-center">
                <div class="col-lg-7 text-center">
                    <img src="{{ asset('assets/errors/images/error-404.png') }}" alt="image">
                    <span class="star-glow glow-1" style="background: url({{ asset('assets/errors/images/star-glow.png') }}) no-repeat center"></span>
                    <span class="star-glow glow-2" style="background: url({{ asset('assets/errors/images/star-glow.png') }}) no-repeat center"></span>
                    <span class="star-glow glow-3" style="background: url({{ asset('assets/errors/images/star-glow.png') }}) no-repeat center"></span>
                    <span class="star-glow glow-4" style="background: url({{ asset('assets/errors/images/star-glow.png') }}) no-repeat center"></span>
                    <h2 class="title"> @lang('Page not found')</h2>
                    <p class="description">@lang('page you are looking for doesn\'t exist or an other error ocurred') <br> @lang('or temporarily unavailable.')</p>
                    <a href="{{ route('home') }}" class="cmn-btn mt-4"><span class="icon">
                            <svg width="25" height="25" viewBox="0 0 25 25" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M23.0861 7.20091L21.6339 6.00578V2.05961C21.6461 1.91445 21.6283 1.76832 21.5816 1.63047C21.5349 1.49261 21.4604 1.36604 21.3627 1.25877C21.2651 1.1515 21.1464 1.06586 21.0143 1.00728C20.8821 0.948694 20.7394 0.918445 20.595 0.918445C20.4507 0.918445 20.3079 0.948694 20.1758 1.00728C20.0436 1.06586 19.925 1.1515 19.8273 1.25877C19.7296 1.36604 19.6551 1.49261 19.6084 1.63047C19.5618 1.76832 19.544 1.91445 19.5562 2.05961V4.26195L15.7954 1.1877C14.8643 0.419599 13.6988 0 12.4963 0C11.2938 0 10.1283 0.419599 9.1972 1.1877L1.90647 7.20091C1.31034 7.68908 0.829803 8.30551 0.499961 9.00515C0.170118 9.7048 -0.000694968 10.47 2.12507e-06 11.2448V19.7384C2.12507e-06 21.1339 0.549226 22.4722 1.52685 23.4589C2.50448 24.4457 3.83042 25 5.21299 25H19.787C21.1696 25 22.4955 24.4457 23.4731 23.4589C24.4508 22.4722 25 21.1339 25 19.7384V11.2147C24.9954 10.4444 24.8213 9.6847 24.4903 8.99056C24.1593 8.29642 23.6797 7.68514 23.0861 7.20091ZM9.37593 22.8578V15.5818C9.41511 14.7722 9.76135 14.0088 10.3429 13.4497C10.9245 12.8907 11.6969 12.5789 12.5 12.5789C13.3031 12.5789 14.0755 12.8907 14.6571 13.4497C15.2387 14.0088 15.5849 14.7722 15.6241 15.5818V22.8578H9.37593ZM22.9223 19.7084C22.9203 20.543 22.5909 21.343 22.0062 21.9332C21.4214 22.5234 20.6289 22.8558 19.8019 22.8578H17.7093V15.5818C17.7093 14.1864 17.16 12.8481 16.1824 11.8613C15.2048 10.8746 13.8788 10.3203 12.4963 10.3203C11.1137 10.3203 9.78776 10.8746 8.81014 11.8613C7.83251 12.8481 7.28329 14.1864 7.28329 15.5818V22.8578H5.1981C4.36984 22.8578 3.5754 22.5262 2.98904 21.9358C2.40268 21.3454 2.07227 20.5443 2.0703 19.7084V11.2147C2.06981 10.7471 2.17248 10.2853 2.37085 9.86278C2.56922 9.44024 2.85832 9.06758 3.21716 8.77186L10.5079 2.75865C11.0662 2.30218 11.7629 2.0531 12.4814 2.0531C13.1999 2.0531 13.8966 2.30218 14.4549 2.75865L21.7456 8.77186C22.1099 9.06462 22.4047 9.43597 22.6083 9.85868C22.8119 10.2814 22.9192 10.7447 22.9223 11.2147V19.7084Z" />
                            </svg>

                        </span><span class="text"> @lang('Go to Home')</span></a>
                </div>
            </div>
        </div>
    </div>
    <!-- error-404 end -->
</body>

</html>
