class Administration < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :screams, dependent: :delete_all
  has_many :solvers, dependent: :delete_all
  accepts_nested_attributes_for :user
end
