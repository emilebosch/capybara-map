class CommentMap < Map
  text :body, "p"
  element :manager, ".label-primary"
  widget :like_button, ".mod-like-button", LikeButtonWidget
end
