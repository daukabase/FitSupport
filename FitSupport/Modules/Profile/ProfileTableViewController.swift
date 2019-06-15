//
//  ProfileTableViewController.swift
//  FitSupport
//
//  Created by Daulet on 06.08.2018.
//  Copyright © 2018 Daulet. All rights reserved.
//

import UIKit
import MessageUI

protocol DelegateProfileTable: AnyObject {
    func performSegue(with identifier: String)
}

class ProfileTableViewController: UITableViewController, UIDocumentInteractionControllerDelegate {
    
    
    var documentController: UIDocumentInteractionController!
    var yourImage = #imageLiteral(resourceName: "applogo")
    var image = #imageLiteral(resourceName: "applogo")
    
    weak var delegate: DelegateProfileTable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
            case 0:
                delegate?.performSegue(with: "userInfo")
            case 2:
                shareInstagram()
            default:
                break
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func shareInstagram() {
        DispatchQueue.main.async {
            
            let instagramURL = URL(string: "instagram://app")
            if UIApplication.shared.canOpenURL(instagramURL!) {
                
                let imageData = UIImageJPEGRepresentation(self.image, 100)
                let writePath = (NSTemporaryDirectory() as NSString).appendingPathComponent("instagram.igo")
                
                do {
                    try imageData?.write(to: URL(fileURLWithPath: writePath), options: .atomic)
                } catch {}
                
                let fileURL = URL(fileURLWithPath: writePath)
                self.documentController = UIDocumentInteractionController(url: fileURL)
                self.documentController.delegate = self
                self.documentController.uti = "com.instagram.exlusivegram"
                
                if UIDevice.current.userInterfaceIdiom == .phone {
                    self.documentController.presentOpenInMenu(from: self.view.bounds, in: self.view, animated: true)
                }
            } else {
                print(" Instagram is not installed ")
            }
        }
    }
    
    
    func shareInfoAboutApplication() {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let activityVC = UIActivityViewController(activityItems: [""], applicationActivities: nil)

        self.present(activityVC, animated: true, completion: nil)
    }
    
    func shareToInstagram() {
        let instagramURL = URL(string: "instagram://app")
        if UIApplication.shared.canOpenURL(instagramURL!) {

            let imageData = UIImageJPEGRepresentation(yourImage, 100)
            let writePath = (NSTemporaryDirectory() as NSString).appendingPathComponent("instagram.igo")

            do {
                try imageData?.write(to: URL(fileURLWithPath: writePath), options: .atomic)
            } catch {
                print(error)
            }

            let fileURL = URL(fileURLWithPath: writePath)
            self.documentController = UIDocumentInteractionController(url: fileURL)
            self.documentController.delegate = self
            self.documentController.uti = "com.instagram.exlusivegram"

            if UIDevice.current.userInterfaceIdiom == .phone {
                self.documentController.presentOpenInMenu(from: self.view.bounds, in: self.view, animated: true)
            }
        } else {
            print("ERROR: Instagram is not installed ")
        }
    }
    
    func showSendMessageAlert() {
        let alert = UIAlertController(title: "Связь с FitSupport", message: "Напишите ваши отзывы или рекомендации для дальнейшего развития приложения", preferredStyle: .alert)
        alert.addTextField { (textFieldOfMessage) in
            textFieldOfMessage.placeholder = ""
        }
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Отправить", style: .default, handler: { [weak alert] (_) in
            let message = alert?.textFields![0].text
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["daukabase@gmail.com"])
            if let message = message{
                mail.setMessageBody("<p> \(message) </p>", isHTML: true)
                self.present(mail, animated: true)
            }
        }))
    }
    
}
extension ProfileTableViewController: MFMailComposeViewControllerDelegate {
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            showSendMessageAlert()
        } else {
            showAlert(with: .simple, title: "Ошибка", message: "Вы не настроили ваш девайс на отправку сообщений", onPress: nil)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
