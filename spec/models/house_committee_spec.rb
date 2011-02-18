require 'spec_helper'

describe HouseCommittee do
  it { should have_many( :bills ) }
end
