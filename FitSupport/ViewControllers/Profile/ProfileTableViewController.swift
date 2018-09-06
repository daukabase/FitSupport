//
//  ProfileTableViewController.swift
//  FitSupport
//
//  Created by Daulet on 06.08.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import UIKit
protocol DelegateProfileTable: AnyObject {
    func performSegue(with identifier: String)
}
class ProfileTableViewController: UITableViewController {
    weak var delegateTable: DelegateProfileTable?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
            case 0:
                print("first cell")
                delegateTable?.performSegue(with: "userInfo")
            case 1:
                print("second")
//                delegateTable?.performSegue(with: "userInfo")
            case 2:
                print("forth")
//                delegateTable?.performSegue(with: "userInfo")
            default:
                break
        }
    }
}
