class Admin::ExamsController < AdminController
  before_action :load_exam, only: :show

  def index
    @q = Exam.by_key_word_with_relation_tables(params[:by_key_word_with_relation_tables]).ransack(params[:q])
    @exams = @q.result
    @pagy, @exams = pagy(@exams.recent_exam, items: Settings.paging.per_page_5)
  end

  def show
    render template: "exams/show"
  end

  def search; end

  private
  def load_exam
    return if @exam = Exam.find_by(id: params[:id])

    flash[:danger] = t ".exam_not_found"
    redirect_to :admin_exams
  end
end
