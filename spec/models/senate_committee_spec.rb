require 'spec_helper'

describe SenateCommittee do
  it { should have_many( :bills ) }
end
