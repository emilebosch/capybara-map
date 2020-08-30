class ProfileMap < Map
  text :name, "a[href='/settings']"
  text :bio, ".bio"
  text :function, ".function"
  text :department, ".department"
  text :store, ".store"
  text :team, "a[href='/team?view=user']"
end
