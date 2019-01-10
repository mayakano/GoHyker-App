class EventsController < ApplicationController
  def index
    # @events = Event.search(params[:search_term])
  end

  def search
    results = Eventbrite::Event.search(
      {q: "#{params[:search_term]} #{params[:location]} #{params[:date]}"}, ENV["EVENTBRITE_TOKEN"]
      # {location.address: params[:search_term]}, ENV["EVENTBRITE_TOKEN"],
      # {start_date.keyword: params[:search_term]}, ENV["EVENTBRITE_TOKEN"]
    )
    @events = results.events
    if @events.nil?
      raise RuntimeError.new('results are nil!')
    end

    respond_to do |f|
      f.html {render q: params[:search_term]}
      f.json { render json: @events.to_json }
    end
    # render q: params[:search_term]
    # render location.address[:search_term]
    # render start_date.keyword[:search_term]
  end

  def self.search_events(search)
    if search
      event = Event.find_by(location: search)
      if events
        self.where(event_id: event)
      else
        Event.all
      end
    else
      Event.all
    end
  end

  private

  def event_params
    params.require(:event).permit(:location, :event_id, :search_term)
  end
end
