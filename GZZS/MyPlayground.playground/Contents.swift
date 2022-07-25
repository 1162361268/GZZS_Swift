//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var a = NSString(string:"Hello,Tom")

print("替换前：\(a)")

var b = a.replacingOccurrences(of: "TOM", with: "555", options: NSString.CompareOptions.caseInsensitive, range: NSMakeRange(0, a.length))
var c = a.replacingCharacters(in: NSMakeRange(5, 3), with: "2222")

print(b)