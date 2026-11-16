<?php

namespace Tests\Feature;

use App\Models\ContactMessage;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class BusinessSiteTest extends TestCase
{
    use RefreshDatabase;

    public function test_all_public_pages_are_available(): void
    {
        foreach (['/', '/about', '/services', '/contact'] as $path) {
            $this->get($path)->assertOk();
        }
    }

    public function test_contact_form_stores_a_valid_message(): void
    {
        $response = $this->post('/contact', [
            'name' => 'Taylor Morgan',
            'email' => 'taylor@example.com',
            'company' => 'Example Studio',
            'service' => 'Web development',
            'message' => 'We would like to discuss a new business website.',
        ]);

        $response->assertRedirect('/contact');
        $response->assertSessionHas('success');
        $this->assertDatabaseHas('contact_messages', [
            'name' => 'Taylor Morgan',
            'email' => 'taylor@example.com',
            'company' => 'Example Studio',
            'service' => 'Web development',
        ]);
        $this->assertSame(1, ContactMessage::count());
    }

    public function test_contact_form_rejects_invalid_input_without_storing_a_message(): void
    {
        $this->from('/contact')->post('/contact', [
            'name' => '',
            'email' => 'not-an-email',
            'message' => 'Too short',
            'service' => 'Not a valid service',
        ])->assertRedirect('/contact')
            ->assertSessionHasErrors(['name', 'email', 'message', 'service']);

        $this->assertSame(0, ContactMessage::count());
    }
}
