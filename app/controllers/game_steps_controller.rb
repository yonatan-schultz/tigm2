class GameStepsController < ApplicationController
	include Wicked::Wizard

	steps :races, :rules, :strategy_cards, :location#, :invitations

	def show
		@game = Game.find(params[:game_id])
		render_wizard
	end

	def update
		@game = Game.find(params[:game_id])
		params[:game][:status] = step
		params[:game][:status] = 'active' if step == steps.last
		@game.update(game_params)
		render_wizard @game
	end

	private

	def game_params
      params.require(:game).permit(:status,:shattered_empire, :shards_of_the_throne, :number_of_players, {:rules => []}, {:strategy_cards => [:"1",:"2",:"3",:"4",:"5",:"6",:"7",:"8"]},:players, {:races => []},:address,:notes,:date_and_time)
    end
end
