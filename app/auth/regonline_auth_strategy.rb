Warden::Strategies.add(:regonline) do 
  def valid? 
    return true
  end 

  def authenticate!
    u = User.authenticate_user(params[:username], params[:password], "849922")
    u.nil? ? fail!("Could not log in") : success!(u)
  end 
end 
