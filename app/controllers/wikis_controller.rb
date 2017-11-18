class WikisController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
    authorize @wiki #???
  end

  def create
   @wiki = Wiki.new
   @wiki.assign_attributes(wiki_params)
   @wiki.user = current_user
   authorize @wiki #???
   if @wiki.save
     flash[:notice] = "Voila! Your wiki has been created."
     redirect_to @wiki
   else
     flash[:alert] = "Snap! Something went wrong. Please try again."
     render :new
   end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki   #???
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.assign_attributes(wiki_params)
    @wiki.user = current_user
    #authorize @wiki
    @wiki.collaborating_user_ids = params[:wiki][:collaborating_user_ids]

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
    #authorize @wiki  #if NOT commented-pundit DOES NOT allow destruction->throws error
    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted!"
      redirect_to wikis_path
    else
      flash.now[:alert] = "Oh no... Can you try that again?"
      render :show
    end
  end

  private

  def wiki_params
  params.require(:wiki).permit(:title, :body, :private)
end

end
