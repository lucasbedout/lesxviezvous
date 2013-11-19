class SearchController < ApplicationController
  def index
    if params[:query].present?
      @users = User.search(params[:query], page: params[:page])
      @communities = Community.search(params[:query], page: params[:page])
    end

    respond_to do |format|
      format.html # index.html.erb
    end
  end
  def autocomplete
  	user = User.search(params[:query], autocomplete: true, limit: 10).map(&:username)
  	community = Community.search(params[:query], autocomplete: true, limit: 10).map(&:name)

    render json: user + community
  end
end
