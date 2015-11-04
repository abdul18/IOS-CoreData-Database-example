//
//  ViewController.swift
//  exampleCoreData
//
//  Created by Yosemite on 03/11/15.
//  Copyright (c) 2015 Pavaratha. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    

    @IBOutlet weak var txtUserName: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    var contextObject: NSManagedObjectContext!
    var newUser: NSManagedObject!
    var request: NSFetchRequest!
    var results: NSArray!
    var res: NSManagedObject!
    
    @IBAction func Save(sender: AnyObject) {
        
//        print("\(txtUserName.text)")
        let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        contextObject = appDel.managedObjectContext
        newUser = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: contextObject)
        newUser.setValue(txtUserName.text, forKey: "username")
        newUser.setValue(txtPassword.text, forKey: "password")
        try! contextObject.save()
        print(newUser)
    }
    
    
    @IBAction func Load(sender: AnyObject) {
        print("\(txtPassword.text)")
        let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        contextObject = appDel.managedObjectContext
        request = NSFetchRequest(entityName: "Users")
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "username ==%@", txtUserName.text!)
        results = try! contextObject.executeFetchRequest(request)
        if results.count > 0 {
            
            res = results[0] as! NSManagedObject
            txtUserName.text = res.valueForKey("username") as? String
            txtPassword.text = res.valueForKey("password") as? String
        } else {
            print("No Found")
        }
    }
    
    @IBAction func Clear(sender: AnyObject){
        txtUserName.text = ""
        txtPassword.text = ""
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

