class FamilyController < ApplicationController

  def create
    myfamily = Family.create(:name => current_user.last_name)
    current_user.update_attributes(:family_id => myfamily.id)
  end

  def update
  end

  private

  def family_params
    params.require(:family).permit(:name, :avatar, :physicianname, :physicianphone, :insuranceprovider, :health_ins_enrollee_id, :health_ins_group_num, :emerg_contact_1, :emerg_contact_1_phone, :emerg_contact_2, :emerg_contact_2_phone)
  end

end
