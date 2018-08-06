//
//  ProfileViewController.swift
//  FitSupport
//
//  Created by Daulet on 06.08.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, DelegateProfileTable, UserInfoDelegate {
    func update(cuurent user: User) {
        currentUser = user
    }
    
    func performSegue(with identifier: String) {
        performSegue(withIdentifier: identifier, sender: nil)
    }
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var weight: UILabel!
    
    var currentUser: User?{
        didSet{
            setUserInformation()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCustomUser()
    }
    func setUserInformation(){
        guard let currentUser = currentUser else {
            return
        }
        avatar.image = currentUser.Image
        name.text = currentUser.Name
        age.text = "\(currentUser.Age ?? 0) лет"
        weight.text = "\(Int(currentUser.currentWeight ?? 0)) кг"
    }
    func setCustomUser(){
        var user = User(name: "Daulet", avatar: #imageLiteral(resourceName: "user_24px"), weight: 72, height: 178, birthday: Date.init())
        user.add(workout: customWorkout())
        currentUser = user
    }
    
    func customWorkout() -> Workout{
        let day1 = Day(name: "Arm day", count: 2, exercises: [
            Exercise(name: "QAZAQ PRESS", description: "asdf", image: #imageLiteral(resourceName: "arm_200px"), muscleType: [.arm], trainingSession: TrainingSession(reps: 4, times: 4)),
            Exercise(name: "DAUKA's JIM", description: "asdf", image: #imageLiteral(resourceName: "arm_200px"), muscleType: [.arm], trainingSession: TrainingSession(reps: 4, times: 4))
            ])
        let exe = Exercise(name: "ASDF", description: "asdf", image: UIImage.gif(name: "vertikalnaya_tyaga"), muscleType: [.arm], trainingSession: TrainingSession(reps: 4, times: 4))
        //        exe.exerciseState = .done
        let day2 = Day(name: "Arm day", count: 2, exercises: [
            Exercise(name: "JIM", description: "asdf", image: #imageLiteral(resourceName: "arm_200px"), muscleType: [.arm], trainingSession: TrainingSession(reps: 4, times: 4)),
            Exercise(name: "DAUKA's JIM", description: "asdf", image: #imageLiteral(resourceName: "arm_200px"), muscleType: [.arm], trainingSession: TrainingSession(reps: 4, times: 4))
            ])
        let day3 = Day(name: "Arm day", count: 2, exercises: [
            exe,exe,exe,exe,exe,exe,
            ])
        return Workout(name: "BestWorkOut", and: [day1, day3, day2])
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
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
