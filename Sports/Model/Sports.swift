//
//  Sports.swift
//  Sports
//
//  Created by abdelrahmanhz on 5/12/22.
//  Copyright © 2022 NourAllah Ahmed. All rights reserved.
//

import Foundation

struct AllSports: Codable {
    let sports: [Sports]?
}

struct Sports: Codable {

    let idSport: String?
    let strSport: String?
    let strFormat: String?
    let strSportThumb: String?
    let strSportIconGreen: String?
    let strSportDescription: String?
}

struct AllCountries: Codable {
    let countries: [Countries]?
}

struct Countries: Codable {

    let nameEn: String
}
