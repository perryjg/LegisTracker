FactoryGirl.define do
  factory :bill do
    btype 'HB'
    num '1'
    number 'HB1'
    short_title 'A Makebelieve Bill'
    title 'A BILL to be entitled A Make Beleive Bill which does absolutely nothing'
    bStatus 'House Passed/Adopted'
    statusCode 'HPA'
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
    statusDate '2011-01-10 12:00:00'
    status_code_id 'HPF'
    association :bill
    association :status_code
  end
  
  factory :status_code do
    description 'House Prefiled'
    house 'H'
    seq 1
  end
end