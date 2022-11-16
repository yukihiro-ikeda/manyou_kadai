FactoryBot.define do
  factory :user do
    name { 'user1' }
    email { 'user1@example.com' }
    password { 'user1password' }
    password_confirmation { 'user1password' }
    admin {'false'}    
  end
    
  factory :second_user do
    name { 'user2' }
    email { 'user2@example.com' }
    password { 'user2password' }
    password_confirmation { 'user2password' }
    admin {'true'}
  end   
end
