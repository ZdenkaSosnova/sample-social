class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    @micropost.image.attach(params[:micropost][:image])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = current_user.feed.paginate(page: params[:page])
      render 'static_pages/home', status: :unprocessable_entity
    end
  end

  def destroy
    if @micropost.system_generated?
      flash[:danger] = "System-generated posts cannot be deleted"
      redirect_back(fallback_location: root_url)
    else
      @micropost.destroy
      flash[:success] = "Micropost deleted"
      if request.referrer.nil?
        redirect_to root_url, status: :see_other
      else
        redirect_to request.referrer, status: :see_other
      end
    end
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content, :image, :visibility)
    end

    def correct_user
      @micropost = Micropost.find_by(id: params[:id])
      
      if @micropost.nil?
        redirect_to(root_url, status: :see_other)
      elsif !current_user.admin? && @micropost.user != current_user
        redirect_to(root_url, status: :see_other)
      end
    end
end
