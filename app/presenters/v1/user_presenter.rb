class V1::UserPresenter < BasePresenter
  def initialize(user, includes: [], context: {}, version: 1)
    super(user, includes, context: context, version: version)
  end

  def as_json
    hash = {
      id: @resource.id,
      email: @resource.email,
    }

    hash
  end
end
