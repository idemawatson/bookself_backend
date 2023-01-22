class Api::V1::UsersController < ApplicationController
  def create
    User.create(params[:name], params[:email])
  end

  def show
    User.find_by(sub: params[:sub])
  end
end
