class PostImage < ApplicationRecord
  has_one_attached :image #画像使用するモデルに記入
  belongs_to :user #アソシエーション
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  validates :shop_name, presence: true
  validates :image, presence: true
  #def=メソッド
  def get_image
    #ない限り　画像　添付
    unless image.attached?
      #file_pathにこのrootを教え加える
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      #画像添付（この引数の）このファイルをこの形式で開く。
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end
  #メソッド。引数ユーザidがこのモデルの投稿にいいねしてるか？
  def favorited_by?(user)
    #メソッド。いいねテーブル存在しますか？(テーブルのユーザと引数ユーザ)
    favorites.exists?(user_id: user_id)
  end
end
