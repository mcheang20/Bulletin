class Topic < ActiveRecord::Base
    belongs_to :user
    has_many :posts, dependent: :destroy
    has_many :labelings, as: :labelable
    has_many :labels, through: :labelings

    scope :visible_to, -> (user) { user ? all : where(public: true) }

    def self.search(search)
        where("name LIKE ? OR description LIKE ?", "%#{search}%", "%#{search}%")
    end
end
