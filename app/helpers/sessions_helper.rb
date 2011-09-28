module SessionsHelper

  def sign_in(user)
    session[:user_id] = user.id
    session[:remember_token] = user.salt
    #cookies.permanent.signed[:remember_token] = [user.id, user.salt]
    self.current_user = user
  end

  def sign_out
    session[:user_id] = session[:remember_token] = nil
    #cookies.delete(:remember_token)
    self.current_user = nil
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= user_from_remember_token
  end

  def signed_in?
    !current_user.nil?
  end

  private

    def user_from_remember_token
      User.authenticate_with_salt(*remember_token)
    end

    def remember_token
      [session[:user_id], session[:remember_token]] || [nil, nil]
      #cookies.signed[:remember_token] || [nil, nil]
    end
end
