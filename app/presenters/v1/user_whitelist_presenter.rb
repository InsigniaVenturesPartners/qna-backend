class V1::UserWhitelistPresenter < BasePresenter
  def initialize(user_whitelist, includes: [], context: {}, version: 1)
    super(user_whitelist, includes, context: context, version: version)
  end

  def as_json
    hash = {
      id: @resource.id,
      email: @resource.email,
      name: @resource.name,
      pro_pic_url: @resource.pro_pic_url,
      role: @resource.role,
    }

    hash
  end
end