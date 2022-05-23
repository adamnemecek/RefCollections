
public final class RefArray<Element> : ExpressibleByArrayLiteral {
    public typealias Index = Int

    var inner: ContiguousArray<Element>

    public init() {
        self.inner = []
    }

    public init(arrayLiteral elements: Element...) {
        self.inner = []
        self.inner.append(contentsOf: elements)
    }

    internal init(inner: ContiguousArray<Element>) {
        self.inner = inner
    }
}

extension RefArray : MutableCollection {
    public func index(after i: Index) -> Index {
        self.inner.index(after: i)
    }

    public var startIndex: Index {
        self.inner.startIndex
    }

    public var endIndex: Index {
        self.inner.endIndex
    }

    public subscript(index: Index) -> Element {
        get {
            self.inner[index]
        }
        set {
            self.inner[index] = newValue
        }
    }

    public func sort(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows {
        try self.inner.sort(by: areInIncreasingOrder)
    }
}


extension RefArray {
    public func reserveCapacity(_ minimumCapacity: Index) {
        self.inner.reserveCapacity(minimumCapacity)
    }
}

extension RefArray: RangeReplaceableCollection {
    public func replaceSubrange<C>(
        _ subrange: Range<Index>,
        with newElements: C
    ) where C : Collection, Element == C.Element {
        self.inner.replaceSubrange(subrange, with: newElements)
    }

    public func append(_ newElement: Element) {
        self.inner.append(newElement)
    }

    public func removeAll(keepingCapacity keepCapacity: Bool) {
        self.inner.removeAll(keepingCapacity: keepCapacity)
    }

    public func removeAll() {
        self.inner.removeAll()
    }
}

extension RefArray where Element : Comparable {
    public func sort() {
        self.inner.sort()
    }
}

extension RefArray : RandomAccessCollection {

}

extension RefArray: BidirectionalCollection {
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
    public static func ==(lhs: RefArray<Element>, rhs: RefArray<Element>) -> Bool {
        lhs.inner == rhs.inner
    }
}

extension RefArray: Hashable where Element: Hashable {
    public func hash(into hasher: inout Hasher) {
        self.inner.hash(into: &hasher)
    }

    public var hashValue: Int {
        self.inner.hashValue
    }
}


//AccelerateMutableBuffer
//ContiguousBytes
//Conforms when Element is UInt8.
//CustomDebugStringConvertible
//CustomReflectable
//CustomStringConvertible
//DataProtocol
//Conforms when Element is UInt8.
//Decodable
//Conforms when Element conforms to Decodable.
//Encodable
//Conforms when Element conforms to Encodable.
//Equatable
//Conforms when Element conforms to Equatable.
//ExpressibleByArrayLiteral
//Hashable
//Conforms when Element conforms to Hashable.
//MutableCollection
//MutableDataProtocol
//Conforms when Element is UInt8.
//RandomAccessCollection
//RangeReplaceableCollection
