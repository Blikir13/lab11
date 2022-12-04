# frozen_string_literal: true

require 'test_helper'

class TaskControllerTest < ActionDispatch::IntegrationTest
  test 'should get input' do
    get task_input_url
    assert_response :success
  end

  test 'should get show' do
    get task_show_url
    assert_response :success
  end
end
