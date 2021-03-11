class ComplaintsController < ApplicationController
  before_action :authenticate_user!

  def index
    # @complaints = Complaint.all
    @complaints = Complaint.where("complaints.created_at > ?", Date.today)
  end

  def create
    @complaint = current_user.complaints.build(complaint_params)
    if @complaint.save
      redirect_to complaints_path, notice: '保存完了'
    else
      flash.now[:error] = '保存失敗'
      render :new
    end

  end

  def new
    @complaint = current_user.complaints.build
  end

  def destroy
    complaint = current_user.complaints.find(params[:id])
    complaint.destroy!
    redirect_to complaints_path, notice: '削除完了'
  end

  private
  def complaint_params
    params.require(:complaint).permit(:content)
  end

end
