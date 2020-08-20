class Game < ApplicationRecord
  has_many :images, dependent: :destroy
  belongs_to :user
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true

  def self.search(search)
    if search
      Game.where('name LIKE(?)', "%#{search}%")
    else
      Game.all
    end
  end
end
