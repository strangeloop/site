require 'spec_helper'

describe RelationalDragonflyStore do

  let(:dfly_store){ RelationalDragonflyStore.new }
  let(:obj){temp_object = Dragonfly::TempObject.new('Foo')}
  let(:email_hash){Digest::MD5.hexdigest('foo@bar.com')}

  describe "Storing an image" do
    specify {dfly_store.store(obj, {:email => 'foo@bar.com'}) == email_hash}
  end
  
  describe "Retrieving an image" do
    before {dfly_store.store(obj, {:email => 'foo@bar.com'})}
    specify {dfly_store.retrieve(email_hash).should == ["Foo", {}]}
  end
  
  describe 'Retriving using the relational dragonfly store' do
    let!(:email_hash){dfly_store.store(obj, {:email => 'foo@bar.com'})}
    before {dfly_store.destroy(email_hash)}
    specify{dfly_store.retrieve(email_hash).should == [nil, {}]}
  end

end
  
