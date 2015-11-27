module StoresHelper

  def format_filter_names(range_filter, quality_filter)
    range = range_filter ? range_filter : "anytime"
    quality = quality_filter ? quality_filter : "all"
    Rails.logger.info("\n\n **** quality: #{quality}\n\n")
    "Showing #{[range, quality].join(" | ")} experiences"
  end
end