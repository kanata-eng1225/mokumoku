# frozen_string_literal: true

class Mypage::ProfilesController < Mypage::BaseController
  def show
    @user = current_user
  end

  def update
    # binding.pry
    @user = User.find(current_user.id)
    if @user.update(profile_params)
      # binding.pry
      redirect_to mypage_profile_path, success: 'プロフィールを更新しました'
    else
      render :show
    end
  end

  private

  def profile_params
    params.require(:user).permit(:name, :avatar, :hobby, :profile)
  end
end
