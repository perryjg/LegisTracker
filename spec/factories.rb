FactoryGirl.define do
  factory :bill do
    btype 'HB'
    num '1'
    number 'HB1'
    short_title 'A Makebelieve Bill'
    title 'A BILL to be entitled A Make Beleive Bill which does absolutely nothing'
    b_status 'House Passed/Adopted'
    status_code_id 'HPA'
  end

  factory :vote do
    house 'H'
    date '2011-01-10 12:00:00'
    bill_type 'HB'
    num 1
    description 'PASS'
    yea 100
    nay 80
    association :bill
  end
  
  factory :status do
    status_date '2011-01-10 12:00:00'
    status_code_id 'HPF'
    association :bill
    association :status_code
  end
  
  factory :status_code do
    description 'House Prefiled'
    house 'H'
    seq 1
  end
  
  factory :senate_feed do
    title Faker::Lorem.sentence
    summary Faker::Lorem.paragraph
    author Faker::Name.name
    url 'http://www.senate-press.com/?p=1789'
    published_at '2011-01-15 19:07:15'
    guid 'http://www.senate-press.com/?p=1789'
  end
  
  factory :house_feed do
    title Faker::Lorem.sentence
    summary Faker::Lorem.paragraph
    author Faker::Name.name
    url 'http://www.house-press.com/?p=1789'
    published_at '2011-01-15 19:07:15'
    guid 'http://www.house-press.com/?p=1789'
  end
end
