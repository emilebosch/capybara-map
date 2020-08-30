class ActivityDom < Map
  text :name, ".panel-heading strong a"
  widget :like_button, ".panel-heading .mod-like-button", LikeButtonWidget
  widgets :comments, ".mod-comment", CommentWidget

  def comment(text)
    elm.fill_in "comment_body", with: text
    elm.find(".comment-textfield").native.send_keys(:enter)
  end
end
