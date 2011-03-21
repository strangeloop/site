# Provides a convenience method for simulating login via
# an administrative user (to get through the devise authentication)
module ControllerMacros
  def login_reviewer
    before(:each) do
      @request.env['devise.mapping'] = :admin
      sign_in Factory.create(:reviewer)
    end
  end
end
