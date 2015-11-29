module StorePerformancesHelper

  def active_class(filter, link_name)
    filter == link_name ? "active" : ""
  end

  def link_for_filter(filter, link_name)
    content_tag :dd, class: active_class(filter, link_name) do 
      link_to link_name.capitalize, store_performance_path(filter: link_name)
    end
  end

end