Factory.define :user do |f|
  f.login 'admin'
  f.email 'admin@theconference.com'
  f.password 'secret'
  f.password_confirmation {|u| u.password }
end

Factory.define :admin, :parent => :user do |admin|
  admin.after_create {|a| a.roles << Factory(:role)}
end

