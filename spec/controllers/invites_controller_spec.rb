require 'rails_helper'
require 'spec_helper'

RSpec.describe InvitesController, type: :controller do

  describe "invites#create action" do
    before do
      # Sign in as a user.
      sign_in_as_a_valid_user
      post :create, params: { invite: { invite_kind: 'for_spouse', email: 'invite@kidfo.com' } }
    end
    it "should return 200 status-code" do
      expect(response).to be_success
    end

    # it "should successfully save and create a Kid in the db" do
    #   kid = Kid.last
    #   expect(kid.name).to eq('Bryar Louise')
    #   expect(kid.gender).to eq('Female')
    # end
    #
    # it "should return the created note in the repsonse body" do
    #   json = JSON.parse(response.body)
    #   expect(json['name']).to eq('Bryar Louise')
    #   expect(json['gender']).to eq('Female')
    # end
  end

end
