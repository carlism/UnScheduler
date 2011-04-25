class DomainsController < ApplicationController
  before_filter :authenticate_user!

  def destroy
    @domain = Domain.find(params[:id])
    @event = @domain.event
    if @domain.destroy
      flash[:notice] = "Successfully deleted domain."
    else
      flash[:alert] = "Failed to delete domain."
    end
  end

  def create
    @domain = Domain.new(params[:domain])
    if @domain.save
      @event = @domain.event
      flash[:notice] = "Successfully added #{@domain.domain}."
    else
      flash[:alert] = "Failed to create role."
    end
  end
end
