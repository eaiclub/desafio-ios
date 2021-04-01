//
//  DayTracker.swift
//  Desafio_iOS
//
//  Created by Pedro Feitosa on 30/03/21.
//

import Foundation

/// Classe especialista para se lidar com datas.
class DayTracker{
    
    /// Método responsável por separar os valores entre duas datas.
    /// - Parameters:
    ///   - statingDate: Data inicial.
    ///   - lowerBound: Numero de dias da data inicial para se ter o espaço amostral.
    /// - Returns: Array com todos as datas entre as duas datas.
    func getDateParamenter(statingDate: String, lowerBound: Int ) -> [String]{
        
        var daysArray : [String] = [statingDate]
            
        let lowerBoundDate = Calendar.current.date(byAdding: .day, value: -lowerBound, to: statingDate.toDate()!)!
            daysArray.append(lowerBoundDate.getFormattedDate())
        return daysArray.reversed()
        
    }
    
}
