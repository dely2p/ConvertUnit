//
//  main.swift
//  UnitConverter
//
//  Created by Eunjin Kim on 2017. 10. 17..
//  Copyright © 2017년 Elly. All rights reserved.
//

import Foundation

var PLAY = true

var lengthDic = ["cm": 1, "m": 100, "inch": 2.54, "yard": 91.44]
var weightDic = ["g": 1, "kg": 1000, "oz": 0.02835, "lb": 0.453592]
var volumeDic = ["l": 1, "pt": 0.473176, "qt": 0.946353, "gal": 3.78541]

//extension Double {
//    func roundOfPosit( posit: Int ) -> Double {
//        let div = pow(10.0, Double(posit))
//        let value = self * div
//        return round(value) / div
//    }
//}

protocol Units {
    var unit: String { get set }
    func baseToAny(num: Double, convertUnit: String) -> Double
    func anyToBase(num: Double, inputUnit: String) -> Double
}

class Length: Units {
    var unit: String
    init() {
        unit = "cm"
    }
    
    func baseToAny(num: Double, convertUnit: String) -> Double {
        return num / lengthDic[lengthDic.index(forKey: convertUnit)!].value
    }
    func anyToBase(num: Double, inputUnit: String) -> Double {
        return num * lengthDic[lengthDic.index(forKey: inputUnit)!].value
    }
}

class Weight: Units {
    var unit: String
    init() {
        unit = "kg"
    }
    
    func baseToAny(num: Double, convertUnit: String) -> Double {
        return num / weightDic[weightDic.index(forKey: convertUnit)!].value
    }
    func anyToBase(num: Double, inputUnit: String) -> Double {
        return num * weightDic[weightDic.index(forKey: inputUnit)!].value
    }
}

class Volume: Units {
    var unit: String
    init() {
        unit = "l"
    }
    
    func baseToAny(num: Double, convertUnit: String) -> Double {
        return num / volumeDic[volumeDic.index(forKey: convertUnit)!].value
    }
    func anyToBase(num: Double, inputUnit: String) -> Double {
        return num * volumeDic[volumeDic.index(forKey: inputUnit)!].value
    }
}

// seperate input string
class Seperate {
    // seperate inputvalue and convert unit(" ")
    func seperateInputValConvertUnit(value: String)-> (inputVal: String, convertUnit: String){
        let tmp = value.split(separator: " ")
        let inputVal = String(tmp[0])
        var convertUnit = " "
        if value.contains(" ") {
            convertUnit = String(tmp[1])
        }
        return (inputVal, convertUnit)
    }

    // seperate inputvalue to number and unit(number, word)
    func seperateNumberUnit (value: String) -> (num: Double, unit: String) {
        var cnt = 0
        for i in value {
            if (i >= "a" && i <= "z") || (i >= "A" && i <= "Z") { //word
                break;
            }else {
                cnt += 1;
            }
        }
        let numIndex = value.index(value.startIndex, offsetBy: cnt)
        let num = Double(value[value.startIndex..<numIndex])
        let unit = value[numIndex..<value.endIndex]
        
        return (num!,String(unit))
    }
    
    // seperate units(,)
    func seperateConvertUnit(value: String) -> Array<String> {
        let Units = value.split(separator: ",")
        return Units.map(String.init)
    }
}

// convert each unit
class UnitConverter {

    var unitDic: [String : Double] = [:]
    var kindOfUnit: Units = Length()
    var baseUnit: String

    init(inputUnit: String) {
        baseUnit = kindOfUnit.unit
        if lengthDic.keys.contains(inputUnit) {
            kindOfUnit = Length()
            unitDic = lengthDic
        }else if weightDic.keys.contains(inputUnit){
            kindOfUnit = Weight()
            unitDic = weightDic
        }else if volumeDic.keys.contains(inputUnit){
            kindOfUnit = Volume()
            unitDic = volumeDic
        }
    }
    
