
public final class RefArray<Element> : ExpressibleByArrayLiteral {
    public typealias Index = Int

    @usableFromInline
    internal var inner: ContiguousArray<Element>

    @inlinable @inline(__always)
    public init() {
        self.inner = []
    }

    @inlinable @inline(__always)
    public init(arrayLiteral elements: Element...) {
        self.inner = []
        self.inner.append(contentsOf: elements)
    }

    internal init(inner: ContiguousArray<Element>) {
        self.inner = inner
    }
}

extension RefArray : MutableCollection {
    @inlinable @inline(__always)
    public func index(after i: Index) -> Index {
        self.inner.index(after: i)
    }

    @inlinable @inline(__always)
    public var startIndex: Index {
        self.inner.startIndex
    }

    @inlinable @inline(__always)
    public var endIndex: Index {
        self.inner.endIndex
    }

    @inlinable @inline(__always)
    public var count: Int {
        self.inner.count
    }

    @inlinable @inline(__always)
    public var capacity: Int {
        self.inner.capacity
    }

    @inlinable @inline(__always)
    public subscript(index: Index) -> Element {
        get {
            self.inner[index]
        }
        set {
            self.inner[index] = newValue
        }
    }

    @inlinable @inline(__always)
    public func sort(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows {
        try self.inner.sort(by: areInIncreasingOrder)
    }
}


extension RefArray {
    @inlinable @inline(__always)
    public func reserveCapacity(_ minimumCapacity: Index) {
        self.inner.reserveCapacity(minimumCapacity)
    }
}

extension RefArray: RangeReplaceableCollection {
    @inlinable @inline(__always)
    public func replaceSubrange<C>(
        _ subrange: Range<Index>,
        with newElements: C
    ) where C : Collection, Element == C.Element {
        self.inner.replaceSubrange(subrange, with: newElements)
    }

    @inlinable @inline(__always)
    public func append(_ newElement: Element) {
        self.inner.append(newElement)
    }

    @inlinable @inline(__always)
    public func append<S>(contentsOf newElements: S) where S : Sequence, Element == S.Element {
        self.inner.append(contentsOf: newElements)
    }

    @inlinable @inline(__always)
    public func removeAll(keepingCapacity keepCapacity: Bool) {
        self.inner.removeAll(keepingCapacity: keepCapacity)
    }

    @inlinable @inline(__always)
    public func removeAll() {
        self.inner.removeAll()
    }

    @inlinable @inline(__always)
    public func remove(at i: Index) -> Element {
        self.inner.remove(at: i)
    }
}

extension RefArray where Element : Comparable {
    @inlinable @inline(__always)
    public func sort() {
        self.inner.sort()
    }
}

extension RefArray : RandomAccessCollection {

}

extension RefArray: BidirectionalCollection {
    @inlinable @inline(__always)
    public func index(before i: Index) -> Index {
        self.inner.index(before: i)
    }
}

extension RefArray : Codable where Element: Codable {
    public func encode(to encoder: Encoder) throws {
        try self.inner.encode(to: encoder)
    }

    public convenience init(from decoder: Decoder) throws {
        let inner = try ContiguousArray<Element>(from: decoder)
        self.init(inner: inner)
    }
}


extension RefArray: Equatable where Element: Equatable {
    @inlinable @inline(__always)
    public static func ==(lhs: RefArray<Element>, rhs: RefArray<Element>) -> Bool {
        lhs.inner == rhs.inner
    }
}

extension RefArray: Hashable where Element: Hashable {
    @inlinable @inline(__always)
    public func hash(into hasher: inout Hasher) {
        self.inner.hash(into: &hasher)
    }

    @inlinable @inline(__always)
    public var hashValue: Int {
        self.inner.hashValue
    }
}


extension RefArray: CustomStringConvertible {
    public var description: String {
        self.inner.description
    }
}
