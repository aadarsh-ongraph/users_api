class Api::V1::LikesController < ApplicationController
    before_action :set_like, only: [:show, :update, :destroy]

    def index
      @likes = Like.all
      render json: @likes
    end

    def show
      render json: @like
    end

    def create
      @like = Like.new(like_params)
      if @like.save
        render json: @like, status: :created
      else
        render json: @like.errors, status: :unprocessable_entity
      end
    end

    def update
      if @like.update(like_params)
        render json: @like
      else
        render json: @like.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @like.destroy
      head :no_content
    end

    private

    def set_like
      @like = Like.find(params[:id])
    end

    def like_params
      params.require(:like).permit(:like_count, :user_id)
    end
  end