class Experience
  attr_accessor :id
  attr_accessor :description
  attr_accessor :extra_info
  attr_accessor :created_at
  attr_accessor :reasons

  def good_experience?
    description == "good"
  end

  def bad_experience?
    description == "bad"
  end
end

class Reason
  attr_accessor :description
end