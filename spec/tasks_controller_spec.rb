require 'rails_helper'

def authenticate_user
  @user = FactoryBot.create(:user)
  allow(controller).to receive(:authenticate_user!).and_return(true)
  allow(controller).to receive(:current_user).and_return(@user)
end

describe TasksController, :type => :controller do

  before do
    authenticate_user
  end

  describe "GET 'tasks'/'index'" do
    it ' should return HTTP status 200' do
      get :index, format: :json
      expect(response).to have_http_status (:success)
    end

    describe 'should return all tasks for current user: ' do
      it '0 tasks' do
        get :index, format: :json
        tasks = JSON.parse(response.body)
        expect(tasks.size).to eq(0)
      end
      it '1 list' do
        FactoryBot.create(:task, user_id: @user.id)
        get :index, format: :json
        tasks = JSON.parse(response.body)
        expect(tasks.size).to eq(1)
      end
      it '5 lists' do
        (0..4).each do |i|
          FactoryBot.create(:task, user_id: @user.id)
        end
        get :index, format: :json
        tasks = JSON.parse(response.body)
        expect(tasks.size).to eq(5)
      end
    end
  end

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

    it ' should not create task with empty description' do
      post :create, params: { task: { name: 'default task content', description: '', user_id: @user.id }}, format: :json
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

  describe "PATCH 'task'/'update'" do
    it ' should return HTTP status 200' do
      task = FactoryBot.create(:task, user_id: @user.id)
      patch :update, params: { id: task.id, task: { name: 'updated task', description: 'updated task' } }, format: :json
      expect(response).to have_http_status (:success)
    end

    it ' should update task name' do
      task = FactoryBot.create(:task, user_id: @user.id)
      patch :update, params: { id: task.id, task: { name: 'updated task', description: 'updated task' } }, format: :json
      expect(JSON.parse(response.body)['name']).to eq('updated task')
      expect(JSON.parse(response.body)['description']).to eq('updated task')
    end

    it ' should not update task name to empty' do
      task = FactoryBot.create(:task, user_id: @user.id)
      patch :update, params: { id: task.id, task: { name: '', description: 'this is description' } }, format: :json
      expect(response).to have_http_status (:unprocessable_entity)
    end

    it ' should not update task description to empty' do
      task = FactoryBot.create(:task, user_id: @user.id)
      patch :update, params: { id: task.id, task: { name: 'default task content', description: '' } }, format: :json
      expect(response).to have_http_status (:unprocessable_entity)
    end

  end

  describe "DELETE 'task'/'destroy'" do
    it ' should destroy list' do
      task = FactoryBot.create(:task, user_id: @user.id)
      delete :destroy, params: { id: task.id }, format: :json
      expect(response).to have_http_status (:success)
    end

    it ' should not destroy not existed list' do
      delete :destroy, params: { id: -1 }, format: :json
      expect(response).to have_http_status (:unprocessable_entity)
    end
  end
end