# == Schema Information
#
# Table name: posts
#
#  id         :bigint(8)        not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  sub_id     :integer          not null
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ApplicationRecord

  validates :title, :author_id, :sub_id, presence: true

  belongs_to :sub



  has_many :post_subs,
  primary_key: :id,
  foreign_key: :post_id,
  class_name: :PostSub,
  dependent: :destroy,
  inverse_of: :cross_post

  has_many :cross_subs,
  through: :post_subs,
  source: :sub

  belongs_to :author,
  class_name: :User
end
