require 'spec_helper'

describe Proposal do
  it { should be_invalid }
   
  it { should validate_presence_of :speaker_name }

  it { should validate_presence_of :speaker_email }

  it { should validate_presence_of :title }

  it { should validate_presence_of :description }
end
