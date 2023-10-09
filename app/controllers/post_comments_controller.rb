class PostCommentsController < ApplicationController
  def create
    #投稿にテーブルの投稿idをを探して渡す。
    post_image = PostImage.find(params[:post_image_id])
    #コメントにログインユーザのコメントの入ったファイルを渡す（コメントパラメータ）
    comment = current_user.post_comments.new(post_comment_params)
    #コメントの投稿idに投稿idを渡す。
    comment.post_image_id = post_image.id
    comment.save
    redirect_to post_image_path(post_image)
  end
  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to post_images_path(params[:post_image_id])
  end
  
  private
  
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
  
end
