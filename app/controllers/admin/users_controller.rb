class Admin::UsersController < PrivateController
  def index
    @users=User.all
  end
end
