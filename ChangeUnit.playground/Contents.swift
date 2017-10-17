//: Playground - noun: a place where people can play

import UIKit

/*
var centimeter : Int = 120
var centimeter_to_cm = Double(centimeter)/100
print(centimeter, "cm를 ",centimeter_to_cm, "로 출력한다.")

var meter : Double = 1.86
var meter_to_cm = Int(meter*100
print(meter, "m를 ",meter_to_cm, "cm로 출력한다.")
*/


func Convert (value: String) -> String {
    var result : String = ""
    if value.contains("cm") {
        let endIndex = value.index(of: "c") ?? value.endIndex
        let num = Double(value[..<endIndex])
        result = "\(num!/calc_val)"
    }else if value.contains("m"){
        let endIndex = value.index(of: "m") ?? value.endIndex
        let num_double = Double(value[..<endIndex])
        let num = Int(num_double!*calc_val)
        result = "\(num)"
        //print("\(result)","m")
    }
    return result
}

let calc_val = 100.0
var value : String = "183cm"
//var value = "3.14m"

var result = Convert(value: value)
print("\(result)","m")

