//
//  main.swift
//  UnitConverter
//
//  Created by Eunjin Kim on 2017. 10. 17..
//  Copyright © 2017년 Elly. All rights reserved.
//

import Foundation
/*
 let Unit : [String] = [] //["inch","cm","m"]
 let UnitDictionary : [String : Unit] = ["inch" : [2.54, 0.0254, 0]]
 */
let Unit = ["inch","cm","m","yard"]
let calc_val = 100.0
var inputValue : String? = nil
var PLAY = true

func SeperateUnit (value: String) -> (num: Double,unit: String) {
    var unit : Substring = ""
    var num : Double? = nil
    let unit_num = Unit.count
    for i in 0..<unit_num {
        if value.contains(Unit[i]){
            let unitCnt = Unit[i].count
            let sep = value.index(value.endIndex,offsetBy:(-unitCnt))
            
            num = Double(value[value.startIndex..<sep])
            unit = value[sep..<value.endIndex]
            break
        }
    }
    return (num!,String(unit))
}
func GetVal_ConvertVal(value: String)-> (inputVal: String,convertUnit: String){
    let tmp = value.split(separator: " ")
    let inputVal = String(tmp[0])
    var convertUnit = " "
    if value.contains(" ") {
        convertUnit = String(tmp[1])
    }
    return (inputVal, convertUnit)
}
func Cm_to_M(num: Double) -> Double{
    return num*0.01
}
func M_to_Cm(num: Double) -> Double{
    return num*100
}
func Cm_to_Inch(num: Double) -> Double{
    return num*0.393701
}
func Inch_to_Cm(num: Double) -> Double{
    return num*2.54
}
func Inch_to_M(num: Double) -> Double{
    return Cm_to_M(num: Inch_to_Cm(num: num))
}
func M_to_Inch(num: Double) -> Double{
    return Cm_to_Inch(num: M_to_Cm(num: num))
}
func Yard_to_Cm(num: Double) -> Double{
    return num*91.44
}
func Yard_to_Inch(num: Double) -> Double{
    return Cm_to_M(num: Yard_to_Cm(num: num))
}
func Cm_to_Yard(num: Double) -> Double{
    return num*0.010936
}
func M_to_Yard(num: Double) -> Double {
    return Cm_to_Yard(num: M_to_Cm(num: num))
}
func UnitConvertor (num: Double, inputUnit: String, convertUnit: String) -> (num: Double, convertUnit: String) {
    var convtNum = 0.0
    var convtUnit = ""
    if(inputUnit=="cm" && (convertUnit=="m" || convertUnit==" ")){
        convtNum = Cm_to_M(num: num)
        convtUnit = "m"
    } else if(inputUnit=="m" && (convertUnit=="cm" || convertUnit==" ")){
        convtNum = M_to_Cm(num: num)
        convtUnit = "cm"
    } else if(inputUnit=="cm" && convertUnit=="inch"){
        convtNum = Cm_to_Inch(num: num)
        convtUnit = convertUnit
    } else if(inputUnit=="inch" && convertUnit=="cm"){
        convtNum = Inch_to_Cm(num: num)
        convtUnit = convertUnit
    } else if(inputUnit=="inch" && convertUnit=="m"){
        convtNum = Inch_to_M(num: num)
        convtUnit = convertUnit
    } else if(inputUnit=="m" && convertUnit=="inch"){
        convtNum = M_to_Inch(num: num)
        convtUnit = convertUnit
    } else if(inputUnit=="yard" && (convertUnit=="m" || convertUnit==" ")){
        convtNum = Yard_to_Inch(num: num)
        convtUnit = "m"
    } else if(inputUnit=="m" && convertUnit=="yard"){
        convtNum = M_to_Yard(num: num)
        convtUnit = convertUnit
    }
    
    else if(!Unit.contains(inputUnit) || !Unit.contains(convertUnit)){
        print("지원하지 않는 단위입니다.")
        return (0.0,"")
    }
    return (convtNum,convtUnit)
}
func Convert (str: String) -> String {
    //입력값 2개 받는 함수(공백으로 구분)
    let inputval = GetVal_ConvertVal(value: "\(str)")
    let sepValue = SeperateUnit(value: "\(inputval.inputVal)")
    let convertUnit = inputval.convertUnit
    
    let result = UnitConvertor(num: sepValue.num, inputUnit: sepValue.unit, convertUnit: convertUnit)
    if(result.num==0.0 && result.convertUnit==""){
        return ""
    }
    return String(result.num)+result.convertUnit
}

repeat{
    print("값 입력: ")
    inputValue = readLine()
    //print(inputValue!)
    if inputValue == "q" || inputValue == "quit" {
        PLAY = false
    }else if inputValue != nil {
        let result = Convert(str: inputValue!)
        print("\(result)","")
    }
}while PLAY

