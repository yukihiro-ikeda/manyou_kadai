User.create!(name: "test1", email: "test1@sample.com", password: "testsample", password_confirmation: "testsample", admin: true )
User.create!(name: "test2", email: "test2@sample.com", password: "testsample", password_confirmation: "testsample", admin: false )
User.create!(name: "test3", email: "test3@sample.com", password: "testsample", password_confirmation: "testsample", admin: false )
User.create!(name: "test4", email: "test4@sample.com", password: "testsample", password_confirmation: "testsample", admin: false )
User.create!(name: "test5", email: "test5@sample.com", password: "testsample", password_confirmation: "testsample", admin: false )
User.create!(name: "test6", email: "test6@sample.com", password: "testsample", password_confirmation: "testsample", admin: true )
User.create!(name: "test7", email: "test7@sample.com", password: "testsample", password_confirmation: "testsample", admin: false )
User.create!(name: "test8", email: "test8@sample.com", password: "testsample", password_confirmation: "testsample", admin: false )
User.create!(name: "test9", email: "test9@sample.com", password: "testsample", password_confirmation: "testsample", admin: false )
User.create!(name: "test10", email: "test10@sample.com", password: "testsample", password_confirmation: "testsample", admin: false )

User.all.each do |user|
  Task.create!(user_id: user.id, name: "test11", detail: "test11", status: "着手中", priority: "低", expired_at: "002022/11/21")
end

User.all.each do |user|
  Task.create!(user_id: user.id, name: "test12", detail: "test12", status: "未着手", priority: "高", expired_at: "002022/11/22")
end

User.all.each do |user|
  Task.create!(user_id: user.id, name: "test13", detail: "test13", status: "着手中", priority: "低", expired_at: "002022/11/23")
end

User.all.each do |user|
  Task.create!(user_id: user.id, name: "test14", detail: "test14", status: "完成", priority: "高", expired_at: "002022/11/24")
end

User.all.each do |user|
  Task.create!(user_id: user.id, name: "test15", detail: "test15", status: "着手中", priority: "中", expired_at: "002022/11/25")
end

User.all.each do |user|
  Task.create!(user_id: user.id, name: "test16", detail: "test16", status: "着手中", priority: "中", expired_at: "002022/11/26")
end

User.all.each do |user|
  Task.create!(user_id: user.id, name: "test17", detail: "test17", status: "完成", priority: "低", expired_at: "002022/11/27")
end

User.all.each do |user|
  Task.create!(user_id: user.id, name: "test18", detail: "test18", status: "着手中", priority: "高", expired_at: "002022/11/28")
end

User.all.each do |user|
  Task.create!(user_id: user.id, name: "test19", detail: "test19", status: "未着手", priority: "低", expired_at: "002022/11/29")
end

User.all.each do |user|
  Task.create!(user_id: user.id, name: "test20", detail: "test20", status: "着手中", priority: "高", expired_at: "002022/11/30")
end

Label.create!(name: "test1") 
Label.create!(name: "example1")
Label.create!(name: "example2")
Label.create!(name: "example3")
Label.create!(name: "example4")
Label.create!(name: "example5")
Label.create!(name: "example6")
Label.create!(name: "example7")
Label.create!(name: "example8")
Label.create!(name: "example9")