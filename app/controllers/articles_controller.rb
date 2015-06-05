class ArticlesController < ApplicationController
   def index
        @articles = Article.all
    end

    def show
        @article = Article.find(params[:id])
        @comment = Comment.new
    end

    def new
        @article = Article.new
    end

    def edit
        @article = Article.find(params[:id])
    end

    def destroy
        @article = Article.find(params[:id])
        if @article.destroy
            redirect_to articles_path, :notice => "Berhasil Menghapus!"
        else
            redirect_to articles_path, :error => "Gagal Menghapus!"
        end
    end

    def create
        @article = Article.new(params_article)
        if @article.save
            redirect_to articles_path, :notice => "Membuat artikel baru sukses!"
        else
            render "new", :error => "Membuat artikel baru gagal !"
        end
    end

    def update
        @article = Article.find(params[:id])
        if @article.update(params_article)
            redirect_to article_path(@article), :notice => "Sudah diperbaharui"
        else
            render "edit", :error => "Gagal diperbaharui"
        end
    end

    def export_xlsx
        @article = Article.find(params[:id])
        respond_to do |format|
            format.xlsx
        end
    end

    def import_xlsx
        Article.import(params[:file])
        redirect_to articles_path, notice: "Products imported."
    end

    def import
    end

    private
        def params_article
            params.require(:article).permit(:title, :content)
        end
end
