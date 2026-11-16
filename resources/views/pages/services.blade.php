@extends('layouts.app')

@section('title', 'Services')
@section('meta_description', 'Explore brand strategy, web design and Laravel web development services in this fictional studio portfolio demo.')

@section('content')
    <section class="page-hero page-hero-services">
        <div class="container page-hero-content">
            <div class="eyebrow"><span class="eyebrow-line"></span> What we do</div>
            <h1>Clarity in the thinking.<br><span>Care in the making.</span></h1>
            <p>Strategy, design and development, working together to make your digital next step a little clearer.</p>
            <div class="breadcrumb-line"><a href="{{ route('home') }}">Home</a><i class="bi bi-chevron-right" aria-hidden="true"></i><span>Services</span></div>
        </div>
    </section>

    <section class="services-list-section section-pad">
        <div class="container">
            <div class="service-detail">
                <div class="detail-index">01</div>
                <div class="detail-main">
                    <span class="detail-kicker">Find your footing</span>
                    <h2>Brand strategy<br>&amp; identity</h2>
                    <p>Build a stronger foundation for how your business shows up. Together, we find the story, voice and visual direction that feel true to you.</p>
                    <ul class="detail-list"><li>Discovery &amp; positioning</li><li>Visual identity systems</li><li>Brand voice &amp; messaging</li></ul>
                </div>
                <div class="detail-icon"><i class="bi bi-layers" aria-hidden="true"></i></div>
            </div>
            <div class="service-detail">
                <div class="detail-index">02</div>
                <div class="detail-main">
                    <span class="detail-kicker">Make a better first impression</span>
                    <h2>Digital design<br>&amp; experience</h2>
                    <p>Turn complex ideas into intuitive, welcoming digital experiences that give your audience a clear path forward.</p>
                    <ul class="detail-list"><li>Website strategy &amp; structure</li><li>User experience &amp; interface design</li><li>Responsive design systems</li></ul>
                </div>
                <div class="detail-icon"><i class="bi bi-window" aria-hidden="true"></i></div>
            </div>
            <div class="service-detail">
                <div class="detail-index">03</div>
                <div class="detail-main">
                    <span class="detail-kicker">Bring the idea to life</span>
                    <h2>Web development<br>&amp; support</h2>
                    <p>Go from beautiful designs to dependable, maintainable websites, built with modern tools and the right details in place.</p>
                    <ul class="detail-list"><li>Laravel &amp; PHP development</li><li>CMS &amp; database integration</li><li>Accessibility, testing &amp; launch</li></ul>
                </div>
                <div class="detail-icon"><i class="bi bi-code-slash" aria-hidden="true"></i></div>
            </div>
        </div>
    </section>

    <section class="process-section section-pad">
        <div class="container">
            <div class="section-heading">
                <div>
                    <div class="eyebrow"><span class="eyebrow-line"></span> A thoughtful process</div>
                    <h2>Clear steps.<br><span>Room to explore.</span></h2>
                </div>
                <p>Every project finds its own rhythm, but good collaboration starts with a little structure.</p>
            </div>
            <div class="process-grid">
                <article><span>01 / DISCOVER</span><h3>Start with listening</h3><p>We get to know your goals, your audience and what success looks like.</p></article>
                <article><span>02 / CREATE</span><h3>Make it together</h3><p>We explore directions, share early work and refine around what matters.</p></article>
                <article><span>03 / DELIVER</span><h3>Make it real</h3><p>We build, test and prepare your new digital experience to meet the world.</p></article>
            </div>
        </div>
    </section>

    <section class="cta-band">
        <div class="container cta-content">
            <div>
                <div class="eyebrow"><span class="eyebrow-line"></span> Made it this far?</div>
                <h2>Let’s talk about<br>what’s next.</h2>
            </div>
            <a class="btn btn-light-outline" href="{{ route('contact') }}">Start a conversation <i class="bi bi-arrow-up-right" aria-hidden="true"></i></a>
            <span class="cta-orbit" aria-hidden="true"><i class="bi bi-arrow-up-right"></i></span>
        </div>
    </section>
@endsection
