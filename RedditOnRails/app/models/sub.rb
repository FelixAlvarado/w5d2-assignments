# == Schema Information
#
# Table name: subs
#
#  id           :bigint(8)        not null, primary key
#  title        :string           not null
#  description  :text             not null
#  moderator_id :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Sub < ApplicationRecord

validates :title, :description, :moderator_id, presence: true
validates :title, uniqueness: {scope: :moderator_id}

belongs_to :moderator,
class_name: :User

has_many :post_subs,
primary_key: :id,
foreign_key: :sub_id,
class_name: :PostSub,
dependent: :destroy,
inverse_of: :cross_sub

has_many :posts

has_many :cross_posts,
through: :post_subs,
source: :post
end
