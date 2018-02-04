class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    user = User.find(params[:followed_id])
    current_user.follow(user)
    redirect_to user
    # The create action is called when 'user A' clicks on the button 'follow' on
    # 'user B's' page.  It follows the user, and then reloads the page using
    # the redirect_to(user) call
  end

  def destroy
    user = Relationship.find(params[:id]).followed
    current_user.unfollow(user)
    redirect_to user
  end
end
