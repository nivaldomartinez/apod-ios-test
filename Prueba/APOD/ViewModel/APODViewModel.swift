//
//  APODViewModel.swift
//  Prueba
//
//  Created by Nivaldo Martinez on 9/9/20.
//  Copyright © 2020 Nivaldo Martinez. All rights reserved.
//

import Foundation
import Alamofire

class APODViewModel {
    
    var refreshDataSource = { () -> () in }
    
    var datasource: [APOD] = [] {
        didSet {
            refreshDataSource()
        }
    }
    
    /// fetch apods from last 8 days
    func fetchLastApods() {
        DispatchQueue.global(qos: .background).async {
            let group = DispatchGroup()
            var apods = [APOD]()
            
            for day in 0...7 {
                if let date = Date().getDateFrom(days: -day) {
                    group.enter()
                    self.fetchApodBy(date: date) {apod in
                        apods.append(apod)
                        group.leave()
                    }
                }
            }

            group.wait()
            let orderedApods = apods.sorted(by: {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = MAIN_DATE_FORMAT
                return dateFormatter.date(from: $0.date)!.compare(dateFormatter.date(from: $1.date)!) == .orderedDescending
            })
            self.datasource = orderedApods
        }
    }
    
    func fetchApodBy(date: Date, completionHandler: ((APOD) -> Swift.Void)? = nil) { AF.request("https://api.nasa.gov/planetary/apod?date=\(date.format())&api_key=\(API_KEY)").responseDecodable(of: APOD.self) { response in
            guard let apod = response.value else { return }
            if let completionHandler = completionHandler {
                completionHandler(apod)
            } else {
                self.datasource = [apod]
            }
        }
    }
}
