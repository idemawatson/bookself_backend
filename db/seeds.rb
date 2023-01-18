users = [
  ["user1", "aaa@example.com", "sub1"],
  ["user2", "bbb@example.com", "sub2"]
]

users.each do |name, email, sub|
  User.create(name: name, email: email, sub: sub)
end
