class Api::PixesController < ApplicationController
  # note that this returns all pix of a specific user, not all pix from the database
  def index
    @user = User.find_by(id: params[:user_id])
    if @user
      @pixes = @user.pixes
      render :index
    else
      render json: ["User does not exist"], status: 422
    end
  end

  def create
    @pix = Pix.new(pix_params)
    if @pix.save
      render :show
    else
      render json: @pix.errors.full_messages
    end
  end


  def show
    @pix = Pix.find_by_id(params[:id])
    if @pix
      render :show
    else
      render json: ["Pix does not exist"], status: 422
    end
  end

  def destroy
    @pix = Pix.find_by(params[:id])
    @pix.delete
    # redirect somewhere ?
    render :show
  end

  def pix_params
    params.require(:pix).permit(:caption, :author_id, :img_url)
  end
end
