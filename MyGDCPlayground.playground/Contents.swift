import Foundation


class A{
    var a: String
    init(a: String) {
        self.a = a
    }
}

class B: A{
    var b: Int
    init(a: String, b: Int) {
        self.b = b
        super.init(a: a)
    }
}

var a: A
var b = B(a: "bla bla", b: 123)

a = b
print(a.a)

protocol MyProtocol{
    var a: String { get set }
    
    func some_function()
}

class C{
    let c = "c"
}



var array = Array<Int>()
var set = Set<Int>()
var dictionary: [C: C] = [:]


extension C: Hashable{
    static func == (lhs: C, rhs: C) -> Bool {
        lhs.c == rhs.c
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.c)
    }
}

protocol MyNewProtocol{
    associatedtype T
    var myVar: T {get}
    
    func someFunc(param: T)
}

class D: MyNewProtocol{
    var myVar: Int{
        Int.random(in: 0...10000)
    }
    
    func someFunc(param: Int) {
        let someString = String(param)
        let result = someString.reduce(""){
            $0 + "a\($1)"
        }
        print(result)
    }
}

let d = D()
d.someFunc(param: d.myVar)


