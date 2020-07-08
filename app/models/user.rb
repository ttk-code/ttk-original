class User < ApplicationRecord
	before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
	has_secure_password

#退会時に全投稿を削除する=========================================
  has_many :posts, :dependent => :destroy
#プロフィール画像登録=========================================
  #has_one_attachedは一個のファイルを添付するための属性モデルクラス
  #attributeはモデルに読み書き可能な属性を追加します

  mount_uploader :image, ImageUploader


#プロフィール画像削除=========================================


#投稿機能========================================================
  has_many :posts

  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user

#フォロー機能========================================================
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

#お気に入り========================================================
  has_many :likes
  has_many :likings, through: :likes, source: :post

  def like(other_post)
      self.likes.find_or_create_by(post_id: other_post.id)
  end

  def unlike(other_post)
    like = self.likes.find_by(post_id: other_post.id)
    like.destroy if like
  end

  def liking?(other_post)
    self.likings.include?(other_post)
  end

#コメント機能========================================================
  has_many :comments

#ユーザー検索機能========================================================
  def self.search(search) #ここでのself.はUser.を意味する
    if search
      where(['name LIKE ?', "%#{search}%"]) #検索とnameの部分一致を表示
    else
      all #全て表示。#User.は省略
    end
  end

end