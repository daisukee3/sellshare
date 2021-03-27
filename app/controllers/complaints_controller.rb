class ComplaintsController < ApplicationController
  before_action :authenticate_user!

  def index
    @complaint = Complaint.new
    @complaints = Complaint.where('complaints.created_at > ?', Date.today)
  end

  def create
    @complaint = current_user.complaints.build(complaint_params)
    @complaint.user_id = current_user.id
    if @complaint.save
      @complaints = current_user.complaints.where('complaints.created_at > ?', Date.today)
      render :index
    else
      @complaints = current_user.complaints.where('complaints.created_at > ?', Date.today)
      render :index
    end
  end

  def destroy
    complaint = current_user.complaints.find(params[:id])
    complaint.destroy!
    @complaints = current_user.complaints.where('complaints.created_at > ?', Date.today)
    render :index
  end

  private
  def complaint_params
    params.require(:complaint).permit(:content)
  end

end
