//
//  AppStartLoadingViewController.swift
//  FitSupport
//
//  Created by Daulet on 07.08.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import UIKit

class AppStartLoadingViewController: UIViewController {
    
    var currentUser: User?
    
    override func viewWillAppear(_ animated: Bool) {
        if currentUser == nil{
            performSegue(withIdentifier: "signUp", sender: nil)
        }else{
            performSegue(withIdentifier: "tabbar", sender: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
