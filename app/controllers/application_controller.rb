class ApplicationController < ActionController::Base
  #deviseコントローラが使われる前に適用されるメソッド
  before_action :configure_permitted_parameters, if: :devise_controller?
  #その前に動く、認証するユーザ、top以外除外。ログインしてないとtopページのみ表示
  before_action :authenticate_user!, except: [:top]
  #deviseメソッド。サインイン後の遷移先設定resourceとはcurrent_userと同義
  def after_sign_in_path_for(resource)
    post_images_path
  end
  
  def after_sign_out_path_for(resource)
    about_path
  end
  
  protected
  #上記のメソッドにより適用。nameでのログインが可能になる。
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
