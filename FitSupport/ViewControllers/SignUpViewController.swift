//
//  SignUpViewController.swift
//  FitSupport
//
//  Created by Daulet on 29.07.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import UIKit
import Cartography

protocol SignUpDelegate: AnyObject {
    func enableNextButton()
}

class SignUpViewController: UIViewController {
    @IBOutlet weak var signUpScrollView: UIScrollView!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var customNavTitle: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    private var currentContentOffsetXProperty: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayer()
        signUpScrollView.isScrollEnabled = false
    }
    override func viewDidAppear(_ animated: Bool) {
        let views = [mainView, syncView, personaView, startView]
        setScrollView(views: views)
    }
    
    @IBAction func backButtonClicked(){
        setScrollViewContent(isBackButton: true)
    }
    @IBAction func nextButtonClicked(sender: UIButton){
        setScrollViewContent()
    }
    @IBAction func signInButtonPressed(){
        setScrollViewContentForSignIn()
    }
    
    func setScrollViewContent(isBackButton:Bool = false) {
        let currentVisibleViewIndex = signUpScrollView.contentOffset.x/frameWidth()
        let willAppearViewIndex = currentVisibleViewIndex + (!isBackButton ? 1 : -1)
        let offsetX = willAppearViewIndex * frameWidth()
        
        setLayoutForView(index: willAppearViewIndex)
        
        if offsetX >= 0 && offsetX <= (signUpScrollView.contentSize.width - frameWidth()){
            UIView.animate(withDuration: 0.6) {
                self.signUpScrollView.contentOffset.x = offsetX
                self.nextButton.setTitle((offsetX == 0) || (offsetX == self.frameWidth()*3) ? "НАЧАТЬ" : "ДАЛЕЕ", for: .normal)
                self.customNavTitle.text = "Шаг \(isBackButton ? Int(willAppearViewIndex + 1) : Int(willAppearViewIndex + 1) )"
            }
            currentContentOffsetXProperty = offsetX
        }
        if currentVisibleViewIndex == 3{
            
        }
    }
    
    func setLayoutForView(index: CGFloat){
        switch index {
        case 0:
            backButton.isEnabled = false
            nextButton(isEndabled: true)
            UIView.animate(withDuration: 0.6) {
                self.loginButton.isHidden = false
            }
        case 1:
            UIView.animate(withDuration: 0.6) {
                self.loginButton.isHidden = true
            }
            syncView.isHidden = false
            backButton.isEnabled = true
            nextButton(isEndabled: syncView.allDataIsFilled())
        case 2:
            nextButton(isEndabled: personaView.allDataIsFilled())
        default:
            break
        }
    }
    
    func setScrollViewContentForSignIn() {
        let offsetX = frameWidth()
        backButton.isEnabled = true
        syncView.isHidden = true
        UIView.animate(withDuration: 0.6) {
            self.loginButton.isHidden = true
            self.signUpScrollView.contentOffset.x = offsetX
            self.nextButton.setTitle("ЛОГИН", for: .normal)
            self.customNavTitle.text = "ЛОГИН"
        }
        
        currentContentOffsetXProperty = offsetX
    }
    func nextButton(isEndabled: Bool){
        if isEndabled{
            nextButton.isEnabled = true
            nextButton.backgroundColor = GlobalColors.lightyBlue.color()
        }else{
            nextButton.isEnabled = false
            nextButton.backgroundColor = GlobalColors.disablebColor.color()
        }
    }
    func backButton(isEndabled: Bool){
        if isEndabled{
            nextButton.isEnabled = true
            nextButton.backgroundColor = GlobalColors.lightyBlue.color()
        }else{
            nextButton.isEnabled = false
            nextButton.backgroundColor = GlobalColors.disablebColor.color()
        }
    }
    func frameWidth() -> CGFloat {
        return view.bounds.width
    }
    func frameHeight() -> CGFloat {
        return view.bounds.height
    }
    
    func setLayer(){
        nextButton.layer.cornerRadius = 16
        nextButton.applySketchShadow()
        nextButton.backgroundColor = GlobalColors.lightyBlue.color()
        
        loginButton.layer.cornerRadius = 16
        loginButton.applySketchShadow()
        loginButton.backgroundColor = GlobalColors.lightyBlue.color()
        
        backButton.isEnabled = false
        customNavTitle.textColor = GlobalColors.lightyBlue.color()
    }
    
    func setScrollView(views: [UIView]){
        signUpScrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        signUpScrollView.contentSize = CGSize(width:  frameWidth() * CGFloat(views.count), height: frameHeight())
        for index in 0..<views.count{
            if index == 1{
                signIn.frame = CGRect(x: frameWidth() * CGFloat(index), y: 0, width: frameWidth(), height: frameHeight())
                signUpScrollView.addSubview(signIn)
            }
            views[index].frame = CGRect(x: frameWidth() * CGFloat(index), y: 0, width: frameWidth(), height: frameHeight())
            signUpScrollView.addSubview(views[index])
        }
        
    }
    
    lazy var mainView: SignUpMainView = {
        let mainView = Bundle.main.loadNibNamed("SignUpMainPage", owner: self, options: nil)?[0] as! SignUpMainView
        return mainView
    }()
    lazy var syncView: SignUpSyncView = {
        let syncView = Bundle.main.loadNibNamed("SignUpMainPage", owner: self, options: nil)?[1] as! SignUpSyncView
        syncView.delegateOfSyncView = self
        return syncView
    }()
    lazy var personaView: SignUpPersonalDetails = {
        let personaView = Bundle.main.loadNibNamed("SignUpMainPage", owner: self, options: nil)?[2] as! SignUpPersonalDetails
        personaView.delegatePersonDetails = self
        return personaView
    }()
    lazy var startView: SignUpStartTrainingView = {
        let startView = Bundle.main.loadNibNamed("SignUpMainPage", owner: self, options: nil)?[3] as! SignUpStartTrainingView
        return startView
    }()
    lazy var signIn: SignInView = {
        let signIn = Bundle.main.loadNibNamed("SignUpMainPage", owner: self, options: nil)?[4] as! SignInView
        return signIn
    }()

}
extension SignUpViewController: SignUpDelegate{
    func enableNextButton() {
        nextButton.isEnabled = true
        nextButton.backgroundColor = GlobalColors.lightyBlue.color()
    }
}
