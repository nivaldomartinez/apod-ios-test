//
//  APOD.swift
//  Prueba
//
//  Created by Nivaldo Martinez on 9/9/20.
//  Copyright © 2020 Nivaldo Martinez. All rights reserved.
//

import Foundation

struct APOD: Codable {
    var title: String
    var url: URL
    var hdurl: URL?
    var explanation: String
    var copyright: String?
    var date: String
}
