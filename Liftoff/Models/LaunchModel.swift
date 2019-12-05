//
//  LaunchModel.swift
//  Liftoff
//
//  Created by Syd on 3/12/19.
//  Copyright © 2019 Syd Srirak. All rights reserved.
//

import Foundation

struct Rocket: Decodable {
    let id: String

    enum CodingKeys: String, CodingKey {
        case id = "rocket_id"
    }
}

struct Links: Codable {
    let missionPatch: String?

    enum CodingKeys: String, CodingKey {
        case missionPatch = "mission_patch"
    }
}

struct LaunchModel: Decodable {
    let flightNumber: Int
    let missionName: String
    let launchYear: String
    let launchDate: String
    let launchSuccess: Bool?
    let rocket: Rocket
    let links: Links
    let details: String?

    var missionNameFirstCharacter: String {
        return String(self.missionName.prefix(1))
    }

    enum CodingKeys: String, CodingKey {
        case flightNumber = "flight_number"
        case missionName = "mission_name"
        case launchYear = "launch_year"
        case launchDate = "launch_date_local"
        case launchSuccess = "launch_success"
        case rocket
        case links
        case details
    }
}
