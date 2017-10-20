//
//  main.swift
//  UnitConverter
//
//  Created by Eunjin Kim on 2017. 10. 17..
//  Copyright © 2017년 Elly. All rights reserved.
//

import Foundation

var PLAY = true
let Units = ["inch","cm","m","yard"]
extension Double {
    var cmToM: Double { return self/100 }
    var cmToinch: Double { return self.cmToM.mToInch }
    var cmToYard: Double { return self*0.010936}
    var mToCm: Double { return self*100 }
    var mToInch: Double { return self*39.370079 }
    var mToYard: Double { return self.mToCm.cmToYard }
    var inchTocm: Double { return self.inchToM.mToCm }
    var inchToM: Double { return self*0.0254 }
    var yardToCm: Double { return self*91.44}
    var yardToM: Double { return self.yardToCm.cmToM }
}

// seperate inputvalue to number and unit
func SeperateNumber_Unit (value: String) -> (num: Double,unit: String) {
    var unit : Substring = ""
    var num : Double? = nil
    let unit_size = Units.count
    for i in 0..<unit_size {
        if value.contains(Units[i]){
            let unitCnt = Units[i].count
            let sep = value.index(value.endIndex,offsetBy:(-unitCnt))
            
            num = Double(value[value.startIndex..<sep])
            unit = value[sep..<value.endIndex]
            break
        }
    }
    return (num!,String(unit))
}

// seperate inputvalue and convert unit
func SeperateInputVal_ConvertUnit(value: String)-> (inputVal: String,convertUnit: String){
    let tmp = value.split(separator: " ")
    let inputVal = String(tmp[0])
    var convertUnit = " "
    if value.contains(" ") {
        convertUnit = String(tmp[1])
    }
    return (inputVal, convertUnit)
}

// convert each unit
func UnitConvertor (num: Double, inputUnit: String, convertUnit: String) -> (num: Double, convertUnit: String) {
    var convtNum = 0.0
    var convtUnit = convertUnit
    
    //inputUnit -> convertUnit
    switch (inputUnit,convertUnit){
        case ("cm","m"): convtNum = num.cmToM
        case ("cm"," "): convtNum = num.cmToM; convtUnit = "m"
        case ("m","cm"): convtNum = num.mToCm
        case ("m", " "): convtNum = num.mToCm; convtUnit = "cm"
        case ("cm","inch"): convtNum = num.cmToinch
        case ("inch","cm"): convtNum = num.inchTocm
        case ("m","inch"): convtNum = num.mToInch
        case ("inch","m"): convtNum = num.inchToM
        case ("yard","m"): convtNum = num.yardToM
        case ("yard"," "): convtNum = num.yardToM; convtUnit = "m"
        case ("m","yard"): convtNum = num.mToYard
        default:
            print("지원하지 않는 단위입니다.")
    }
    return (convtNum,convtUnit)
}

// operate func
func Convert (str: String) -> String {
    let inputval = SeperateInputVal_ConvertUnit(value: "\(str)")
    let sepValue = SeperateNumber_Unit(value: "\(inputval.inputVal)")
    let convertUnit = inputval.convertUnit
    
    let result = UnitConvertor(num: sepValue.num, inputUnit: sepValue.unit, convertUnit: convertUnit)
    if(result.num==0.0 && result.convertUnit==""){
        return ""
    }
    return String(result.num)+result.convertUnit
}

func Prompt() {
    var inputValue : String? = ""
    repeat{
        print("값 입력: ")
        inputValue = readLine()
    
        if inputValue == "q" || inputValue == "quit" {
            PLAY = false
        }else if inputValue != nil {
            let result = Convert(str: inputValue!)
            print("\(result)","")
        }
    }while PLAY
}

Prompt()

