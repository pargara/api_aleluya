# frozen_string_literal: true

class Company < ApplicationRecord
  belongs_to :user
  has_many :payroll_periods, dependent: :destroy

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :mail, presence: true
  validates :phone, length: { maximum: 10 }
end
