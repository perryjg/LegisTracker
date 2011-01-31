require 'spec_helper'

describe Sponsorship do
  it { should belong_to( :bill ) }
  it { should belong_to( :member ) }
end
