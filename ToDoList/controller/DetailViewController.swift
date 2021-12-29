//
//  DetailViewController.swift
//  ToDoList
//
//  Created by Yalçın Golayoğlu on 26.12.2021.
//

import UIKit
import CoreData
import SwiftUI

class DetailViewController: UIViewController {
    @IBOutlet var jobName: UILabel!
    @IBOutlet var jobDetail: UILabel!
    var jobId : UUID?
    @IBOutlet var dateTimeLabel: UILabel!
    
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
                    if let date = result.value(forKey: "date") as? String{
                        self.dateTimeLabel.text = date
                    }
                    
                }
            }
        }catch{
            print("error")
        }
    }
  

}

struct DetailViewController_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
