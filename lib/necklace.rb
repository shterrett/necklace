module Necklace
  ARG_INSERTION_ORDER = { first: 1, last: -1 }

  def through(enumerable, methods)
    through_last(enumerable, methods)
  end

  def through_first(enumerable, methods)
    methods.reduce(enumerable) do |result, method|
      _call(method, result, :first)
    end
  end

  def through_last(enumerable, methods)
    methods.reduce(enumerable) do |result, method|
      _call(method, result, :last)
    end
  end

  def _call(method, result, order)
    method = [method].flatten
    args = method.insert(ARG_INSERTION_ORDER[order], result)
    send(*args)
  end
end
