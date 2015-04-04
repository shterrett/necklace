module Necklace
  def through(enumerable, methods)
    methods.reduce(enumerable) do |result, method|
      send(method, result)
    end
  end

  def through_first(enumerable, methods)
    methods.reduce(enumerable) do |result, method|
      if method.respond_to? :first
        send(method.first, result, *method.drop(1))
      else
        send(method, result)
      end
    end
  end

  def through_last(enumerable, methods)
    methods.reduce(enumerable) do |result, method|
      if method.respond_to? :first
        send(method.first, *method.drop(1), result)
      else
        send(method, result)
      end
    end
  end
end
