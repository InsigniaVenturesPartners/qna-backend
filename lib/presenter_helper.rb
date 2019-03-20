module PresenterHelper
  STR_V1 = "V1".freeze

  def init_presenter(resource, includes: [], context: {}, version: 1)
    Object.const_get("#{version_string(version.to_i)}::#{resource.class}Presenter").new(resource, includes: includes, context: context, version: version)
  end

  def presenter_json(resource, includes: [], context: {}, version: 1)
    return unless resource.present?
    init_presenter(resource, includes: includes, context: context, version: version).as_json
  end

  def each_serializer(resources, includes: [], context: {}, version: 1)
    return [] unless resources.present?
    resources.map { |r| presenter_json(r, includes: includes, context: context, version: version) }
  end

  private

  def version_string(num)
    case num
    when 1 then STR_V1
    else
      STR_V1
    end
  end
end