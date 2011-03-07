require 'spec_helper'

describe RelationalDragonflyStore do

  let(:dfly_store){ RelationalDragonflyStore.new }
  let(:obj){temp_object = Dragonfly::TempObject.new('Foo')}
  let(:uuid){dfly_store.store(obj)} 

  describe "Storing an image" do
    specify {dfly_store.store(obj).should_not be_nil}
  end
  
  describe "Retrieving an image" do
    specify {dfly_store.retrieve(uuid).should == ["Foo", {}]}
  end
  
  describe 'Retriving using the relational dragonfly store' do
    before {dfly_store.destroy(uuid)}
    specify{dfly_store.retrieve(uuid).should == [nil, {}]}
  end

end
  
