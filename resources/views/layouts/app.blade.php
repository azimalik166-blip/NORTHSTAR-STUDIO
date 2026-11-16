<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="@yield('meta_description', 'Northstar Studio is a demo digital studio building thoughtful brands and websites.')">
    <meta name="theme-color" content="#10233f">
    <title>@yield('title', 'Northstar Studio') — Demo Project</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&family=Manrope:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="{{ asset('css/site.css') }}" rel="stylesheet">
    @stack('styles')
</head>
<body>
    <div class="demo-strip">
        <span><i class="bi bi-stars" aria-hidden="true"></i> Portfolio demo project</span>
        <span>A sample business website — not a real agency</span>
    </div>

    <header class="site-header">
        <nav class="navbar navbar-expand-lg" aria-label="Main navigation">
            <div class="container">
                <a class="navbar-brand brand-lockup" href="{{ route('home') }}" aria-label="Northstar Studio home">
                    <span class="brand-mark" aria-hidden="true"><i class="bi bi-compass-fill"></i></span>
                    <span>NORTHSTAR<span class="brand-light">STUDIO</span></span>
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNavigation" aria-controls="mainNavigation" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="mainNavigation">
                    <ul class="navbar-nav mx-auto">
                        <li class="nav-item"><a class="nav-link {{ request()->routeIs('home') ? 'active' : '' }}" @if(request()->routeIs('home')) aria-current="page" @endif href="{{ route('home') }}">Home</a></li>
                        <li class="nav-item"><a class="nav-link {{ request()->routeIs('about') ? 'active' : '' }}" @if(request()->routeIs('about')) aria-current="page" @endif href="{{ route('about') }}">About</a></li>
                        <li class="nav-item"><a class="nav-link {{ request()->routeIs('services') ? 'active' : '' }}" @if(request()->routeIs('services')) aria-current="page" @endif href="{{ route('services') }}">Services</a></li>
                        <li class="nav-item"><a class="nav-link {{ request()->routeIs('contact') ? 'active' : '' }}" @if(request()->routeIs('contact')) aria-current="page" @endif href="{{ route('contact') }}">Contact</a></li>
                    </ul>
                    <a class="btn btn-navy nav-cta" href="{{ route('contact') }}">Let’s talk <i class="bi bi-arrow-up-right" aria-hidden="true"></i></a>
                </div>
            </div>
        </nav>
    </header>

    <main>
        @yield('content')
    </main>

    <footer class="site-footer">
        <div class="container">
            <div class="footer-main">
                <div class="footer-brand">
                    <a class="brand-lockup brand-lockup-light" href="{{ route('home') }}">
                        <span class="brand-mark" aria-hidden="true"><i class="bi bi-compass-fill"></i></span>
                        <span>NORTHSTAR<span class="brand-light">STUDIO</span></span>
                    </a>
                    <p>A considered digital studio concept, made to show what a modern business website can be.</p>
                </div>
                <div class="footer-links">
                    <span class="footer-label">Explore</span>
                    <a href="{{ route('about') }}">About</a>
                    <a href="{{ route('services') }}">Services</a>
                    <a href="{{ route('contact') }}">Contact</a>
                </div>
                <div class="footer-links footer-contact">
                    <span class="footer-label">A demo, not a real business</span>
                    <span>Sample content for portfolio presentation.</span>
                    <a href="{{ route('contact') }}">Get in touch <i class="bi bi-arrow-right" aria-hidden="true"></i></a>
                </div>
            </div>
            <div class="footer-bottom">
                <span>© {{ date('Y') }} Northstar Studio Demo</span>
                <span>Designed with intention. Built with Laravel.</span>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="{{ asset('js/site.js') }}" defer></script>
    @stack('scripts')
</body>
</html>
