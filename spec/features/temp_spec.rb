require 'rails_helper'


RSpec.describe "simple test", :type => :request do
#describe 'A useless blog', :type => :request do

  describe "simple expect" do
    specify { expect(3).to eq(3) }
    specify { expect(3).not_to eq(4) }
  end


end
