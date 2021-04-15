class DirectorsController < ApplicationController

  def new
    @director = Director.new
  end

  def edit
    @director = Director.find(params.fetch(:id))
  end

  def index
    @directors = Director.order( created_at: :desc )

    # respond_to do |format|
    #   format.json do
    #     render json: @movies
    #   end

      # format.html 
    # end
  end

  def show
    @director = Director.find(params.fetch(:id))
  end

  def create
    director_attributes = params.require(:director).permit(:name, :bio)

    @director = Director.new(director_attributes)

    
    if @director.valid?
      @director.save
      redirect_to directors_path, notice: "Director created successfully."
    else
      render "new" 
    end
  end

  def update
    director_attributes = params.require(:director).permit(:name, :bio)

    director = Director.find(params.fetch(:id))

    director.update(director_attributes)

    if director.valid?
      director.save
      redirect_to director_path(director), notice: "Director updated successfully."
    else
      redirect_to director_path(director), alert: "Movie failed to update successfully."
    end
  end

  def destroy
    director = Director.find(params.fetch(:id))
  
    director.destroy
    redirect_to directors_path, notice: "Director successfully deleted"
  end


end
