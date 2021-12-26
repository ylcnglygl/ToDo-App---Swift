//
//  ViewController.swift
//  ToDoList
//
//  Created by Yalçın Golayoğlu on 26.12.2021.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    @IBOutlet var tableView: UITableView!
    var jobList = [String]()
    var idList = [UUID]()
    var selectedToDo = ""
    var selectedToDoId : UUID?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        getData()
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name("newData"), object: nil)
    }
    
    //TABLE VIEW FUNCTIONS
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = jobList[indexPath.row]
        return cell
    }
    
    //TRANSFER DATA FROM VC TO DETAIL VC
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedToDo = jobList[indexPath.row]
        selectedToDoId = idList[indexPath.row]
        performSegue(withIdentifier: "toDetailViewController", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailViewController"{
            let destinationVC = segue.destination as? DetailViewController
            destinationVC?.jobId = selectedToDoId
        }
    }
    
    //BUTTON FUNCTION
    
    
    @objc func addButtonClicked(){
        performSegue(withIdentifier: "toAddViewController", sender: nil)
    }
    
    //GET TODOS FUNCTION
    
    @objc func getData(){
        jobList.removeAll()
        idList.removeAll()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Todos")
        fetchRequest.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(fetchRequest)
            if results.count > 0{
                for result in results as! [NSManagedObject]{
                    if let job = result.value(forKey: "job") as? String{
                        self.jobList.append(job)
                    }
                    if let id = result.value(forKey: "id") as? UUID{
                        self.idList.append(id)
                    }
                    self.tableView.reloadData()
                }
                
            }
        }catch{
            print("error")
        }
    }
    


}

