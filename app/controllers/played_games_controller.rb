class PlayedGamesController < ApplicationController
  def new
    @played_game = PlayedGame.new
    @played_game.game_id = params[:game_id]
  end

  def show
  end

  def edit
  end
 
   def create
    @played_game = PlayedGame.new(played_game_params)
    respond_to do |format|
      if @played_game.save
        format.html { redirect_to @played_game, notice: 'Invitation was successfully created.' }
        format.json { render :show, status: :created, location: @played_game }
      else
        format.html { render :new }
        format.json { render json: @played_game.errors, status: :unprocessable_entity }
      end
    end
  end

    def update
    respond_to do |format|
      if @played_game.update(played_game_params)
        format.html { redirect_to @played_game, notice: 'Invitation was successfully updated.' }
        format.json { render :show, status: :ok, location: @played_game }
      else
        format.html { render :edit }
        format.json { render json: @played_game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @played_game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: 'Invitation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def played_game_params
      params.require(:played_game).permit(:game_id,:user_id)
    end
 end