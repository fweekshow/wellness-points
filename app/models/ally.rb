class Ally < ApplicationRecord
  belongs_to :user
  belongs_to :ally_user, class_name: 'User', optional: true
  
  validates :ally_email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :user_id, presence: true
  
  has_many :tasks, dependent: :destroy

  before_save :set_ally_user_id

  validate :ally_user_must_exist

  private

  def set_ally_user_id
    self.ally_user_id = User.find_by(email: ally_email)&.id
  end

  def ally_user_must_exist
    unless User.exists?(email: ally_email)
      errors.add(:ally_email, "must belong to a registered user")
    end
  end
end
