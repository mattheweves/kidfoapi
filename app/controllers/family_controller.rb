class FamilyController < ApplicationController
  include Base64Handler

  def create
    family = Family.create(family_params)#(:name => current_user.last_name)
    if family.valid?
      render json: family, status: :created
    else
      render json: render_errors(family), status: :unprocessable_entity
    end
  end

  def show
    family = Family.find(params[:id])
    render json: family.as_json(include: [:kids, :parents ])

  end

  def update
    @family = current_user.family
    if @family.update_attributes(convert_data_uri_to_upload(family_params))
      render json: @family.as_json(include: [:kids, :parents ])
    else
      render json: render_errors(@family), status: :unprocessable_entity
    end
  end

  private

  def family_params
    params.permit(:name, :image, :image_url, :physicianname, :physicianphone, :insuranceprovider, :health_ins_enrollee_id, :health_ins_group_num, :emerg_contact_1, :emerg_contact_1_phone, :emerg_contact_2, :emerg_contact_2_phone)
  end

end
