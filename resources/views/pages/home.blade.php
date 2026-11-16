@extends('layouts.app')

@section('title', 'Thoughtful digital, built for what’s next')
@section('meta_description', 'A portfolio demo for a fictional digital studio, featuring brand strategy, web design and Laravel development.')

@section('content')
    <section class="hero-section">
        <div class="container hero-grid">
            <div class="hero-copy">
                <div class="eyebrow"><span class="eyebrow-line"></span> A digital studio demo</div>
                <h1>Thoughtful digital.<br><span>Built for what’s next.</span></h1>
                <p class="hero-lead">We bring clear thinking and considered design to the moments that move your business forward.</p>
                <div class="hero-actions">
                    <a class="btn btn-coral" href="{{ route('services') }}">Explore our services <i class="bi bi-arrow-up-right" aria-hidden="true"></i></a>
                    <a class="text-link" href="{{ route('about') }}">Get to know us <i class="bi bi-arrow-right" aria-hidden="true"></i></a>
                </div>
                <div class="hero-note"><span class="note-dot"></span> Independent thinking. End-to-end craft.</div>
            </div>
            <div class="hero-art" role="img" aria-label="Sunlit creative workspace with a laptop and carefully arranged objects">
                <div class="hero-photo"></div>
                <div class="hero-art-shade"></div>
                <div class="art-caption"><span class="caption-mark"><i class="bi bi-compass-fill" aria-hidden="true"></i></span><span>Make room<br>for what’s next.</span></div>
                <div class="art-index">01 <span>—</span> 04</div>
                <div class="floating-note"><i class="bi bi-stars" aria-hidden="true"></i><span>Good ideas,<br>made real.</span></div>
            </div>
        </div>
        <div class="hero-bottom container">
            <span>STRATEGY &nbsp;·&nbsp; DESIGN &nbsp;·&nbsp; DEVELOPMENT</span>
            <span>Scroll to discover <i class="bi bi-arrow-down" aria-hidden="true"></i></span>
        </div>
    </section>

    <section class="intro-section section-pad">
        <div class="container intro-grid">
            <div>
                <div class="eyebrow eyebrow-dark"><span class="eyebrow-line"></span> A little about us</div>
                <h2>Good work starts<br>with <span class="serif-accent">good questions.</span></h2>
            </div>
            <div class="intro-copy">
                <p>Northstar is a fictional independent studio built around a simple idea: thoughtful digital experiences help ambitious businesses find their direction.</p>
                <a class="text-link text-link-dark" href="{{ route('about') }}">More about our approach <i class="bi bi-arrow-right" aria-hidden="true"></i></a>
            </div>
        </div>
    </section>

    <section class="services-preview section-pad">
        <div class="container">
            <div class="section-heading">
                <div>
                    <div class="eyebrow eyebrow-dark"><span class="eyebrow-line"></span> What we do</div>
                    <h2>From first thought<br>to <span class="serif-accent">final detail.</span></h2>
                </div>
                <p>A connected set of capabilities to help your next chapter take shape.</p>
            </div>
            <div class="service-grid">
                <a class="service-card" href="{{ route('services') }}">
                    <span class="service-number">01 / BRAND</span>
                    <span class="service-icon"><i class="bi bi-layers" aria-hidden="true"></i></span>
                    <h3>Brand &amp; identity</h3>
                    <p>Clear positioning and expressive visual systems that feel unmistakably yours.</p>
                    <span class="card-arrow"><i class="bi bi-arrow-up-right" aria-hidden="true"></i></span>
                </a>
                <a class="service-card" href="{{ route('services') }}">
                    <span class="service-number">02 / DIGITAL</span>
                    <span class="service-icon"><i class="bi bi-window" aria-hidden="true"></i></span>
                    <h3>Web design</h3>
                    <p>Human-centered digital experiences, shaped around the people who use them.</p>
                    <span class="card-arrow"><i class="bi bi-arrow-up-right" aria-hidden="true"></i></span>
                </a>
                <a class="service-card" href="{{ route('services') }}">
                    <span class="service-number">03 / BUILD</span>
                    <span class="service-icon"><i class="bi bi-code-slash" aria-hidden="true"></i></span>
                    <h3>Web development</h3>
                    <p>Thoughtful, reliable Laravel builds that are as practical as they are polished.</p>
                    <span class="card-arrow"><i class="bi bi-arrow-up-right" aria-hidden="true"></i></span>
                </a>
            </div>
        </div>
    </section>

    <section class="cta-band">
        <div class="container cta-content">
            <div>
                <div class="eyebrow"><span class="eyebrow-line"></span> Your next chapter</div>
                <h2>Have something<br>good in mind?</h2>
            </div>
            <a class="btn btn-light-outline" href="{{ route('contact') }}">Start a conversation <i class="bi bi-arrow-up-right" aria-hidden="true"></i></a>
            <span class="cta-orbit" aria-hidden="true"><i class="bi bi-arrow-up-right"></i></span>
        </div>
    </section>
@endsection
