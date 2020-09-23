//
//  PickupsViewController.swift
//  labs-ios-starter
//
//  Created by Wyatt Harrell on 8/12/20.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import UIKit

class PickupsViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    private var pickups: [Pickup] = []
    private let controller = BackendController.shared
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        grabPickups()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    // MARK: - Private Methods
    private func grabPickups() {
        for pickup in controller.pickups.values {
            pickups.append(pickup)
        }
    }
}

extension PickupsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return pickups.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SchedulePickupCell", for: indexPath)
                        
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PickupCell", for: indexPath) as? PickupTableViewCell else { return UITableViewCell() }
            
            let pickup = pickups[indexPath.row]
            cell.pickup = pickup
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 && indexPath.section == 0 {
            performSegue(withIdentifier: "ShowScheduleNewPushSegue", sender: self)
        }
    }
}
