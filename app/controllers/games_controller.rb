class GamesController < ApplicationController

  def index 
    @games_all = Game.includes(:images).order('created_at DESC')
    @games = @games_all [0..19]

  end

  def all
    @games = Game.includes(:images)
  end
  
  def new
    @game = Game.new
    @game.images.new
  end

  def create
    @game = Game.new(game_params)
    if @game.save!
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @game = Game.find(params[:id])
    @image = @game.images
    @comment = Comment.new
    @comments = @game.comments.includes(:user)
  end

  def destroy
    @game = Game.find(params[:id])
    if @game.destroy
      redirect_to root_path
    else 
      render :show
    end
  end

  def search
    @games = Game.search(params[:keyword]).order("created_at DESC")
  end

  # def edit
  #   @game = Game.find(params[:id])
  #   @image = @game.images
  # end

  # def update
  #   @game = Game.find(params[:id])
  #   if @game.update(game_params)
  #     redirect_to root_path
  #   else 
  #     render :show
  #   end
  # end

  private

  def game_params
    params.require(:game).permit(:name, :text, :platform, images_attributes: [:src]).merge(user_id: current_user.id)
  end
end