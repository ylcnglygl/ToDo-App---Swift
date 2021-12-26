//
//  DetailViewController.swift
//  ToDoList
//
//  Created by Yalçın Golayoğlu on 26.12.2021.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {
    @IBOutlet var jobName: UILabel!
    @IBOutlet var jobDetail: UILabel!
    var jobId : UUID?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getToDoDetail()
    }
    
   
    //GET DETAILS OF CHOSEN TODO
    
    func getToDoDetail(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Todos")
        let idString = jobId?.uuidString
        fetchRequest.predicate = NSPredicate(format: "id = %@", idString!)
        fetchRequest.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(fetchRequest)
            if results.count > 0{
                for result in results as! [NSManagedObject]{
                    if let jobName = result.value(forKey: "job") as? String{
                        self.jobName.text = jobName
                    }
                    if let jobDetail = result.value(forKey: "jobDetail") as? String{
                        self.jobDetail.text = jobDetail
                    }
                }
            }
        }catch{
            print("error")
        }
    }
  

}
