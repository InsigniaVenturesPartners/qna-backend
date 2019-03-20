class V1::UserWhitelistPresenter < BasePresenter
  def initialize(user_whitelist, includes: [], context: {}, version: 1)
    super(user_whitelist, includes, context: context, version: version)
  end

  def as_json
    hash = {
      id: @resource.id,
      email: @resource.email,
    }

    hash
  end
end
