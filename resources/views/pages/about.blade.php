@extends('layouts.app')

@section('title', 'About the studio')
@section('meta_description', 'Learn about Northstar Studio, a fictional independent digital studio and portfolio demo project.')

@section('content')
    <section class="page-hero page-hero-about">
        <div class="container page-hero-content">
            <div class="eyebrow"><span class="eyebrow-line"></span> About the studio</div>
            <h1>Small enough to care.<br><span>Curious enough to ask.</span></h1>
            <p>We’re a fictional creative and technology studio with a real appreciation for thoughtful work and good collaboration.</p>
            <div class="breadcrumb-line"><a href="{{ route('home') }}">Home</a><i class="bi bi-chevron-right" aria-hidden="true"></i><span>About</span></div>
        </div>
    </section>

    <section class="about-story section-pad">
        <div class="container about-story-grid">
            <div class="story-image" role="img" aria-label="Warm, light-filled studio with work table and plants">
                <div class="story-image-label"><i class="bi bi-compass-fill" aria-hidden="true"></i> A point of view, not a playbook.</div>
            </div>
            <div class="story-copy">
                <div class="eyebrow eyebrow-dark"><span class="eyebrow-line"></span> Why Northstar</div>
                <h2>Make it matter.<br><span class="serif-accent">Make it human.</span></h2>
                <p>Northstar is a sample studio concept for this portfolio project. It’s inspired by a belief that the best business websites don’t shout; they make it easy to understand who you are, what you do and what comes next.</p>
                <p>From the first discovery call to the final line of code, our imagined process balances thoughtful strategy with useful, beautifully executed digital craft.</p>
                <a class="text-link text-link-dark" href="{{ route('services') }}">See what we can do <i class="bi bi-arrow-right" aria-hidden="true"></i></a>
            </div>
        </div>
    </section>

    <section class="principles-section section-pad">
        <div class="container">
            <div class="section-heading">
                <div>
                    <div class="eyebrow eyebrow-dark"><span class="eyebrow-line"></span> How we think</div>
                    <h2>Good principles.<br><span class="serif-accent">Better decisions.</span></h2>
                </div>
                <p>A few ideas that guide how this fictional studio approaches every project.</p>
            </div>
            <div class="principle-grid">
                <article class="principle-card"><span>01</span><h3>Listen before making</h3><p>Understand the people, the problem and the opportunity before reaching for a solution.</p></article>
                <article class="principle-card"><span>02</span><h3>Keep it clear</h3><p>Make every design choice and every interaction feel useful, intuitive and considered.</p></article>
                <article class="principle-card"><span>03</span><h3>Build with care</h3><p>Pair a strong visual idea with accessible, responsive and maintainable development.</p></article>
            </div>
        </div>
    </section>

    <section class="cta-band">
        <div class="container cta-content">
            <div>
                <div class="eyebrow"><span class="eyebrow-line"></span> Good things start somewhere</div>
                <h2>Tell us what<br>you’re thinking.</h2>
            </div>
            <a class="btn btn-light-outline" href="{{ route('contact') }}">Get in touch <i class="bi bi-arrow-up-right" aria-hidden="true"></i></a>
            <span class="cta-orbit" aria-hidden="true"><i class="bi bi-arrow-up-right"></i></span>
        </div>
    </section>
@endsection
