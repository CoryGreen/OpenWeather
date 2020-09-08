//
//  TableViewController.swift
//  OpenWeather
//
//  Created by C.Green on 22/10/2018.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    private var requestModel: FiveDayForcastModel!
    
     var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, dd/MMM HH:mm"
        return dateFormatter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestModel = FiveDayForcastModel(OWClient())
        
        requestModel.updateForcast(in: "London") { result in
            
            switch result {
            case true:
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            case false: break
            }
            
        }
        
        tableView.register(ForcastTableViewCell.self)
    }
    
    @IBAction func refresh(_ sender: UIRefreshControl) {
        
        requestModel.updateForcast(in: "London") { result in
            
            switch result {
            case true:
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    sender.endRefreshing()
                }
                
            case false: break
            }
            
        }
        
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return requestModel.numberOfSections()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requestModel.numberOfItems(in: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeue(reusableCell: ForcastTableViewCell.self, for: indexPath)
        
        let information = requestModel.item(at: indexPath)
        cell.configure(with: information, using: dateFormatter)
        
        return cell
        
    }

}

