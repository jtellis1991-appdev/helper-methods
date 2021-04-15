class MoviesController < ApplicationController
  def new
    @movie = Movie.new
  end

  def index
    @movies = Movie.all.order( created_at: :desc )

    respond_to do |format|
      format.json do
        render json: @movies
      end

      format.html 
    end
  end

  def show
      @movie = Movie.find(params.fetch(:id))
  end

  def create
    movie_attributes = params.require(:movie).permit(:title, :description)

    @movie = Movie.new(movie_attributes)

    if @movie.valid?
      @movie.save
      redirect_to movies_path, notice: "Movie created successfully."
    else
      render "new" 
    end
  end

  def edit
    @movie = Movie.find(params.fetch(:id))
  end

  def update
    movie_attributes = params.require(:movie).permit(:title, :description)

    movie = Movie.find(params.fetch(:id))

    movie.update(movie_attributes)

    if movie.valid?
      movie.save
      redirect_to movie_path(movie.id), notice: "Movie updated successfully."
    else
      redirect_to movie_path(movie.id), alert: "Movie failed to update successfully." 
    end
  end

  def destroy
    movie = Movie.find(params.fetch(:id))
 
    movie.destroy

    redirect_to movies_path,  notice: "Movie deleted successfully."
  end
end
