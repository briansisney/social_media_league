class UsersController < ApplicationController
  def index

  end

  def show
    @leaders = TopMembersQuery.new.leaderboard_hash
  end

end
