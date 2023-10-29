class Trial < ApplicationRecord
  belongs_to :machine
  belongs_to :exam
  belongs_to :user

  scope :correct, -> { where(correctness: true) }
  scope :faulty, -> { where(correctness: false) }

end
