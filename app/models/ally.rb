class Ally < ApplicationRecord
  belongs_to :user
  belongs_to :ally_user, class_name: 'User', optional: true
  
  validates :ally_email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :user_id, presence: true
  
  has_many :tasks, dependent: :destroy

  before_save :set_ally_user_id

  private

  def set_ally_user_id
    self.ally_user_id = User.find_by(email: ally_email)&.id
  end
end
