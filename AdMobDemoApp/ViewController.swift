//
//  ViewController.swift
//  AdMobDemoApp
//
//  Created by Tim Beals on 2018-08-20.
//  Copyright © 2018 Roobi Creative. All rights reserved.
//

import UIKit
import StoreKit

class ViewController: UIViewController {

    private var dataSource = ["non-consumable", "restore purchases"]
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.dataSource = self
        tv.delegate = self
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func viewWillLayoutSubviews() {
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
}


extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            do {
                try IAPService.shared.purchaseProduct(SKProduct.product.nonConsumable)
            } catch {
                print(error.localizedDescription)
            }
        case 1:
            IAPService.shared.restorePurchases()
        default:
            print("Error: out of bounds")
        }
    }
    
    
    
}
