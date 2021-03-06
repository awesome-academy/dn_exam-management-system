class Question < ApplicationRecord
  belongs_to :subject
  has_many :answers, dependent: :destroy
  has_many :exam_details, dependent: :destroy
  has_many :exams, through: :exam_details
  enum question_type: {single_select: 0, multiple_select: 1,
                       essay_question: 2}, _default: 0
  enum status: {inactive: 0, active: 1}, _default: 1

  accepts_nested_attributes_for :answers, allow_destroy: true,
                                reject_if: proc{|att| att["content"].blank?}
  validates :content, presence: true,
            length: {maximum: Settings.question.content.max_1000}
  scope :recent_questions, ->{order created_at: :desc}
end
