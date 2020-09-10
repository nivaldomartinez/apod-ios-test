//
//  Date+Prueba.swift
//  Prueba
//
//  Created by Nivaldo Martinez on 9/9/20.
//  Copyright © 2020 Nivaldo Martinez. All rights reserved.
//

import Foundation

extension Date {
    func getDateFrom(days: Int) -> Date? {
        return Calendar.current.date(byAdding: .day, value: days, to: Date())
    }
    
    func format(_ format: String = MAIN_DATE_FORMAT) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: self)
    }
}
