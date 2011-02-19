class RolesController < ApplicationController
  before_filter :authenticate_user!

  def destroy
    @role = Role.find(params[:id])
    @event = @role.event
    @user = @role.user
    if @role.role_type != 'creator'
      if @role.destroy
        flash[:notice] = "Successfully deleted #{@user.email}."
      else
        flash[:alert] = "Failed to delete role."
      end
    else
      flash[:notice] = "You can't delete the event's creator"
    end
  end

  def create
    @role = Role.new(params[:role])
    @event = Event.find(@role.event_id)
    @new_admin = @event.roles.build(:role_type=>'admin')
    @user = User.find_by_email(params[:user][:email])
    if @user
      @role.user = @user
      if @role.save
        flash[:notice] = "Successfully added #{@user.email}."
      else
        flash[:alert] = "Failed to create role."
      end
    else
      flash[:alert] = "Could not find user #{params[:user][:email]}"
    end
  end
end
