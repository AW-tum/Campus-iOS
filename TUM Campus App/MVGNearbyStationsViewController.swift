//
//  MVGNearbyStationsViewController.swift
//  Abfahrt
//
//  Created by Lukas Kollmer on 17.06.17.
//  Copyright © 2017 Lukas Kollmer. All rights reserved.
//

import UIKit

class MVGNearbyStationsViewController: UITableViewController, DetailView {
    
    weak var delegate: DetailViewDelegate?
    
    var nearestStations = [Station]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func loadView() {
        super.loadView()
        
        title = "Nearby Stations"
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refresh()
    }
    
    func refresh() {
        delegate?.dataManager()?.mvgManager.fetch().onSuccess(in: .main) { stations in
            self.nearestStations = stations
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if var mvc = segue.destination as? DetailView {
            mvc.delegate = delegate
        }
    }
    
    // MARK: Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nearestStations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return tableView.dequeueReusableCell(withIdentifier: "station", for: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let station = nearestStations[indexPath.row]
        
        cell.textLabel?.text = station.name
        if let distance = station.distance {
            cell.detailTextLabel?.text = "\(distance) m"
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let station = nearestStations[indexPath.row]
        
        let vc = DeparturesViewController(station: station)
        
        navigationController?.pushViewController(vc, animated: true)
    }

}

