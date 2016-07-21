class UsersController < ApplicationController
  def fetch_by_inn
    @user = User.new
    @user.fill_requisites(params[:user][:inn])
    
    render 'show'
  end
  
  private

  def user_params
    params.require(:user).permit(:inn, :kpp, :ogrn, :name, :head, :init_date)
  end
end
