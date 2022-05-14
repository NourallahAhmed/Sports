//
//  LatestEvents.swift
//  Sports
//
//  Created by NourAllah Ahmed on 5/13/22.
//  Copyright © 2022 NourAllah Ahmed. All rights reserved.
//

import Foundation
struct AllLatestEvents: Codable {
    let events: [Events]?
}


struct Events: Codable {

    let idEvent: String?
    let idSoccerXML: String?
    let idAPIfootball: String?
    let strEvent: String?
    let strEventAlternate: String?
    let strFilename: String?
    let strSport: String?
    let idLeague: String?
    let strLeague: String?
    let strSeason: String?
    let strDescriptionEN: String?
    let strHomeTeam: String?
    let strAwayTeam: String?
    let intHomeScore: String?
    let intRound: String?
    let intAwayScore: String?
    let intSpectators: String?
    let strOfficial: String?
    let strTimestamp: String?
    let dateEvent: String?
    let dateEventLocal: String?
    let strTime: String?
    let strTimeLocal: String?
    let strTVStation: String?
    let idHomeTeam: String?
    let idAwayTeam: String?
    let intScore: String?
    let intScoreVotes: String?
    let strResult: String?
    let strVenue: String?
    let strCountry: String?
    let strCity: String?
    let strPoster: String?
    let strSquare: String?
    let strFanart: String?
    let strThumb: String?
    let strBanner: String?
    let strMap: String?
    let strTweet1: String?
    let strTweet2: String?
    let strTweet3: String?
    let strVideo: String?
    let strStatus: String?
    let strPostponed: String?
    let strLocked: String?
}
