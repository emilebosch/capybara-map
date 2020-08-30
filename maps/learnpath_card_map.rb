class LearnpathCardMap < Map
  element :name, "a"
  text :bio, ".panel-body"

  def self.css_name
    ".template-card"
  end
end
