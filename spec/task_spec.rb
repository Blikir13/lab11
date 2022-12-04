# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
RSpec.describe 'Task_controller', type: :request do
  # Проверка на успешные get запросы
  describe 'GET /input' do
    it 'returns http success' do
      get '/task/input'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get '/task/show', params: { number: '1 2 3 4 1 2 3 4 1 2 3 4 1 2' }
      expect(response).to have_http_status(:success)
    end
  end

  # Проверка на успешное добавление и поиск элемента в БД
  describe 'Add and search db(check adding to db)' do
    it 'Adds correctly' do
      get '/task/show', params: { number: '1 2 3 4 1 2 3 4 1 2 3 4 1 4' }
      expect(t = KeepResult.create(input: '1 2 3 4 1 2 3 4 1 2 3 4 1 4', result: assigns(:result))).not_to be_nil
      t.save
      expect(KeepResult.find_by_input('1 2 3 4 1 2 3 4 1 2 3 4 1 4')).not_to be_nil
    end
  end
end

RSpec.describe 'Task_controller(2 part)', type: :request do
  # Проверка на различный результат при различных входных данных
  describe 'We have different results when enter different input values' do
    it 'not equal result' do
      get '/task/show', params: { number: '1 2 3 0 9 2 3 1 2 3 4' }
      t = KeepResult.create(input: '1 2 3 0 9 2 3 1 2 3 4', result: assigns(:result))
      get '/task/show', params: { number: '1 2 3 0 9 2 3 1 2 3 2' }
      t1 = KeepResult.create(input: '1 2 3 0 9 2 3 1 2 3 2', result: assigns(:result))
      expect(t1).not_to eq(t)
    end
  end
end

RSpec.describe 'Test db_model', type: :model do
  describe 'Only unique elements' do
    it 'another checks uniqie' do
      KeepResult.create!(input: '10 9 8 7 6 5 4 3 1 2', result: '1 2 1 2')
      expect { KeepResult.create!(input: '10 9 8 7 6 5 4 3 1 2', result: '1 2 1 2') }.to raise_exception
    end
  end
end
