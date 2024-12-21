class DiariesController < ApplicationController
  def index
    @selected_date = params[:selected_date] ? Date.parse(params[:selected_date]) : Date.today
    @start_date = @selected_date.beginning_of_week(:sunday)
    @end_date = @start_date + 6.days
    @diaries = current_user.diaries.where(date: @start_date..@end_date).index_by(&:date)
  end

  def new
    @diary = current_user.diaries.build(date: params[:date])
  end

  def create
    @diary = current_user.diaries.build(diary_params)
    if @diary.save
      redirect_to diaries_path, success: t("defaults.flash_message.created", item: @diary.model_name.human)
    else
      flash.now[:danger] = t("defaults.flash_message.not_created", item: @diary.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def diary_params
    params.require(:diary).permit(:title, :body, :date)
  end
end
