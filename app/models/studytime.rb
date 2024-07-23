class Studytime < ApplicationRecord
    has_one_attached :image
    scope :today, -> { where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day) }
    #validates :user_id, {presence: true}

    attr_accessor :search_users

    def users
        return Studytime.find_by(id: self.id)
    end
    
end
