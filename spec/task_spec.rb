require 'rails_helper'

RSpec.describe Task, type: :model do

  it { should belong_to(:user) }
  it { should validate_length_of(:name)}
  it { should validate_length_of(:description)}
end

describe TasksController, :type => :controller do

  describe "POST 'tasks'/'bew'" do
    it ' should return HTTP status 200' do
      post :new
      expect(response).to have_http_status (:success)
    end
  end


  describe "POST 'task'/'create'" do
    it ' should return HTTP status 200' do
      post :create, params: { task: { name: 'first', description: 'firstDes', user_id: @user.id }}, format: :json
      expect(response).to have_http_status (:success)
    end

    it ' should not create task with empty name' do
      post :create, params: { task: { name: '', description: 'firstDes', user_id: @user.id }}, format: :json
      expect(response).to have_http_status (:unprocessable_entity)
    end

    describe 'should create tasks: ' do
      it '1 task' do
        post :create, params: { task: { name: 'default task content', description: 'this is description', user_id: @user.id }}, format: :json
        get :index, format: :json
        tasks = JSON.parse(response.body)
        expect(tasks.size).to eq(1)
      end

      it '5 tasks' do
        (0..4).each do |i|
          post :create, params: { task: { name: 'default task content', description: 'this is description', user_id: @user.id }}, format: :json
        end
        get :index, format: :json
        expect(JSON.parse(response.body).size).to eq(5)
      end
    end
  end


    it ' should not destroy not existed list' do
      delete :destroy, params: { id: -1 }, format: :json
      expect(response).to have_http_status (:unprocessable_entity)
    end
  end
