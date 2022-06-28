class ExamsController < ApplicationController
  before_action :load_user, :history, :load_subject, :questions, only: :show
  def show; end

  private
  def questions
    return if @questions = @subject.questions.to_a.shuffle![0..9]

    flash[:danger] = t ".question_not_implemented"
    redirect_to :root
  end

  def load_subject
    return if @subject = Subject.find_by(id: params[:id])

    flash[:danger] = t ".resource_not_found"
    redirect_to :root
  end

  def history
    # @history = @user.histories.build
    # @history.subject_id = @subject.id
    # @history.save!
    @history = History.first!
  end

  def load_user
    @user = User.first!
  end
end
