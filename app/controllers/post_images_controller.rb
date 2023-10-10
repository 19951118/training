class PostImagesController < ApplicationController
  def new
    @post_image = PostImage.new
  end
  #paramsはurlのidから引っ張るが今回は投稿データのため()の形の引数
  def create
    @post_image = PostImage.new(post_image_params)
    #モデルにカラム名をつなげることで保存するカラムの中身を操作できる。
    @post_image.user_id = current_user.id
    if @post_image.save
      redirect_to post_images_path
    else
      render :new
    end
  end
  
  def destroy
    post_image = PostImage.find(params[:id])
    post_image.destroy
    redirect_to post_images_path
  end
  
  def show
    @post_image = PostImage.find(params[:id])
    @post_comment = PostComment.new
  end

  def index
    @post_images = PostImage.all
  end
  #ストロングパラメータ
  private
  
  def post_image_params
    params.require(:post_image).permit(:shop_name, :image, :caption)
  end
end
