class Topic < ActiveRecord::Base
    belongs_to :user
    has_many :posts, dependent: :destroy
    has_many :labelings, as: :labelable
    has_many :labels, through: :labelings

    scope :visible_to, -> (user) { user ? all : where(public: true) }

    validates :name, presence: true
    validates :description, length: { minimum: 20 }, presence: true
    validates :user, presence: true

    def self.search(search)
        where("name ILIKE ? OR description ILIKE ?", "%#{search}%", "%#{search}%")
    end
end
