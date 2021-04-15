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
    @movie = Movie.new
    @movie.title = params.fetch(:title)
    @movie.description = params.fetch(:description)

    if @movie.valid?
      @movie.save
      redirect_to movies_path, notice: "Movie created successfully."
    else
      render "new" 
    end
  end

  def edit
    id = params.fetch(:id)

    matching_movies = Movie.where( id: id )

    @movie = matching_movies.first
  end

  def update
    id = params.fetch(:id)
    movie = Movie.where( id: id ).first

    movie.title = params.fetch(:title)
    movie.description = params.fetch(:description)

    if movie.valid?
      movie.save
      redirect_to movie_path(movie.id), notice: "Movie updated successfully."
    else
      redirect_to movie_path(movie.id), alert: "Movie failed to update successfully." 
    end
  end

  def destroy
    id = params.fetch(:id)
    movie = Movie.where( id: id ).first

    movie.destroy

    redirect_to movies_path,  notice: "Movie deleted successfully."
  end
end
