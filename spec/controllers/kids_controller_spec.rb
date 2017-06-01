require 'rails_helper'

RSpec.describe KidsController, type: :controller do
  describe "kids#index action" do
    it "should successfully respond" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "should return all Kids in ascending Name order" do
      FactoryGirl.create :kid, :person_bryar
      FactoryGirl.create :kid, :person_goji
      get :index
      json = JSON.parse(response.body)
      expect(json[0]['name'] < json[1]['name']).to be true
    end

    it "should return all Kids in ascending Birth order" do
      FactoryGirl.create :kid, :person_bryar
      FactoryGirl.create :kid, :person_goji
      get :index
      json = JSON.parse(response.body)
      expect(json[0]['birthdate'] < json[1]['birthdate']).to be false
    end

    it "should return associated favorites to kid in response" do
      kid = FactoryGirl.create :kid, :person_bryar
      favorite = FactoryGirl.create(:favorite, kid_id: kid.id)
      get :index
      json = JSON.parse(response.body)
      expect(json[0]['favorites'][0]['name']).to eq(favorite.name)
    end

  end

  describe "kids#create action" do
    before do
      post :create, params: { kid: { name: 'Bryar Louise', gender: 'Female' } }
    end
    it "should return 200 status-code" do
      expect(response).to be_success
    end

    it "should successfully save and create a Kid in the db" do
      kid = Kid.last
      expect(kid.name).to eq('Bryar Louise')
      expect(kid.gender).to eq('Female')
    end

    it "should return the created note in the repsonse body" do
      json = JSON.parse(response.body)
      expect(json['name']).to eq('Bryar Louise')
      expect(json['gender']).to eq('Female')
    end
  end

  describe "kids#create action validations" do
    before do
      post :create, params: { kid: { name: '' } }

    end
    it "should properly deal with validation errors" do
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "should return error json on validation errors" do
      json = JSON.parse(response.body)
      expect(json["errors"]["name"][0]).to eq("can't be blank")
    end
  end

  describe "kids#show action" do
    before do
      @kid = FactoryGirl.create :kid, :person_bryar
    end
    it "should return a kid" do
      get :show, params: { id: @kid.id }
      json = JSON.parse(response.body)
      expect(json['id']).to eq(@kid.id)
    end

    it "should return associated favorites in response" do
      favorite = FactoryGirl.create(:favorite, kid_id: @kid.id)
      get :show, params: { id: @kid.id }
      json = JSON.parse(response.body)
      expect(json['favorites'][0]['name']).to eq(favorite.name)
    end
  end

  describe "kids#update action" do
    before do
      @kid = FactoryGirl.create :kid, :person_bryar
    end
    it "should receive the updated kid in the response" do
      put :update, params: { id: @kid.id, kid: { allergies: 'Peas' } }
      json = JSON.parse(response.body)
      expect(json['allergies']).to eq('Peas')
      expect(response).to be_success
    end

    it "should properly deal with validation errors" do
      put :update, params: { id: @kid.id, kid: { name: '' } }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "should return error json on validation errors" do
      put :update, params: { id: @kid.id, kid: { name: '' } }
      json = JSON.parse(response.body)
      expect(json["errors"]["name"][0]).to eq("can't be blank")
    end
  end

  describe "kids#destroy action" do
    before do
      @kid = FactoryGirl.create :kid, :person_bryar
      delete :destroy, params: { id: @kid.id }
    end

    it "should destroy a saved note" do
      kid = Kid.find_by_id(@kid.id)
      expect(kid).to eq nil
    end

    it "should return a no_content status" do
      expect(response).to have_http_status(:no_content)
    end
  end


end
