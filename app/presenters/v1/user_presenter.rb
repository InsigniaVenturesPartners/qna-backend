class V1::UserPresenter < BasePresenter
  def initialize(user, includes: [], context: {}, version: 1)
    super(user, includes, context: context, version: version)
  end

  def as_json
    hash = {
      id: @resource.id,
      email: @resource.email,
      name: @resource.display_name,
      pro_pic_url: @resource.pro_pic_url,
      role: @resource.role
    }

    hash
  end
end
