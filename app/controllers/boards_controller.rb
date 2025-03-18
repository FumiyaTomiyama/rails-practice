class BoardsController < ApplicationController
    before_action :set_target_board, only: %i[show edit update destroy]

    def index
        @boards = params[:tag_id].present? ? Tag.find(params[:tag_id]).boards : Board.all
        @boards = @boards.page(params[:page]).per(10)
    end

    def new
        @board = Board.new(flash[:board])
    end

    def create
        board = Board.new(board_params)
        if board.save
            flash[:notice] = "「#{board.title}」の掲示板を作成しました"
            redirect_to board
        else
            redirect_to new_board_path, flash: {
                board: board,
                error_messages: board.errors.full_messages
            }
        end
    end

    def show
        @comment = Comment.new(board_id: @board.id)
    end

    def edit
    end

    def update
        if @board.update(board_params)
            redirect_to @board
        else
            flash[:board] = @board
            flash[:error_messages] = @board.errors.full_messages
            redirect_back fallback_location: @board
        end
    end

    def destroy
        @board.destroy
        flash[:notice] = "「#{@board.title}」の掲示板が削除されました"
        redirect_to boards_path
    end

    private

    def board_params
        params.require(:board).permit(:name, :title, :body, tag_ids: [])
    end

    def set_target_board
        @board = Board.find(params[:id])
    end
end