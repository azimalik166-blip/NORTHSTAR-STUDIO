<?php

namespace App\Http\Controllers;

use App\Models\ContactMessage;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\View\View;

class BusinessSiteController extends Controller
{
    public function home(): View
    {
        return view('pages.home');
    }

    public function about(): View
    {
        return view('pages.about');
    }

    public function services(): View
    {
        return view('pages.services');
    }

    public function contact(): View
    {
        return view('pages.contact');
    }

    public function sendMessage(Request $request): RedirectResponse
    {
        $validated = $request->validate([
            'name' => ['required', 'string', 'max:120'],
            'email' => ['required', 'email:rfc', 'max:254'],
            'company' => ['nullable', 'string', 'max:160'],
            'service' => ['nullable', 'string', 'in:Brand & web design,Web development,Digital strategy,Something else'],
            'message' => ['required', 'string', 'min:20', 'max:5000'],
        ]);

        ContactMessage::create($validated);

        return to_route('contact')->with('success', 'Thanks for reaching out. Your message has been received.');
    }
}
