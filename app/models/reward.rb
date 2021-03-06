class Reward < ApplicationRecord
  validates :cost, :name, presence: true

  scope :active, -> { where(deactivated_at: nil) }

  def available?
    deactivated_at.nil? && inventory > 0
  end

  def restock
    update(inventory: 25, deactivated_at: nil)
  end
end
