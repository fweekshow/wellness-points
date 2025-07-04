class PointTransaction < ApplicationRecord
  belongs_to :giver, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  
  validates :task, presence: true
  validates :points, presence: true, numericality: { greater_than: 0 }
  validates :giver_id, presence: true
  validates :receiver_id, presence: true
  validate :giver_cannot_be_receiver
  
  private
  
  def giver_cannot_be_receiver
    if giver_id == receiver_id
      errors.add(:base, "Giver cannot be the same as receiver")
    end
  end
end
