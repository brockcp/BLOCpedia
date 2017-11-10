class WikisController < ApplicationController
  before_action :set_wiki, only: [:show, :edit, :update, :destroy]

  def index
    @wikis = Wiki.all
    authorize @wikis
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
   @wiki = Wiki.new
   @wiki.title = params[:wiki][:title]
   @wiki.body = params[:wiki][:body]
   @wiki.private = params[:wiki][:private]

   @wiki.user = current_user
   authorize @wiki

   if @wiki.save
     flash[:notice] = "Your wiki has been received."
     redirect_to @wiki
   else
     flash[:alert] = "Snap! Something went wrong. Please try again."
     render :new
   end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki  #not sure here
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]
    @wiki.user = current_user

    authorize @wiki
    if @wiki.save
      flash[:notice] = "Your wiki has been received."
      redirect_to @wiki
    else
      flash.now[:alert] = "Oops. That didn't work. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted!"
      redirect_to wikis_path
    else
      flash.now[:alert] = "Oh no... Can you try that again?"
      render :show
    end
  end

  def set_wiki
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

end
