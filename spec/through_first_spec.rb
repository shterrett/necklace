require 'spec_helper'

describe 'threading enumerable as first argument through methods with multiple arguments' do
  it 'puts the enumerable first in the argument list of a method that takes multiple arguments' do
    class Test
      include Necklace

      def add_to_each(numbers, number)
        numbers.map { |n| n + number }
      end

      def test_add_to_each
        through_first([1, 3, 5, 7, 9],
                      [[:add_to_each, 3]]
                     )
      end
    end

    test = Test.new

    expect(test.test_add_to_each).to eq([4, 6, 8, 10, 12])
  end

  it 'accepts a mix of methods which take multiple arguments and methods which take only one' do
    class Test
      include Necklace

      def add_to_each(numbers, number)
        numbers.map { |n| n + number }
      end

      def double(numbers)
        numbers.map { |n| n * 2 }
      end

      def test_add_to_each_double
        through_first([1, 3, 5, 7, 9],
                      [[:add_to_each, 3],
                       :double
                      ]
                     )
      end
    end

    test = Test.new

    expect(test.test_add_to_each_double).to eq([8, 12, 16, 20, 24])
  end
end
