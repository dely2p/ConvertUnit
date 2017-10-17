//
//  main.swift
//  UnitConverter
//
//  Created by Eunjin Kim on 2017. 10. 17..
//  Copyright © 2017년 Elly. All rights reserved.
//

import Foundation
var Unit = ["cm", "m"]
let calc_val = 100.0

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
    if(num != nil){
        //print(num!, String(unit))
    }else{
        //print("num is nil")
        //print("unit: ",unit)
    }
    return (num!,String(unit))
//    return (0.1,"")
}

func Convert (str: String) -> String {
    
    let sepValue = SeperateUnit(value: "\(str)")
    var result : String = ""
    
    if sepValue.unit=="cm"{ // cm to m
        result = "\(sepValue.num/calc_val)m"
    }else if sepValue.unit=="m" { // m to cm
        result = "\(Int(sepValue.num*calc_val))cm"
    }
    return result
}

print("값 입력: ")
if let inputValue = readLine(){
    let result = Convert(str: inputValue)
    print("\(result)","")
}
