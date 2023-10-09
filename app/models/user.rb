class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  #アソシエーション、依存、削除
  has_many :post_images, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  #１対１の関係で擬似カラム作成（ActiveStorage）
  has_one_attached :profile_image
  def get_profile_image(width,height)
    #ない限り　画像の添付が
    unless profile_image.attached?
      #file_pathにこのrootを教え加える
      file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
      #画像添付（この引数の）このファイルをこの形式で開く。
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    #画像を変異させる（サイズを変える[横、縦]）これで処理する。
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
end
