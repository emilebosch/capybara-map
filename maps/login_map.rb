class LoginMap < Map
  element :name,     "#user_email"
  element :password, "#user_password"

  def login
    elm.click_button "Login"
  end
end