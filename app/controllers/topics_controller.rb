class TopicsController < ApplicationController

  before_action :require_sign_in, except: [:index, :show]

  def index
    @topics = Topic.all
    if params[:search]
       @topics = Topic.search(params[:search]).order("created_at DESC")
     else
       @topics = Topic.all.order('created_at DESC')
     end
  end

  def show
     @topic = Topic.find(params[:id])

     unless @topic.public || current_user
       flash[:alert] = "You must be signed in to view private topics."
       redirect_to new_session_path
     end
  end

  def new
     @topic = Topic.new
  end

  def create
     @topic = Topic.new(topic_params)
     @topic.user = current_user

    if @topic.save
      @topic.labels = Label.update_labels(params[:topic][:labels])
      redirect_to @topic, notice: "Topic was saved successfully."
    else
      flash.now[:alert] = "Error creating topic. Please try again."
      render :new
    end
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])

    @topic.assign_attributes(topic_params)

    if @topic.save
        @topic.labels = Label.update_labels(params[:topic][:labels])
       flash[:notice] = "Topic was updated."
       redirect_to @topic
    else
      flash.now[:alert] = "Error saving topic. Please try again."
      render :edit
    end
  end

  def destroy
     @topic = Topic.find(params[:id])

     if @topic.destroy
       flash[:notice] = "\"#{@topic.name}\" was deleted successfully."
       redirect_to action: :index
     else
       flash.now[:alert] = "There was an error deleting the topic."
       render :show
     end
   end

  private

  def topic_params
    params.require(:topic).permit(:name, :description, :public, :user_id)
  end
end
