class Exam < ApplicationRecord
  belongs_to :machine
  has_many :trials, dependent: :destroy

  enum option: { draft: 0, published: 1, archived: 2, }
end
