require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do
  describe "users#registrations action" do
    it "should create a user upon successful sign up" do
      post :create, params: { user: { first_name: 'Matt', last_name: 'Eves', password: 'password123', password_confirmation: 'password123' } }
      expect(response).to be_success
    end
  end
end
