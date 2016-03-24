class Post < ActiveRecord::Base
    belongs_to :topic
    has_many :comments, dependent: :destroy
    belongs_to :user
    default_scope { order('created_at DESC') }

    validates :title, length: { minimum: 5 }, presence: true
    validates :body, length: { minimum: 20 }, presence: true
    validates :topic, presence: true
    validates :user, presence: true
end
