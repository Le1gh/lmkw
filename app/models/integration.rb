# frozen_string_literal: true

class Integration < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :type, uniqueness: { scope: :user_id }
end