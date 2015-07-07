class LikeButtonMap < Map
  text :count, ".count"

  def like
    elm.click_link "Like"
  end

  def unlike
    elm.click_link "Unlike"
  end
end