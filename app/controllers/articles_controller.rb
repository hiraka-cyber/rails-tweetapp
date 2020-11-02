class ArticlesController < ApplicationController
    http_basic_authenticate_with name: "dhh",password: "secret",except: [:index, :show]
    before_action :authenticate_user!, only: [:show, :create]
    def index
        @articles = Article.all
    end

    def show
        @article = Article.find(params[:id])
        @like = Like.new
    end

    def new
        @article = Article.new(article_params)
    end

    def edit
        @article = Article.find(params[:id])
    end

    def create
        @article = Article.new(article_params)
        @article.user_id = current_user.id

        if @article.save
            redirect_to articles_path
        else
            render 'new'
        end
    end

    def update
        @article = Article.find(params[:id])

        if @article.update(article_params)
            redirect_to @article
        else
            render 'edit'
        end
    end

    def destroy
        @article = Article.find(params[:id])
        @article.destroy

        redirect_to articles_path
    end

    def ensure_correct_user
        @post = Post.find_by(id:params[:id])
        if @post.user_id != @current_user.id
          flash[:notice] = "権限がありません"
          redirect_to articles_path
      end
    end

    private
        def article_params
            params.require(:article).permit(:title, :text, :img, :remove_img, :user_id)
        end
end
