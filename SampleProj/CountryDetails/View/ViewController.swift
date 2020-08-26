//
//  ViewController.swift
//  SampleProj
//
//  Created by Debanjan Chakraborty on 19/07/20.
//  Copyright © 2020 Debanjan Chakraborty. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dataTableView : UITableView!
    
    lazy var countryDetailsViewModel: CountryViewModel = {
        let countryVM = CountryViewModel { (succes, error) in
            
            DispatchQueue.main.async {
                self.dataTableView.reloadData()
            }
        }
        return countryVM
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated : Bool){
        super.viewDidAppear(animated)
        
        countryDetailsViewModel.load()
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countryDetailsViewModel.elementCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        if let obj = self.countryDetailsViewModel.getData(for: indexPath.row) {
            
            cell = tableView.dequeueReusableCell(withIdentifier: "countryDetailsCell", for : indexPath)
            if let countryDetailsCell = cell as? CountryDetailsCell{
                
                countryDetailsCell.tag = indexPath.row
                countryDetailsCell.index = indexPath.row
                countryDetailsCell.countryData = obj
            }
        }
        
        return cell
    }
}



