//
//  LaunchDetailViewController.swift
//  Liftoff
//
//  Created by Syd on 3/12/19.
//  Copyright © 2019 Syd Srirak. All rights reserved.
//

import RxSwift

protocol LaunchDetailNavigationDelegate: class {
    func presentRocketInformation(url: URL)
}

class LaunchDetailViewController: UIViewController {

    @IBOutlet var stackView: UIStackView!
    @IBOutlet var rocketImageContainer: UIView!
    @IBOutlet var rocketImageView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var missionDetailsTextView: UITextView!
    @IBOutlet var launchDateLabel: UILabel!
    @IBOutlet var costLabel: UILabel!
    @IBOutlet var countryLabel: UILabel!
    @IBOutlet var companyLabel: UILabel!
    @IBOutlet var rocketDescriptionTextView: UITextView!
    @IBOutlet var moreInformationButton: UIButton!

    var viewModel: LaunchDetailViewModel!
    private let disposeBag = DisposeBag()
    private let dateFormatter = DateFormatter()

    weak var delegate: LaunchDetailNavigationDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()

        viewModel.launch.subscribe(onNext: { [weak self] launch in
            guard let self = self, launch.missionName.count > 0 else { return }
            self.setupUI(from: launch)
        }, onError: { _ in
            self.stackView.isHidden = true
        }).disposed(by: disposeBag)

        viewModel.rocket.subscribe(onNext: { [weak self] rocket in
            guard let self = self, rocket.rocketName.count > 0 else { return }
            self.setupUI(from: rocket)
        }, onError: { _ in
            self.stackView.isHidden = true
        }).disposed(by: disposeBag)
    }

    // MARK: - Setup UI

    private func setup() {
        dateFormatter.dateFormat = Date.localFormat
        moreInformationButton.layer.cornerRadius = 8.0
    }

    private func setupUI(from launch: LaunchModel) {
        DispatchQueue.main.async {
            self.stackView.isHidden = false
            if let missionPatch = launch.links.missionPatch, let patchURL = URL(string: missionPatch) {
                self.activityIndicator.startAnimating()
                self.rocketImageContainer.isHidden = false
                self.rocketImageView.load(url: patchURL, completion: { success in
                    self.activityIndicator.stopAnimating()
                    if success {
                        self.rocketImageContainer.isHidden = false
                    } else {
                        self.rocketImageContainer.isHidden = true
                    }
                })

            } else {
                self.rocketImageContainer.isHidden = true
                self.activityIndicator.stopAnimating()
            }

            if let launchDetails = launch.details {
                self.missionDetailsTextView.text = launchDetails
                self.missionDetailsTextView.isHidden = false
            } else {
                self.missionDetailsTextView.isHidden = true
            }

            if let launchDate = self.dateFormatter.date(from: launch.launchDate)?.toString(dateStyle: .medium) {
                let launchDatePrefix: String
                if let launchSuccess = launch.launchSuccess {
                    if launchSuccess {
                        launchDatePrefix = "Successful launch on"
                    } else {
                        launchDatePrefix = "Failed launch on"
                    }
                } else {
                    launchDatePrefix = "To be launched on"
                }
                self.launchDateLabel.text = "\(launchDatePrefix) \(launchDate)"
                self.launchDateLabel.isHidden = false
            } else {
                self.launchDateLabel.isHidden = true
            }
        }
    }

    private func setupUI(from rocket: RocketModel) {
        DispatchQueue.main.async {
            self.stackView.isHidden = false
            self.costLabel.text = "$\(rocket.costPerLaunch)"
            self.countryLabel.text = rocket.country
            self.companyLabel.text = rocket.company
            self.rocketDescriptionTextView.text = rocket.description
            self.moreInformationButton.setTitle("\(rocket.rocketName) 🚀", for: .normal)
            self.moreInformationButton.isHidden = false
        }
    }

    // MARK: - IBAction

    @IBAction func moreInformationButtonPressed(_ sender: Any) {
        guard let url = try? URL(string: viewModel.rocket.value().wikipedia) else { return }
        delegate?.presentRocketInformation(url: url)
    }
}
