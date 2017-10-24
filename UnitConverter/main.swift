//
//  main.swift
//  UnitConverter
//
//  Created by Eunjin Kim on 2017. 10. 17..
//  Copyright © 2017년 Elly. All rights reserved.
//

import Foundation

var PLAY = true
//let Units = ["inch", "cm", "m", "yard", "g", "kg", "lb", "oz", "l", "pt", "qt", "gal"]

enum LengthConvertValue: Double {
    case CmToM = 0.01
    case CmToYard = 0.010936
    case MToCm = 100
    case MToInch = 39.370079
    case InchToM = 0.0254
    case YardToCm = 91.44
}
enum WeightConvertValue: Double {
    case GTokg = 0.001
    case KgToG = 1000
    case OzToKg = 0.0283495
    case LbToKg = 0.453592
    case KgToOz = 35.273962
    case KgToLb = 2.204623
}
enum VolumeConvertValue: Double {
    case LToPT = 2.113379
    case LToQt = 1.056688
    case LToGal = 0.264172
    case PtToL = 0.473176
    case QtToL = 0.946353
    case GalToL = 3.78541
}


class Length {
    static func cmToM(_ value: Double) -> Double {
        return value * LengthConvertValue.CmToM.rawValue
    }
    static func cmToYard(_ value: Double) -> Double {
        return value * LengthConvertValue.CmToYard.rawValue
    }
    static func inchToM(_ value: Double) -> Double {
        return value * LengthConvertValue.InchToM.rawValue
    }
    static func mToInch(_ value: Double) -> Double {
        return value * LengthConvertValue.MToInch.rawValue
    }
    static func yardToCm(_ value: Double) -> Double {
        return value * LengthConvertValue.YardToCm.rawValue
    }
    static func mToCm(_ value: Double) -> Double {
        return value * LengthConvertValue.MToCm.rawValue
    }
}

class Weight {
    static func gTokg(_ value: Double) -> Double {
        return value * WeightConvertValue.GTokg.rawValue
    }
    static func kgToG(_ value: Double) -> Double {
        return value * WeightConvertValue.KgToG.rawValue
    }
    static func kgToLb(_ value: Double) -> Double {
        return value * WeightConvertValue.KgToLb.rawValue
    }
    static func kgToOz(_ value: Double) -> Double {
        return value * WeightConvertValue.KgToOz.rawValue
    }
    static func lbToKg(_ value: Double) -> Double {
        return value * WeightConvertValue.LbToKg.rawValue
    }
    static func ozToKg(_ value: Double) -> Double {
        return value * WeightConvertValue.OzToKg.rawValue
    }
}

class Volume {
    static func galToL(_ value: Double) -> Double {
        return value * VolumeConvertValue.GalToL.rawValue
    }
    static func lToGal(_ value: Double) -> Double {
        return value * VolumeConvertValue.LToGal.rawValue
    }
    static func lToPT(_ value: Double) -> Double {
        return value * VolumeConvertValue.LToPT.rawValue
    }
    static func lToQt(_ value: Double) -> Double {
        return value * VolumeConvertValue.LToQt.rawValue
    }
    static func ptToL(_ value: Double) -> Double {
        return value * VolumeConvertValue.PtToL.rawValue
    }
    static func qtToL(_ value: Double) -> Double {
        return value * VolumeConvertValue.QtToL.rawValue
    }
}
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
    func seperateConvertUnit(value: String) -> Array<Substring> {
        let Units = value.split(separator: ",")
        return Units
    }
}

// convert each unit
class UnitConverter {

    //show every convert units
    func noConvertUnit(num: Double, inputUnit: String) {
        
    }
    //show one convert unit
    func oneConvertUnit(num: Double, inputUnit: String, convertUnit: String) -> (num: Double, convertUnit: String) {
        var convtNum = 0.0
        var convtUnit = convertUnit
        var tmp = 0.0
        
        //inputUnit -> convertUnit
        switch (inputUnit,convertUnit){
        case ("cm","m"): convtNum = Length.cmToM(num)
        //case ("cm"," "): convtNum = Length.cmToM(num); convtUnit = "m"
        case ("m","cm"): convtNum = Length.mToCm(num)
        //case ("m", " "): convtNum = Length.mToCm(num); convtUnit = "cm"
        case ("cm","inch"): tmp = Length.cmToM(num); convtNum = Length.mToInch(tmp)
        case ("inch","cm"): tmp = Length.inchToM(num); convtNum = Length.mToCm(tmp)
        case ("m","inch"): convtNum = Length.mToInch(num)
        case ("inch","m"): convtNum = Length.inchToM(num)
        case ("yard","m"): tmp = Length.yardToCm(num); convtNum = Length.cmToM(tmp)
        //case ("yard"," "): tmp = Length.yardToCm(num); convtNum = Length.cmToM(tmp); convtUnit = "m"
        case ("m","yard"): tmp = Length.mToCm(num); convtNum = Length.cmToYard(tmp)
            
        case ("g","kg"): convtNum = Weight.gTokg(num)
        case ("kg","g"): convtNum = Weight.kgToG(num)
        case ("kg","lb"): convtNum = Weight.kgToLb(num)
        case ("kg","oz"): convtNum = Weight.kgToOz(num)
        case ("lb","kg"): convtNum = Weight.lbToKg(num)
        case ("oz","kg"): convtNum = Weight.ozToKg(num)
            
        case ("gal","l"): convtNum = Volume.galToL(num)
        case ("l","gal"): convtNum = Volume.lToGal(num)
        case ("l","pt"): convtNum = Volume.lToPT(num)
        case ("l","qt"): convtNum = Volume.lToQt(num)
        case ("pt","l"): convtNum = Volume.ptToL(num)
        case ("qt","l"): convtNum = Volume.qtToL(num)
            
        default:
            print("지원하지 않는 단위입니다.")
        }
        
        return (convtNum,convtUnit)

    }
    //show input each convert unit
    func manyConvertUnit(num: Double, inputUnit: String, convertUnit: Array<String>){
        
    }
}

// operate func
func convert (str: String) -> String {
    let inputWholeStr = Seperate()
    let inputval = inputWholeStr.seperateInputValConvertUnit(value: "\(str)")
    let sepValue = inputWholeStr.seperateNumberUnit(value: "\(inputval.inputVal)")
    //let sepUnits = inputWholeStr.seperateConvertUnit(value: "\(inputval.convertUnit)")

    let convertUnit = inputval.convertUnit
    
    let converter = UnitConverter()
    let result = converter.oneConvertUnit(num: sepValue.num, inputUnit: sepValue.unit, convertUnit: convertUnit)
    if(result.num == 0.0 && result.convertUnit == ""){
        return ""
    }
    return String(result.num) + result.convertUnit
}

func prompt() {
    var inputValue: String? = ""
    repeat{
        print("값 입력: ")
        inputValue = readLine()
        
        if inputValue == "q" || inputValue == "quit" {
            PLAY = false
        }else if inputValue != nil {
            let result = convert(str: inputValue!)
            print("\(result)","")
        }
    }while PLAY
}

prompt()


