class SearchMap < Map
  element  :search_field,     "input"

  def search(text)
    search_field.set text
  end
end