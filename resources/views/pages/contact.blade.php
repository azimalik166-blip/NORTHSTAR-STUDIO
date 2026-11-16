@extends('layouts.app')

@section('title', 'Contact')
@section('meta_description', 'Send Northstar Studio a message. This is a demo contact form for a fictional digital studio.')

@section('content')
    <section class="page-hero page-hero-contact">
        <div class="container page-hero-content">
            <div class="eyebrow"><span class="eyebrow-line"></span> Get in touch</div>
            <h1>Good things start<br><span>with a conversation.</span></h1>
            <p>Tell us a little about what you have in mind. We’ll take it from there.</p>
            <div class="breadcrumb-line"><a href="{{ route('home') }}">Home</a><i class="bi bi-chevron-right" aria-hidden="true"></i><span>Contact</span></div>
        </div>
    </section>

    <section class="contact-section section-pad">
        <div class="container contact-grid">
            <div class="contact-aside">
                <div class="eyebrow eyebrow-dark"><span class="eyebrow-line"></span> The first step</div>
                <h2>What’s on<br><span class="serif-accent">your mind?</span></h2>
                <p>This sample contact form is wired to Laravel validation and a MySQL database. Messages are stored for demonstration; configure your own database before launch.</p>
                <div class="contact-aside-note"><i class="bi bi-info-circle" aria-hidden="true"></i><span>Northstar Studio is a fictional portfolio demo, not a real business.</span></div>
                <div class="contact-decoration" aria-hidden="true"><i class="bi bi-compass-fill"></i></div>
            </div>
            <div class="contact-form-wrap">
                @if (session('success'))
                    <div class="alert alert-success" role="status">{{ session('success') }}</div>
                @endif
                @if ($errors->any())
                    <div class="alert alert-danger" role="alert">Please check the highlighted fields and try again.</div>
                @endif
                <form action="{{ route('contact.send') }}" method="POST" class="contact-form">
                    @csrf
                    <div class="row g-4">
                        <div class="col-md-6">
                            <label for="name" class="form-label">Your name <span>*</span></label>
                            <input id="name" name="name" value="{{ old('name') }}" type="text" class="form-control @error('name') is-invalid @enderror" autocomplete="name" required maxlength="120">
                            @error('name')<div class="invalid-feedback">{{ $message }}</div>@enderror
                        </div>
                        <div class="col-md-6">
                            <label for="email" class="form-label">Email address <span>*</span></label>
                            <input id="email" name="email" value="{{ old('email') }}" type="email" class="form-control @error('email') is-invalid @enderror" autocomplete="email" required maxlength="254">
                            @error('email')<div class="invalid-feedback">{{ $message }}</div>@enderror
                        </div>
                        <div class="col-md-6">
                            <label for="company" class="form-label">Company <span class="optional">(optional)</span></label>
                            <input id="company" name="company" value="{{ old('company') }}" type="text" class="form-control @error('company') is-invalid @enderror" autocomplete="organization" maxlength="160">
                            @error('company')<div class="invalid-feedback">{{ $message }}</div>@enderror
                        </div>
                        <div class="col-md-6">
                            <label for="service" class="form-label">I’m interested in</label>
                            <select id="service" name="service" class="form-select @error('service') is-invalid @enderror">
                                <option value="">Select a service</option>
                                @foreach (['Brand & web design', 'Web development', 'Digital strategy', 'Something else'] as $service)
                                    <option value="{{ $service }}" @selected(old('service') === $service)>{{ $service }}</option>
                                @endforeach
                            </select>
                            @error('service')<div class="invalid-feedback">{{ $message }}</div>@enderror
                        </div>
                        <div class="col-12">
                            <label for="message" class="form-label">A little about your project <span>*</span></label>
                            <textarea id="message" name="message" rows="5" class="form-control @error('message') is-invalid @enderror" placeholder="What are you working on? What would you like to achieve?" required minlength="20" maxlength="5000">{{ old('message') }}</textarea>
                            @error('message')<div class="invalid-feedback">{{ $message }}</div>@enderror
                        </div>
                        <div class="col-12 form-submit-row">
                            <span class="form-fine-print">Fields marked <span>*</span> are required.</span>
                            <button type="submit" class="btn btn-navy">Send your message <i class="bi bi-arrow-up-right" aria-hidden="true"></i></button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </section>
@endsection
