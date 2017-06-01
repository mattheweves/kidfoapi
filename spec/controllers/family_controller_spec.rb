require 'rails_helper'

RSpec.describe FamilyController, type: :controller do
  describe "family#create action" do
    before do
      @user = FactoryGirl.create(:user)
      @family = FactoryGirl.create(:family)
      put :update, params: { id: @user.id, user: { family_id: @family.id } }
    end

    it "should return 200 status code" do
        expect(response).to be_success
    end
  end
end
