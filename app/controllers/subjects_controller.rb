class SubjectsController < ApplicationController
  authorize_resource
  before_action :load_subject, only: :show

  def show
    @q = Question.answer_count_lteq(params[:answer_count_lteq]).ransack(params[:q])
    @questions = @q.result
    @pagy, @questions = pagy(@questions, items: Settings.paging.per_page_10)
  end

  def index
    @q = Subject.question_count_lteq(params[:question_count_lteq])
                .ransack(params[:q])
    @subjects = @q.result
    @pagy, @subjects = pagy(@subjects.active.recent_subjects,
                            items: Settings.paging.per_page_15)
  end

  private

  def load_subject
    @subject = Subject.find_by id: params[:id]
    return if @subject

    flash[:danger] = t(".find_failed")
    redirect_to root_path
  end
end
