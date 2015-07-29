func transpose<T>(mat: List<List<T>>) -> List<List<T>> {
  switch mat {
  case let .Cons(x, xs) where x.isEmpty: return transpose(xs)
  case let .Cons(.Cons(x, xs), xss):
    return (x |> xss.flatMap{$0.first}) |> transpose(xs |> xss.map{$0.tail})
  default: return .Nil
  }
}

let matrix: List<List<Int>> = [[1, 2, 3], [1, 2, 3], [1, 2, 3]]
transpose(matrix)

extension List {
  func foldr<T>(initial: T, @noescape combine: (element: Element, accumulator: T) -> T) -> T {
    switch self {
    case .Nil: return initial
    case let .Cons(x, xs): return combine(element: x, accumulator: xs.foldr(initial, combine: combine))
    }
  }
}

let nums: List = [1, 2, 3, 4, 5]
nums
  .foldr([Int]()) { $1 + [$0] }

extension List {
  var subsequences: List<List<Element>> {
    switch self {
    case .Nil: return .Nil
    case let .Cons(x, xs):
      return [x] |> xs.subsequences.foldr([]) { (ys, r) in ys |> (x |> ys) |> r }
    }
  }
}

List([1, 2, 3]).subsequences

let deck: Deque = [1, 2, 3, 4, 5, 6]

deck
  .filter { $0 % 2 == 0 }
  .tail