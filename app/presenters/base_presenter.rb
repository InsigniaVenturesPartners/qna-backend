class BasePresenter
  include PresenterHelper

  attr_accessor :includes, :resource, :context, :version

  def initialize(resource, includes, context: {}, version: 1)
    @resource = resource
    @includes = includes
    @context = context
    @version = version
  end
end