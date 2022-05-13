//
//  League.swift
//  Sports
//
//  Created by NourAllah Ahmed on 5/13/22.
//  Copyright © 2022 NourAllah Ahmed. All rights reserved.
//

import Foundation

struct AllLegaues: Codable {
    let countries: [ Legaues]?
}

struct Legaues: Codable {

    let idLeague: String?
    let strSport: String?
    let strLeague: String?
    let strCountry: String?
    let strWebsite: String?
    let strFacebook: String?
    let strInstagram: String?
    let strTwitter: String?
    let strYoutube: String?
    let strDescriptionEN: String?
    let strBanner: String?
    let strBadge: String?
    let strLogo: String?
    let strPoster: String?
    let strNaming: String?
    let strLocked: String?
}
