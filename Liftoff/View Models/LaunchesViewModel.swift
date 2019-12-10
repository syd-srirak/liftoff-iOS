//
//  LaunchesViewModel.swift
//  Liftoff
//
//  Created by Syd on 3/12/19.
//  Copyright © 2019 Syd Srirak. All rights reserved.
//

import RxSwift
import RxCocoa
import RxDataSources

enum LaunchSortingOrder: Int {
    case latest, earliest, alphabetically, alphabeticallyReversed
}

enum LaunchFilter: Int {
    case all, successOnly
}

class LaunchesViewModel {
    private let launchesURLString = "https://api.spacexdata.com/v3/launches"

    private var originalLaunches: [LaunchModel] = []
    private var currentLaunches: [LaunchModel] = []
    let sections: PublishSubject<[SectionModel<String, LaunchModel>]> = PublishSubject()

    private var launchSortingOrder: LaunchSortingOrder = .latest

    func retrieveLaunches() {
        guard let url = URL(string: launchesURLString) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let launches = try decoder.decode([LaunchModel].self, from: data)
                self.originalLaunches = launches
                self.currentLaunches = launches
                self.sort(by: self.launchSortingOrder)
                self.updateSections()
            } catch let error {
               print("Error:", error.localizedDescription)
            }
        }.resume()
    }

    private func updateSections(byFirstCharacter: Bool = false, ascending: Bool = false) {
        var sectionModels: [SectionModel<String, LaunchModel>] = []
        let groupedArray = Dictionary(grouping: currentLaunches, by: { byFirstCharacter ? $0.missionNameFirstCharacter : $0.launchYear })

        var sortedLaunches: [(key: String, value: [LaunchModel])]
        if ascending {
            sortedLaunches = groupedArray.sorted { $0.key < $1.key }
        } else {
            sortedLaunches = groupedArray.sorted { $0.key > $1.key }
        }

        for sortedLaunch in sortedLaunches {
            sectionModels.append(SectionModel(model: sortedLaunch.key, items: sortedLaunch.value))
        }
        sections.onNext(sectionModels)
    }

    // MARK: - Sort Launches

    func sort(by launchSortingOrder: LaunchSortingOrder?) {
        guard let launchSortingOrder = launchSortingOrder else { return }
        self.launchSortingOrder = launchSortingOrder

        switch launchSortingOrder {
        case .latest: sort(latestFirst: true)
        case .earliest: sort(latestFirst: false)
        case .alphabetically: sort(alphabetically: true)
        case .alphabeticallyReversed: sort(alphabetically: false)
        }
    }

    private func sort(latestFirst: Bool) {
        if latestFirst {
            currentLaunches = currentLaunches.sorted { $0.launchDate > $1.launchDate }
        } else {
            currentLaunches = currentLaunches.sorted { $0.launchDate < $1.launchDate }
        }
        updateSections(ascending: latestFirst == false)
    }

    private func sort(alphabetically: Bool) {
        if alphabetically {
            currentLaunches = currentLaunches.sorted { $0.missionName < $1.missionName }
        } else {
            currentLaunches = currentLaunches.sorted { $0.missionName > $1.missionName }
        }
        updateSections(byFirstCharacter: true, ascending: alphabetically)
    }

    // MARK: - Filter Launches

    func filter(by launchFilter: LaunchFilter?) {
        if launchFilter == .all {
            currentLaunches = originalLaunches
        } else {
            currentLaunches = originalLaunches.filter { $0.launchSuccess == true }
        }

        switch launchSortingOrder {
        case .latest:
            sort(latestFirst: true)
            updateSections(ascending: false)
        case .earliest:
            sort(latestFirst: false)
            updateSections(ascending: true)
        case .alphabetically:
            sort(alphabetically: true)
            updateSections(byFirstCharacter: true, ascending: true)
        case .alphabeticallyReversed:
            sort(alphabetically: false)
            updateSections(byFirstCharacter: true, ascending: false)
        }
    }
}
