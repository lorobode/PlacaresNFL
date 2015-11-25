//
//  FirstViewController.swift
//  PlacaresNFL
//
//  Created by Nichollas Fonseca on 01/11/15.
//  Copyright © 2015 Nichollas Fonseca. All rights reserved.
//

import UIKit
import CoreData

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var weekTableView: UITableView!
    var weeks = ["Semana 1", "Semana 2", "Semana 3", "Semana 4", "Semana 5", "Semana 6", "Semana 7", "Semana 8", "Semana 9", "Semana 10", "Semana 11", "Semana 12", "Semana 13", "Semana 14", "Semana 15", "Semana 16", "Semana 17"]
    var selectedWeek = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.weekTableView.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0);
        self.title = "PlacaresNFL - 2015"
        
        
        saveGame()
        
        // Do any additional setup after loading the view.
    }
    
    func saveGame()
    {
        let appDelegate    = UIApplication.sharedApplication().delegate as? AppDelegate
        let managedContext = appDelegate!.managedObjectContext
        let game = NSEntityDescription.insertNewObjectForEntityForName("Games", inManagedObjectContext: managedContext) as! Games
        
        game.year = "2015"
        game.home_team = "NYJ"
        game.visitor_team = "BUF"
        game.home_score = "3"
        game.visitor_score = "0"
        
        do
        {
            try managedContext.save()
        }
        catch
        {
            print("There is some error.")
        }
    }
    
    func fetchAllPeople()
    {
        let appDelegate    = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest   = NSFetchRequest(entityName: "Games")
        
        do
        {
            let fetchedResult = try managedContext.executeFetchRequest(fetchRequest) as? [Games]
            
            if let results = fetchedResult
            {
                let alert = UIAlertController(title: "Alert", message: results.first?.home_team, preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
            else
            {
                print("Could not fetch result")
            }
        }
        catch
        {
            print("There is some error.")
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weeks.count
    }
    
    func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        let cell  = tableView.cellForRowAtIndexPath(indexPath)
        cell!.backgroundColor = .grayColor()
    }
    
    func tableView(tableView: UITableView, didUnhighlightRowAtIndexPath indexPath: NSIndexPath) {
        let cell  = tableView.cellForRowAtIndexPath(indexPath)
        cell!.backgroundColor = .clearColor()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier( "Cell", forIndexPath: indexPath)
        cell.selectionStyle = .None
        cell.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0);
        cell.textLabel?.text = weeks[indexPath.row]
        cell.textLabel?.textAlignment = NSTextAlignment.Center
        cell.textLabel?.textColor = UIColor.whiteColor()
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedWeek = indexPath.row + 1
        self.performSegueWithIdentifier("ShowWeek", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowWeek"{
            if let destinationVC = segue.destinationViewController as? W1GamesViewController{
                destinationVC.week = selectedWeek
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
