require 'spec_helper'

describe 'Threading enumerable as the last argument through a function that takes multiple arguments' do
  it 'uses the enumerable as the last argument of a method that takes multiple arguments' do
    class Test
      include Necklace

      def add_to_each(number, numbers)
        numbers.map { |n| n + number }
      end

      def test_add_to_each
        through_last([1, 3, 5, 7, 9],
                     [[:add_to_each, 3]]
                    )
      end
    end

    test = Test.new

    expect(test.test_add_to_each).to eq([4, 6, 8, 10, 12])
  end

  it 'mixes methods that require multiple arguments with those that take only one' do
    class Test
      include Necklace

      def add_to_each(number, numbers)
        numbers.map { |n| n + number }
      end

      def double(numbers)
        numbers.map { |n| n * 2 }
      end

      def test_double_add_to_each
        through_last([1, 3, 5, 7, 9],
                     [[:add_to_each, 3],
                      :double
                     ]
                    )
      end
    end

    test = Test.new

    expect(test.test_double_add_to_each).to eq([8, 12, 16, 20, 24])
  end
end
