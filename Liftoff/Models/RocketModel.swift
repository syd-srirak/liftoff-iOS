//
//  RocketModel.swift
//  Liftoff
//
//  Created by Syd on 4/12/19.
//  Copyright © 2019 Syd Srirak. All rights reserved.
//

import Foundation

struct RocketModel: Decodable {
    let id: Int
    let active: Bool
    let stages: Int
    let boosters: Int
    let costPerLaunch: Int
    let successRatePercent: Int
    let firstFlight: String
    let country: String
    let company: String
    let wikipedia: String
    let description: String
    let rocketId: String
    let rocketName: String
    let rocketType: String

    enum CodingKeys: String, CodingKey {
        case id
        case active
        case stages
        case boosters
        case costPerLaunch = "cost_per_launch"
        case successRatePercent = "success_rate_pct"
        case firstFlight = "first_flight"
        case country
        case company
        case wikipedia
        case description
        case rocketId = "rocket_id"
        case rocketName = "rocket_name"
        case rocketType = "rocket_type"
    }
}
