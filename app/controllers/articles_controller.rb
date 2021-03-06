class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)
    @article.user = User.first #hard code
    #debugger
    if @article.save
      flash[:success] = "Article was successfully created."
      redirect_to article_path(@article)
    else
      flash[:danger] = "Creation of article was failed"
      render :new
    end  
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    if @article.update(article_params)
      flash[:success] = "Article was successfully updated."
      redirect_to article_path(@article)
    else
      flash[:danger] = "updation of article was failed"
      render :edit
    end 
  end
 
  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    if @article.destroy
      flash[:danger] = "Article was successfully deleted."
      redirect_to articles_path
    else
      flash[:warning] = "deletion of article was failed"
      render articles_path
    end 
    
    # respond_to do |format|
    #   format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :description)
    end
end
