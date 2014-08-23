class MicropostsController < ApplicationController
 before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  before_action :set_micropost, only: [:show, :edit, :update, :destroy]
  

  # GET /microposts
  # GET /microposts.json
  def index
    @microposts = Micropost.all
  end
  def create
      @micropost = current_user.microposts.build(micropost_params)
      if @micropost.save
        flash[:success] = "Micropost created!"
        redirect_to root_url
      else
        @feed_items = []
        render 'static_pages/home'
      end
  end
  # GET /microposts/1
  # GET /microposts/1.json
  def show
  end

  # GET /microposts/new
  def new
    @micropost = Micropost.new
  end

  # GET /microposts/1/edit
  def edit
  end




    # Use callbacks to share common setup or constraints between actions.
    def set_micropost
      @micropost = Micropost.find(params[:id])
    end

  def destroy
    @micropost.destroy
    redirect_to root_url
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end