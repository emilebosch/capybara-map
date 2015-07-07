# Map

An attempt to bring a bit of structure in capybara testing, by synchronizing
conventions on partials naming, css naming, and accessing models from the DOM.

This is handy when you have complicated dom object such as activity feeds that you need
to have tested.

Instead of doing complicated capybara stuff you can now just do.

```
activity = AcitivtyDom.first
comment = activity.comments.first
commment.body.should "This is my fluffy cat."
comment.like!
```

In this case the map for this looks like:

```
class ActivityDom < Map
  text    :name,         ".panel-heading strong a"
  widget  :like_button,  ".panel-heading .mod-like-button", LikeButtonWidget
  widgets :comments,     ".mod-comment", CommentWidget

  def comment(text)
    elm.fill_in "comment_body", with: text
    elm.find(".comment-textfield").native.send_keys(:enter)
  end
end
```

As you can see it embeds a couple of other maps, the like and the comment widget:

```
class CommentMap < Map
  text     :body,        "p"
  element  :manager,     ".label-primary"
  widget   :like_button, ".mod-like-button", LikeButtonWidget
end
```

and 

```
class LikeButtonMap < Map
  text :count, ".count"

  def like
    elm.click_link "Like"
  end

  def unlike
    elm.click_link "Unlike"
  end
end
```

By using these maps you can easily access your DOM and perform operations on them.

## Conventions

## To run

```
bundle
bundle exec ruby test.rb
```

## Mapping

