class Movie < ActiveRecord::Base
  def self.get_all_ratings
    Movie.all.map { |movie| movie[:rating] }.uniq.sort
  end
end
