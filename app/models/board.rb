# == Schema Information
#
# Table name: boards
#
#  id          :bigint           not null, primary key
#  author_name :string(255)
#  body        :text(65535)
#  title       :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Board < ApplicationRecord
    has_many :comments, dependent: :delete_all
    has_many :board_tag_relations, dependent: :delete_all
    has_many :tags, through: :board_tag_relations
    has_many_attached :images, dependent: :delete_all

    validates :title, presence: true, length: { maximum: 30 }
    validates :body, presence: true, length: { maximum: 1000}
end
