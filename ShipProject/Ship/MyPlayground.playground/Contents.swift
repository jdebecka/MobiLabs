import UIKit
protocol SampleProtocol{
    //cant have constants
    var mutableVar: String { get set }
    var title: String { get set }
    var immutableVar: String { get } //constant or enum
    
    func functionDeliveringNewData() -> String
}

extension SampleProtocol {
    //delivering default title
    mutating func functionDeliveringNewData() -> String {
        title = ""
        return ""
    }
}
extension SampleProtocol where Self: UIView{
    func functionDeliveringNewData() -> String{
        return "UIView"
    }
}

extension SampleProtocol where Self: UIViewController {
    func functionDeliveringNewData() -> String {
        return "UIViewController"
    }
}
class ProtocolExtension : SampleProtocol {
    var title: String
    
    var mutableVar: String
    
    var immutableVar: String
    
    public init(){
        mutableVar = " "
        immutableVar = " "
        title = " "
    }
    
    func functionDeliveringNewData() -> String {
        return ""
    }
    
    
}
enum Weekdays: String {
    
    //diffrence between using this in enum and others is
    //doesn't have init and wont let you create it
    static let staticLet = "abc"
    
    
    case monday = "Monday", tuesday, wednesday
    var noOfWeekday: Int{
        switch self {
        case .monday:
            return 1
        case .tuesday:
            return 2
        case .wednesday:
            return 3
        }
    }
    
    func contat(with string: String) -> String {
        return "\(self.noOfWeekday) " + string
    }
    
}
struct MyBasic {
    var myString: String
    let immutable: Int
    
    let monday = Weekdays.monday.noOfWeekday
    mutating func modifyString(){
        myString = "blah"
    }
}

let instance = MyBasic(myString: "fajnie", immutable: 2)


class MyBasicClass {
    var title: String
    let price: Double
    
    public init(){
        title = ""
        price = 0.0
    }
     
    
    public init(title: String = "DEFAULT STING", price: Double){
        self.title = title
        self.price = price
    }
}

class EachLoop{
    var elements: [Int]
    
    init() {
        elements = [1,2,3,4,5]
    }
    

    func print(){
        elements.forEach {
            Swift.print($0)
        }
    }
}


/*
 
 open
 public
 private
 fileprivate - only file
 private(set) - hides only set and get is public
 internal - everything is internal (only public in a project it was created in)
 
 */


/* The Warsaw bakery called "Cukiernia - ACC" is famous of it's donuts. It has 2 different kinds of those (standard - 2zł, extra large - 3.5zł) and each can be served with a different topping (cranberry/blueberry/raspberry/straberry jam, nutella - 1zł). The overal price of the donut equals to the price of donut itself + the price of topping (can be more than one). Due limited number of exclusive donuts the bakery can sell one donut at a time.

Goal: implement the bakery, donut, topping, order abstractions reflecting the above case.
 */

protocol SellableItem {
    var price: Double { get }
}
enum Donuts: String, SellableItem  {
    case standard, extraLarge
    
    var price : Double {
        switch self {
        case .standard:
            return 2.0
        case .extraLarge:
            return 3.5
        }
    }
}

enum Toppings: String, SellableItem {
    case cranberry, blueberry, raspberry, straberryJam, nutella
    
    var price : Double { return 1.0 }
}


fileprivate class Bakary {
    var order : [Order] = []
    
    public init(order: Order){
        self.order.append(order)
    }
    
}

public class Order {
    var donut : Donuts
    var topping : [Toppings]
    
    init(donut: Donuts, topping: [Toppings] = [] ){
        self.donut = donut
        self.topping = topping
        Bakary(order: self)
        price(donut, topping)
    }
    
    func price(_ donut: Donuts, _ topping: [Toppings]) -> Double {
        if topping.isEmpty {
            return donut.price
        }else{
            var sum = 0.0
            topping.forEach{
                sum = sum + $0.price
            }
            return sum + donut.price
            
        }
    }
}


Order(donut: .extraLarge, topping: [.blueberry, .cranberry])
