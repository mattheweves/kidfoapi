class FamilyController < ApplicationController

  def create
    myfamily = current_user.build_family
    render status: :unprocessable_entity
  end

  def update
  end

  private

  def family_params
    params.require(:family).permit(:name, :avatar, :physicianname, :physicianphone, :insuranceprovider, :health_ins_enrollee_id, :health_ins_group_num, :emerg_contact_1, :emerg_contact_1_phone, :emerg_contact_2, :emerg_contact_2_phone)
  end

end