    //show every convert units
    func noConvertUnit(num: Double, inputUnit: String) -> String {
        var numArr = [Double]()
        var unitArr = [String]()
        var noConvertUnitResult: String = ""
        //var result: Double

        for unit in unitDic.keys {
            var result: Double
            if inputUnit == baseUnit {
                result = kindOfUnit.baseToAny(num: num, convertUnit: unit)
            }else if unit == baseUnit {
                result = kindOfUnit.anyToBase(num: num, inputUnit: inputUnit)
            }else {
                let tmp = kindOfUnit.anyToBase(num: num, inputUnit: inputUnit)
                result = kindOfUnit.baseToAny(num: tmp, convertUnit: unit)
            }
            numArr.append(result)
            unitArr.append(unit)
            if unit == inputUnit {
                continue
            }else{
                noConvertUnitResult += String(format: "%5.2f", result) + unit + "\n"
            }
        }

        return noConvertUnitResult
    }
    //show one convert unit
    func oneConvertUnit(num: Double, inputUnit: String, convertUnit: String) -> String {
        let baseUnit = kindOfUnit.unit
        var result: Double
        var oneConvertUnitResult: String = ""
        
        if inputUnit == baseUnit {
            result = kindOfUnit.baseToAny(num: num, convertUnit: convertUnit)
        }else if convertUnit == baseUnit {
            result = kindOfUnit.anyToBase(num: num, inputUnit: inputUnit)
        }else {
            let tmp = kindOfUnit.anyToBase(num: num, inputUnit: inputUnit)
            result = kindOfUnit.baseToAny(num: tmp, convertUnit: convertUnit)
        }
        oneConvertUnitResult += String(result) + baseUnit
        return oneConvertUnitResult
    }
    
    //show input each convert unit
    func manyConvertUnit(num: Double, inputUnit: String, convertUnit: Array<String>) -> String {
        var manyConvertUnitResult: String = ""
        var numArr = [Double]()
        var unitArr = [String]()
        
        for unit in convertUnit {
            var result: Double
            if inputUnit == baseUnit {
                result = kindOfUnit.baseToAny(num: num, convertUnit: unit)
            }else if unit == baseUnit {
                result = kindOfUnit.anyToBase(num: num, inputUnit: inputUnit)
            }else {
                let tmp = kindOfUnit.anyToBase(num: num, inputUnit: inputUnit)
                result = kindOfUnit.baseToAny(num: tmp, convertUnit: unit)
            }
            numArr.append(result)
            unitArr.append(unit)
            manyConvertUnitResult += String(result) + unit + "\n"
        }
        return manyConvertUnitResult
    }
}

// operate func
func convert (str: String) -> String {
    
    let inputWholeStr = Seperate()
    let inputVal = inputWholeStr.seperateInputValConvertUnit(value: "\(str)")
    let sepValue = inputWholeStr.seperateNumberUnit(value: "\(inputVal.inputVal)")
    let sepUnits = inputWholeStr.seperateConvertUnit(value: "\(inputVal.convertUnit)")
    var convertUnitCnt = sepUnits.count
    let convertor = UnitConverter(inputUnit: sepValue.unit)
    var convertResult: String = ""
    
    if inputVal.convertUnit == " " {
        convertUnitCnt = 0
    }
    
    switch convertUnitCnt {
        case 0:
            convertResult = convertor.noConvertUnit(num: sepValue.num, inputUnit: sepValue.unit)
        case 1:
            convertResult = convertor.oneConvertUnit(num: sepValue.num, inputUnit: sepValue.unit, convertUnit: inputVal.convertUnit)
        case 2:
            convertResult = convertor.manyConvertUnit(num: sepValue.num, inputUnit: sepValue.unit, convertUnit: sepUnits)
        default:
            print("error")
    }
    return convertResult
}
class Main{
    var result: String
    init() {
        result = ""
    }
    
    func prompt(){
        var inputValue: String? = ""
        repeat{
        print("값 입력: ")
        inputValue = readLine()
        
        if inputValue == "q" || inputValue == "quit" {
            PLAY = false
        }else if inputValue != nil {
            result = convert(str: inputValue!)
            mainPrint()
        }
        }while PLAY
    }
    func mainPrint(){
        print(result)
    }
}
var main = Main()
main.prompt()
