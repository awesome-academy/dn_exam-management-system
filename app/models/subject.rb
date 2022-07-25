class Subject < ApplicationRecord
  belongs_to :user
  has_many :questions, dependent: :destroy
  accepts_nested_attributes_for :questions
  enum status: {inactive: 0, active: 1}, _default: 1
  validates :name, presence: true,
            length: {maximum: Settings.subject.name.max_50}
  validates :content, presence: true,
            length: {maximum: Settings.subject.content.max_1000}
  scope :recent_subjects, ->{order created_at: :desc}

  def self.question_count_lteq count
    return Subject.all if count.blank?

    Subject.includes(:questions).group("subjects.id")
           .having("COUNT(questions.id) <= #{count.to_i}").references(:questions)
  end

  ransacker :created_at, type: :date do
    Arel.sql("date(subjects.created_at)")
  end
end
