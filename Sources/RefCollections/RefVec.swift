
public final class RefVec<Element> : ExpressibleByArrayLiteral {
    var inner: ContiguousArray<Element>

    public init() {
        self.inner = []
    }

    public init(arrayLiteral elements: Element...) {
//                self.inner = .init(arrayLiteral: elements)
//        self.inner = ContiguousArray(arrayLiteral: elements)
        self.inner = []
        self.inner.append(contentsOf: elements)
    }

    public init(from decoder: Decoder) throws {
        fatalError()
    }
}

extension RefVec : MutableCollection {
    public func index(after i: Int) -> Int {
        i + 1
    }

    public var startIndex: Int {
        self.inner.startIndex
    }

    public var endIndex: Int {
        self.inner.endIndex
    }

    public subscript(index: Int) -> Element {
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


extension RefVec {
    public func reserveCapacity(_ minimumCapacity: Int) {
        self.inner.reserveCapacity(minimumCapacity)
    }

}

extension RefVec: RangeReplaceableCollection {
    public func replaceSubrange<C>(_ subrange: Range<Int>, with newElements: C) where C : Collection, Element == C.Element {
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

extension RefVec where Element : Comparable {
    public func sort() {
        self.inner.sort()
    }
}

extension RefVec : RandomAccessCollection {

}

extension RefVec : Codable {


    public func encode(to encoder: Encoder) throws {
        fatalError()
    }
}

