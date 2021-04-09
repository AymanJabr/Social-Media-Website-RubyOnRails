# rubocop:disable Metrics/BlockLength
require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Creating a user and associated object' do
    it 'sucessfully creates a new user' do
      user = User.new(id: 1, name: 'username', email: 'username@gmail.com', password: 'password')
      expect(user.valid?).to eq(true)
    end
    it 'fails to create a new user' do
      user = User.new(name: 'Username')
      expect(user.valid?).to eq(false)
    end
    it 'sucessfully creates a new Post from a user' do
      user = User.new(id: 1, name: 'username', email: 'username@gmail.com', password: 'password')
      post = user.posts.build(content: 'Some specific content')
      expect(post.valid?).to eq(true)
    end
    it 'Does not creates a new Post from a user' do
      user = User.new(id: 1, name: 'username', email: 'username@gmail.com', password: 'password')
      post = user.posts.build
      expect(post.valid?).to eq(false)
    end
    it 'sucessfully creates a new Comment from a user' do
      user = User.new(id: 1, name: 'username', email: 'username@gmail.com', password: 'password')
      user.save
      post = user.posts.create(content: 'Some specific content')
      comment = user.comments.build(content: 'Some specific comment', post_id: post.id)
      expect(comment.valid?).to eq(true)
    end
    it 'Does not creates a new Comment from a user' do
      user = User.new(id: 1, name: 'username', email: 'username@gmail.com', password: 'password')
      post = user.posts.build(content: 'Some specific content')
      comment = post.comments.build
      expect(comment.valid?).to eq(false)
    end
    it 'sucessfully creates a new Like from a user' do
      user = User.new(id: 1, name: 'username', email: 'username@gmail.com', password: 'password')
      user.save
      post = user.posts.create(content: 'Some specific content')
      like = user.likes.build(post_id: post.id)
      expect(like.valid?).to eq(true)
    end
    it 'Does not creates a new Like from a user' do
      user = User.new(id: 1, name: 'username', email: 'username@gmail.com', password: 'password')
      like = user.likes.build
      expect(like.valid?).to eq(false)
    end
  end
end
# rubocop:enable Metrics/BlockLength
