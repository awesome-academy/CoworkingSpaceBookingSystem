class VenuesController < ApplicationController
  before_action :corret_user, only: :destroy
  before_action :load_venue, only: [:show, :edit, :update]

  def new
    @venue = current_user.venues.build
    @venue.amenities.build
    @venue.build_address
  end

  def create
    @venue = current_user.venues.build venue_params
    if @venue.save
      flash[:info] = t ".add_venue_success"
      redirect_to venues_path
    else
      render :show
    end
  end

  def index; end

  def show; end

  def edit; end

  def update
    if @venue.update venue_params
      flash[:success] = t ".update_venue_success"
      redirect_to venue_path @venue
    else
      render :edit
    end
  end

  private

  def venue_params
    params.require(:venue).permit :name,
                                  amenities_attributes: [:id, :name, :_destroy],
                                  address_attributes: [:id, :name, :city]
  end

  def load_venue
    @venue = current_user.venues.find_by id: params[:id]
    return if @venue

    flash[:alert] = t ".venue_notexist"
    redirect_to root_path
  end

  def corret_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
