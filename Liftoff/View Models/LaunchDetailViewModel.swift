//
//  LaunchDetailViewModel.swift
//  Liftoff
//
//  Created by Syd on 4/12/19.
//  Copyright © 2019 Syd Srirak. All rights reserved.
//

import RxSwift
import RxCocoa

class LaunchDetailViewModel {
    private let launchURLString = "https://api.spacexdata.com/v3/launches/"
    private let rocketURLString = "https://api.spacexdata.com/v3/rockets/"
    private let decoder = JSONDecoder()

    var launch: BehaviorSubject<LaunchModel> = BehaviorSubject(value: LaunchModel(flightNumber: 0,
                                                                                  missionName: "",
                                                                                  launchYear: "",
                                                                                  launchDate: "",
                                                                                  launchSuccess: nil,
                                                                                  rocket: Rocket(id: ""),
                                                                                  links: Links(missionPatch: nil),
                                                                                  details: nil))
    
    var rocket: BehaviorSubject<RocketModel> = BehaviorSubject(value: RocketModel(id: 0,
                                                                                  active: true,
                                                                                  stages: 0,
                                                                                  boosters: 0,
                                                                                  costPerLaunch: 0,
                                                                                  successRatePercent: 0,
                                                                                  firstFlight: "",
                                                                                  country: "",
                                                                                  company: "",
                                                                                  wikipedia: "",
                                                                                  description: "",
                                                                                  rocketId: "",
                                                                                  rocketName: "",
                                                                                  rocketType: ""))

    init(flightNumber: Int, rocketId: String) {
        self.retrieveLaunchDetails(with: flightNumber)
        self.retrieveRocketDetails(with: rocketId)
    }

    func retrieveLaunchDetails(with flightNumber: Int) {
        guard let url = URL(string: "\(launchURLString)\(flightNumber)") else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else { return }
            do {
                let launch = try self.decoder.decode(LaunchModel.self, from: data)
                self.launch.onNext(launch)
            } catch let error {
               print("Error:", error.localizedDescription)
            }
        }.resume()
    }

    func retrieveRocketDetails(with rocketId: String) {
        guard let url = URL(string: "\(rocketURLString)\(rocketId)") else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else { return }
            do {
                let rocket = try self.decoder.decode(RocketModel.self, from: data)
                self.rocket.onNext(rocket)
            } catch let error {
               print("Error:", error.localizedDescription)
            }
        }.resume()
    }
}
