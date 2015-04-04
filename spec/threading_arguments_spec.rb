require 'spec_helper'

describe 'Threading enumerable as argument' do
  it 'passes the given enumerable to the function named by the symbol in an array' do
    class Test
      include Necklace

      def increment(numbers)
        numbers.map { |n| n + 1 }
      end

      def test_increment
        through([1, 3, 5, 7, 9],
                [:increment]
        )
      end
    end

    test = Test.new
    expect(test.test_increment).to eq([2, 4, 6, 8, 10])
  end

  it 'passes the result of each method to the next from top to bottom' do
    class Test
      include Necklace

      def increment(numbers)
        numbers.map { |n| n + 1 }
      end

      def double(numbers)
        numbers.map { |n| n * 2 }
      end

      def test_increment_double
        through([1, 3, 5, 7 , 9],
                [:increment,
                 :double
                ]
        )
      end

      def test_double_increment
        through([1, 3, 5, 7, 9],
                [:double,
                 :increment
                ]
        )
      end
    end

    test = Test.new

    expect(test.test_increment_double).to eq([4, 8, 12, 16, 20])
    expect(test.test_double_increment).to eq([3, 7, 11, 15, 19])
  end
end
