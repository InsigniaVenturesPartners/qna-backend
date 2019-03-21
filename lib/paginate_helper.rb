module PaginateHelper
  PER_PAGE = 25
  # Collection is will_paginate collection
  # https://github.com/mislav/will_paginate/blob/master/lib%2Fwill_paginate%2Fcollection.rb
  #
  # Returns hash
  # { previos: link, next: link }
  def paginate_links(collection)
    previous_link = collection.previous_page ? url_builder(page: collection.previous_page) : nil
    next_link = collection.next_page ? url_builder(page: collection.next_page) : nil
    {previous: previous_link, next: next_link}
  end

  def url_builder(params = {})
    url = request.original_url.sub(/\?.*$/, '')
    new_params = request.query_parameters.merge(params)
    %(#{url}?#{new_params.to_param})
  end

  def pagination_params
    { page: params[:page], per_page: params[:per_page] || PER_PAGE }
  end
end