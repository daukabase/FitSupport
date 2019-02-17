//
//  ProfileViewController.swift
//  FitSupport
//
//  Created by Daulet on 06.08.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, DelegateProfileTable, UserInfoDelegate {
    
    
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
    
    func setUserInformation(){
        guard let currentUser = currentUser else {
            return
        }
        avatar.image = #imageLiteral(resourceName: "AVA")
        avatar.layer.cornerRadius = avatar.frame.height/2
        avatar.layer.borderColor = GlobalColors.darkBlue.color().cgColor
        avatar.layer.borderWidth = 0.5
        name.text = currentUser.name
        age.text = "\(currentUser.age ?? 0) лет"
        weight.text = "\(Int(currentUser.currentWeight ?? 0)) кг"
    }
    
    func update(cuurent user: User) {
        currentUser = user
    }
    
    func performSegue(with identifier: String) {
        performSegue(withIdentifier: identifier, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "profileTable"{
            if let profileTable = segue.destination as? ProfileTableViewController{
                profileTable.delegateTable = self
            }
        }else if segue.identifier == "userInfo"{
            if let userInfoVC = segue.destination as? UserInfoViewController{
                userInfoVC.currentUser = currentUser
                userInfoVC.userInfoDelegate = self
            }
        }
    }
}
