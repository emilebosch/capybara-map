reset!

visit "/"

a = LoginMap.all(page).first
a.name.set "manager@hello.com"
a.password.set ""
a.login
