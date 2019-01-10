class ItinerariesController < ApplicationController
  skip_before_action :authorize, only: :index
  before_action :set_itinerary, only: [:show, :edit, :update, :destroy]

  # GET /itineraries
  # GET /itineraries.json
  def index
    @itineraries = Itinerary.all.order(:start_date)
    respond_to do |format|
      format.html do
        @itineraries = @itineraries.map{ |i| ::ItineraryPresenter.new(i) }
        @itineraries = build_pagination(@itineraries)
      end
      format.json do
        render json: {
          itineraries: @itineraries.map do |itinerary|
            {
              properties: {
                id: itinerary.id,
                start_date: itinerary.start_date,
                end_date: itinerary.end_date,
                available_seat: itinerary.available_seat,
                description: itinerary.description,
                user: itinerary.user,
                start_loc: itinerary.locations.where(is_origin: true).first.address,
                end_loc: itinerary.locations.where(is_origin: false).first.address,
                eta:  helpers.distance_of_time_in_words(format(itinerary.start_date), format(itinerary.end_date)),
              }
            }
          end
         }
      end
    end
end


  # GET /itineraries/1
  # GET /itineraries/1.json
  def show
    @itinerary = ::ItineraryPresenter.new(@itinerary)
  end

  # GET /itineraries/new
  def new
    @itinerary = Itinerary.new
  end

  # GET /itineraries/1/edit
  def edit
  end
  # POST /itineraries
  # POST /itineraries.json
  def create
    @itinerary = Itinerary.new(itinerary_params)
    @start_loc = Location.create(address: params[:start_loc], is_origin: true, itinerary_id: @itinerary.id)
    @end_loc = Location.create(address: params[:end_loc], is_origin: false, itinerary_id: @itinerary.id)
    @itinerary.locations.push(@start_loc)
    @itinerary.locations.push(@end_loc)

    respond_to do |format|
      if @itinerary.save
        format.html { redirect_to @itinerary, notice: 'Itinerary was successfully created.' }
        format.json { render :show, status: :created, location: @itinerary }

        # origin = @itinerary.locations.new( address: params[:origin], is_origin: true )
        # origin.get_coords

        # destination = @itinerary.locations.new( address: params[:destination], is_origin: false )
        # destination.get_coords

      else
        format.html { render :new }
        format.json { render json: @itinerary.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /itineraries/1
  # PATCH/PUT /itineraries/1.json
  def update
    respond_to do |format|
      if @itinerary.update(itinerary_params)
        format.html { redirect_to @itinerary, notice: 'Itinerary was successfully updated.' }
        format.json { render :show, status: :ok, location: @itinerary }

        if params[:origin]
          @itinerary.locations[0].address = params[:origin]
          @itinerary.locations[0].get_coords
        end
        if params[:destination]
          @itinerary.locations[0].address = params[:destination]
          @itinerary.locations[0].get_coords
        end

      else
        format.html { render :edit }
        format.json { render json: @itinerary.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /itineraries/1
  # DELETE /itineraries/1.json
  def destroy
    @itinerary.destroy
    respond_to do |format|
      format.html { redirect_to itineraries_url, notice: 'Itinerary was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_itinerary
    @itinerary = Itinerary.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def itinerary_params
    params.require(:itinerary).permit(:start_date, :end_date, :available_seat, :projected_eta, :description, :user_id, :avatar_image)
  end
end

