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

    var idLeague: String?
    var strSport: String?
    var strLeague: String?
    var strCountry: String?
    var strWebsite: String?
    var strFacebook: String?
    var strInstagram: String?
    var strTwitter: String?
    var strYoutube: String?
    var strDescriptionEN: String?
    var strBanner: String?
    var strBadge: String?
    var strLogo: String?
    var strPoster: String?
    var strNaming: String?
    var strLocked: String?
}
