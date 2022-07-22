# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize user
    can %i(read index), [Subject, Question]

    return if user.nil?

    if user.user?
      can :manage, Exam
      can %i(index show), ExamDetail, user_id: user.id
    end

    return unless user.admin?

    can :manage, :all
  end
end
