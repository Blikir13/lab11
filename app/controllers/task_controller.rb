# frozen_string_literal: true

# Documentation
class TaskController < ApplicationController
  def input; end

  def show
    if (result = KeepResult.find_by_input(@input = params[:number]))
      @result = result.decoded_result
    else
      result = KeepResult.new(input: @input)
      if result.save
        @result = result.decoded_result
      else
        redirect_to root_path, notice: result.errors.messages[:input][0] unless result.save
      end
    end
  end

  def show_db
    render xml: KeepResult.all
  end
end
