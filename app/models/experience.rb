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

  def from_today?
    created_at.day == Time.now().day
  end

  def from_yesterday?
    created_at.day == Time.now().day - 1.day
  end
end

class Reason
  attr_accessor :description
end