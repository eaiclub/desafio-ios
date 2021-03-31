//
//  DayTracker.swift
//  Desafio_iOS
//
//  Created by Pedro Feitosa on 30/03/21.
//

import Foundation

class DayTracker{
    
    func getDateParamenter(statingDate: String, lowerBound: Int ) -> [String]{
        
        var daysArray : [String] = [statingDate]
            
        let lowerBoundDate = Calendar.current.date(byAdding: .day, value: -lowerBound, to: statingDate.toDate()!)!
            daysArray.append(lowerBoundDate.getFormattedDate())
        return daysArray.reversed()
        
    }
    
}
