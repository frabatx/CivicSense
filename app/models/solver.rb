class Solver < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :administration
  has_many :screams, dependent: :nullify
  accepts_nested_attributes_for :user
end
