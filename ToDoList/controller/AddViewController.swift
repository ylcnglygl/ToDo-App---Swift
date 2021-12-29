//
//  AddViewController.swift
//  ToDoList
//
//  Created by Yalçın Golayoğlu on 26.12.2021.
//

import UIKit
import CoreData

class AddViewController: UIViewController, UINavigationControllerDelegate {
    @IBOutlet var jobTextField: UITextField!
    @IBOutlet var jobDetailTextField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    var strDate : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    //ADD DATE TIME PICKER
    
    @IBAction func dateTimeChange(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        self.strDate = dateFormatter.string(from: self.datePicker.date)
        if self.strDate == ""{
            self.strDate = dateFormatter.string(from: Date())
            print(self.strDate)
        }
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        print("savebuton")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newTodo = NSEntityDescription.insertNewObject(forEntityName: "Todos", into: context)
        
        newTodo.setValue(jobTextField.text!, forKey: "job")
        newTodo.setValue(jobDetailTextField.text!, forKey: "jobDetail")
        newTodo.setValue(self.strDate, forKey: "date")
        newTodo.setValue(UUID(), forKey: "id")
        
        do{
            try context.save()
            print("success")
        }catch {
            print("error")
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
        self.navigationController?.popViewController(animated: true)
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        
    }
    
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
}
