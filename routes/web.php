<?php

use App\Http\Controllers\BusinessSiteController;
use Illuminate\Support\Facades\Route;

Route::get('/', [BusinessSiteController::class, 'home'])->name('home');
Route::get('/about', [BusinessSiteController::class, 'about'])->name('about');
Route::get('/services', [BusinessSiteController::class, 'services'])->name('services');
Route::get('/contact', [BusinessSiteController::class, 'contact'])->name('contact');
Route::post('/contact', [BusinessSiteController::class, 'sendMessage'])
    ->middleware('throttle:5,1')
    ->name('contact.send');
