module MySpecHelper
def login_user
  @request.env["devise.mapping"]   = Devise.mappings[:user]
   user = Fabricate(:admin)
   sign_in user
 end
end