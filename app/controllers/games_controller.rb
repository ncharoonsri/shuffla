  class GamesController < ApplicationController
  def new
  end

  def index
    @games_all = Game.top_ten
  end
  def create
    #if params come from Artist Search =>
    if params[:type] == 'artist'
      @artists = RSpotify::Artist.search(params[:search])
      @selected_artist = @artists.first
      @selected_artist_uri = @selected_artist.uri.gsub!('spotify:artist:','')
    elsif params[:type] == 'genre'

    elsif params[:type] == 'playlist'

    end

    @game = Game.new
    # Come back here to fix BUG - what if user drops out mid-game?
    @game.user_id = @current_user.id
    @game.artist_id = @selected_artist_uri
    @game.save

    redirect_to new_question_path
  end

  def genre
  end
  def playlist
  end
  def artist
  end

  def show
    @game = @current_user.games.last
    @game_questions = @game.questions
    artist_id = @game.artist_id
    @artist_test_name = RSpotify::Artist.find(artist_id).name
    @game_question_count = @current_user.games.last.questions.count
    @game_correct_count = @current_user.games.last.questions.where("correct = true").count
    @game.total_correct = @game_correct_count
    @game.save
    
    @bonus_points = 0
    @current_user.games.last.questions.each do |question|
      @bonus_points += 3 if ( question.correct && question.duration < 5 )
      @bonus_points += 1 if ( question.correct && question.duration < 10 )
    end

    ## points calculation ##

    @game_avg_time = @current_user.games.last.questions.average("duration")
    @game_pts_correct_answer = (@game_correct_count * 10)

    @game.total_time_points = @game_pts_correct_answer + @bonus_points

    @game.save
  end

  private

  def game_params
    params.require(:game).permit(:total_correct, :total_time_points, :genre, :user_id)
  end

end