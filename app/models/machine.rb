class Machine < ApplicationRecord
  has_many :exams, dependent: :destroy
  has_many :trials, dependent: :destroy
end
