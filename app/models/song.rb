class Song < ApplicationRecord
    validates :title, presence: true
    validates :title, uniqueness: true
    validates :title, uniqueness: {scope: %i[release_year artist_name],
        message: "artist cannot release the same song twice in the same year"}
    
    validates :artist_name, presence: true

    with_options if: :released do |song|
        song.validates :release_year, presence: true
        song.validates :release_year, numericality: {
          less_than_or_equal_to: Time.now.year
        }
    end
end
