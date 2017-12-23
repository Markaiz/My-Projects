//
//  VictimViewController.swift
//  HitListAryaCoreData
//
//  Created by Mark on 04/09/2017.
//  Copyright © 2017 MarkAiz. All rights reserved.
//

import UIKit
import CoreData

class VictimViewController: UIViewController {

    var object : Victim?
    
    var didUpdatePicture : Bool = false
    

    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBAction func addWishButton(_ sender: Any) {
        
        
        // create new Victim if object is nil in relevant database
        //if object is not nil Update Victim
        let v = object ?? Victim(context: DBManager.manager.persistentContainer.viewContext)
        
        v.firstName = firstName.text  // Data String "firstname" = text field "firstname".text
        v.lastName = lastName.text
        v.date = NSDate()
        v.isAlive = true
        
        if didUpdatePicture{
        v.image = pictureImageView.image
        }
        //save victim
        DBManager.manager.saveContext()
        
        
        //back to tableview controller
        self.navigationController?.popViewController(animated: true)
        
        
    }
   
    @IBAction func longAction(_ sender: UILongPressGestureRecognizer) {
        guard sender.state == .ended else {return}
        
        pictureImageView.image = nil
        didUpdatePicture = true
    }
    
    @IBAction func tapImageAction(_ sender: Any) {
        
        //close keyboard
        firstName.resignFirstResponder()
        lastName.resignFirstResponder()
        
        
        
        
    }
    
    @IBOutlet weak var pictureImageView: UIImageView!
    
    
    
    
    func takePictureAction(){
    let picker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera){picker.sourceType = .camera}
        else {picker.sourceType = .photoLibrary}
        
        picker.delegate = self
        
        self.present(picker,animated: true,completion: nil)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //open keyboard
      firstName.becomeFirstResponder()
        
        
        //create camera button
        let cameraButton = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(takePictureAction))
        navigationItem.rightBarButtonItem = cameraButton
        
        
        if let object = object {
            firstName.text = object.firstName
            lastName.text = object.lastName
            pictureImageView.image = object.image
            
            submitButton.setTitle(("Update wish list "), for: .normal)
            //setup title
            navigationItem.title = "Update"
        
        } else {
        
        //setup title
        navigationItem.title = "Create"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension VictimViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
       let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        pictureImageView.image = image
        self.didUpdatePicture = true
        picker.dismiss(animated: true, completion: nil)
    }
    

}


