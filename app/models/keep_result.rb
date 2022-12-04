# frozen_string_literal: true

class KeepResult < ApplicationRecord
  validates_uniqueness_of :input, message: 'Введено не уникальное значение'
  validates :input, format: { with: /\A(\d+\s){9,}([0-9]+)\z/, message: 'Неверный ввод!' }
  before_save :save_result

  def decoded_result
    ActiveSupport::JSON.decode(result)
  end

  private

  def save_result
    self.result = ActiveSupport::JSON.encode([tog, max(tog)])
  end

  # поиск максимальных подпоследователностей и вывод в строку
  def max(array)
    arr = array.clone
    s = ''
    arr.sort_by!(&:size).map { |el| s += "#{el.join(' ')}, " if el.size == arr[-1].size }
    s[0...s.length - 2]
  end

  # разделение на подпоследовательности
  def cons(mas)
    a = []
    mas.each { |x| (2..x.size).each { |n| x.each_cons(n) { |el| a.push(el) } } }
    a
  end

  def tog
    arr = []
    a = []
    input.split.map(&:to_i).each do |x|
      unless arr.push(x) == arr.sort
        a.push(arr.first(arr.size - 1))
        arr = [arr.pop]
      end
    end
    cons(a.push(arr).select { |x| x.length > 1 })
  end
end
