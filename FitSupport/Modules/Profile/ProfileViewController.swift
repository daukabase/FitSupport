//
//  ProfileViewController.swift
//  FitSupport
//
//  Created by Daulet on 06.08.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, DelegateProfileTable, UserInfoDelegate, Customizable {
    
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var weight: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if currentUser != nil{
            setUserInformation()
        }
    }
    
    func commonInit() {
        avatar.image = #imageLiteral(resourceName: "AVA")
        avatar.layer.cornerRadius = avatar.frame.height/2
        avatar.layer.borderColor = UIColor.darkBlue.cgColor
        avatar.layer.borderWidth = 0.5
    }
    
    func setUserInformation() {
        guard let currentUser = currentUser else { return }
        name.text = currentUser.name
        age.text = "\(currentUser.age ?? 0) лет"
        weight.text = "\(Int(currentUser.currentWeight ?? 0)) кг"
    }
    
    func update(current user: User) {
        currentUser = user
    }
    
    func performSegue(with identifier: String) {
        performSegue(withIdentifier: identifier, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "profileTable" {
            if let profileTable = segue.destination as? ProfileTableViewController {
                profileTable.delegate = self
            }
        } else if segue.identifier == "userInfo" {
            if let userInfoVC = segue.destination as? UserInfoViewController {
                userInfoVC.currentUser = currentUser
                userInfoVC.delegate = self
            }
        }
    }
}
