class ItineraryPresenter < SimpleDelegator
  include ActionView::Helpers::DateHelper

  def avatar
    avatar_image
  end

  def start_loc
    locations&.origin&.address
  end

  def end_loc
    locations&.destination&.address
  end

  def eta
    distance_of_time_in_words(format(start_date), format(end_date))
  end

  def username
    user.username
  end

  def short_description
    self.description.truncate(45, separator: /\s/)
  end

  def is_owner?(user)
    user.id == self.user.id
  end

  def joinable?(user)
    self.is_owner?(user) ||
      self.attendees.map(&:user_id).include?(user.id) ||
      self.available_seat <= 0
  end

  private

  def format(date)
    Date.strptime(date, '%Y-%m-%d')
  end
end
