class ComplaintsController < ApplicationController
  before_action :authenticate_user!

  def index
    @complaint = Complaint.new
    @complaints = Complaint.where('complaints.created_at > ?', Date.today)
  end

  def create
    @complaint = current_user.complaints.build(complaint_params)
    @complaint.user_id = current_user.id
    @complaint.save
      # redirect_to complaints_path, notice: '保存完了'
    @complaints = current_user.complaints.where('complaints.created_at > ?', Date.today)
    render :index

      # flash.now[:error] = '保存失敗'

  end

  def destroy
    complaint = current_user.complaints.find(params[:id])
    complaint.destroy!
    @complaints = current_user.complaints.where('complaints.created_at > ?', Date.today)
    render :index
    # redirect_to complaints_path, notice: '削除完了'
  end

  private
  def complaint_params
    params.require(:complaint).permit(:content)
  end

end
