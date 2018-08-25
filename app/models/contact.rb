class Contact < ApplicationRecord
  belongs_to :household, optional: true
  has_and_belongs_to_many :labels
  has_and_belongs_to_many :lists
  has_many :correspondences_from, -> { where from_type: "Contact"}, class_name: Correspondence, foreign_key: :from_id, foreign_type: :from_type
  has_many :correspondences_to, -> { where to_type: "Contact"}, class_name: Correspondence, foreign_key: :to_id, foreign_type: :to_type
  
  def correspondences
    Correspondence.where("(from_type = 'Contact' AND from_id = #{self.id}) OR (to_type = 'Contact' AND to_id = #{self.id})")
  end
end
