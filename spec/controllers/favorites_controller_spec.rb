require 'rails_helper'

RSpec.describe FavoritesController, type: :controller do
  describe "favorites#create action" do
    before do
      @kid = FactoryGirl.create :kid, :person_bryar
      post :create, params: { favorite: { category: 'Activity', name: 'Swing', description: 'Put her in the ergo and SWING!!' }, kid_id: @kid.id }
    end

    it "should return 200 status code" do
        expect(response).to be_success
    end

    it "should successfully create and save a new tag in our database" do
      expect(@kid.favorites.first.name).to eq('Swing')
    end

  end

  describe "favorites#create action validations" do
    before do
      kid = FactoryGirl.create :kid, :person_goji
      post :create, params: { favorite: { name: '' }, kid_id: kid.id }
    end
    it "should properly deal with validation error" do
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "should return error json on validation errors" do
      json = JSON.parse(response.body)
      expect(json['errors']['name'][0]).to eq("can't be blank")
    end
  end

  describe "favorites#destroy action" do
    before do
      @kid = FactoryGirl.create :kid, :person_goji
      @favorite = FactoryGirl.create(:favorite, kid_id: @kid.id)
      delete :destroy, params: { id: @favorite.id }
    end
    it "should return 200 status-code" do
      expect(response).to be_success
    end

    it "should be removed from the database" do
      deleted_favorite = Favorite.find_by_id(@favorite.id)
      expect(deleted_favorite).to eq nil
    end
  end
end
