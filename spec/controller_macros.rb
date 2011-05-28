# Provides a convenience method for simulating login via
# an administrative user (to get through the devise authentication)
module ControllerMacros
  def login_admin
    before(:each) do
      @request.env['devise.mapping'] = :admin
      sign_in Factory.create(:admin)
    end
  end

  def login_organizer
    before(:each) do
      @request.env['devise.mapping'] = :admin
      sign_in Factory.create(:organizer)
    end
  end

  def login_reviewer
    before(:each) do
      @request.env['devise.mapping'] = :admin
      sign_in Factory.create(:reviewer)
    end
  end  
end


