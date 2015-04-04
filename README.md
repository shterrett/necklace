# Necklace

## What/Why

Ports the `->` macro from Clojure to make long chains of Enumerable more
readable

Usually when chaining method calls in ruby, the names of the methods are
descriptive and the chain is readable. (Note that this may violate the Law of
Demeter, but this is simply an example). One can imagine something like

```ruby
food_processor.add(vinegar)
              .add(garlic)
              .add(pepper)
              .start
              .drizzle(oil)
```

Where each method returns `self` and the chain describes the actions.

However, with Enumerable, because the methods are more abstract, readability is
often sacrificed when chaining operations:

```ruby
[1, 3, 5, 7, 9].map do |n|
  n + 1
end.map do |n|
  n * 2
end.map |n|
  n - 3
end.select |n|
  n.even?
end
```

Two possible solutions are to name only the inner methods:

```ruby
[1, 3, 5, 7, 9].map do |n|
  increment(n)
end.map do |n|
  double(n)
end.map |n|
  subtract(n, 3)
end.select |n|
  n.even?
end
```

or extract each transformation in a method and call them inside-out -
lisp-style:

```ruby
even(
  subtract_three(
    double(
      incrememnt([1, 3, 5, 7, 9])
    )
  )
)
```

This last looks a lot like a lisp, and Clojure has a macro to make calls like
this easier to read:

```clojure
(-> [1, 3, 5, 7, 9]
  increment
  double
  subtract_three
  even
)
```

**Necklace** attempts to replicate at least some aspects of the Clojure
threading macros (`->`, `->>`) in ruby so that long chains of enumerable
transformations can be called without sacrificing readablility.

## Usage

simply `include Necklace` in a class

Then define methods that take each successive result as their argument.

Then call `through` with the enumerable as the first argument and an array of
symbols corresponding to the method names as the second argument.

```ruby
through([1, 3, 5, 7, 9],
        [:increment,
         :double,
         :subtract_three,
         :even
        ]
)
```

For methods that have multiple arguments, both a `through_first` and
`through_last` method are provided. These thread the enumerable as the first or
last argument of the method calls respectively. Methods with arguments in
addition to the enumerable have the method and it's additional arguments
packaged in an array:

```ruby
through_first([1, 3, 5, 7, 9],
              [[:add_to_each, 3]
               :double
              ]
             )
```

will call

```ruby
add_to_each([1, 3, 5, 7, 9], 3)
```

and

```ruby
through_last([1, 3, 5, 7, 9],
             [[:add_to_each, 3]
              :double
             ]
            )
```

will call

```ruby
add_to_each(3, [1, 3, 5, 7, 9])
```

## License
### MIT

```
Copyright (c) 2015 Stuart Terrett

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```
