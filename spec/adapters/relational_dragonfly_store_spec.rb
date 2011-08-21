#- Copyright 2011 Strange Loop LLC
#-
#- Licensed under the Apache License, Version 2.0 (the "License");
#- you may not use this file except in compliance with the License.
#- You may obtain a copy of the License at
#-
#-    http://www.apache.org/licenses/LICENSE-2.0
#-
#- Unless required by applicable law or agreed to in writing, software
#- distributed under the License is distributed on an "AS IS" BASIS,
#- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#- See the License for the specific language governing permissions and
#- limitations under the License.
#-



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

