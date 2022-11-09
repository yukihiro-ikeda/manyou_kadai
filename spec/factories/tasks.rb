FactoryBot.define do
  factory :task do
    name { 'name1' }
    detail { 'detail1' }
    status { '未着手' }
    expired_at { '2022/12/31' }
  end
  factory :second_task, class: Task do
    name { 'name2' }
    detail { 'detail2' }
    status { '完了' }
    expired_at { '2022/11/30' }
  end
end
