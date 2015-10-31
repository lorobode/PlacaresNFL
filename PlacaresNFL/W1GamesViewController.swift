//
//  W1GamesViewController.swift
//  PlacaresNFL
//
//  Created by Nichollas Fonseca on 31/10/15.
//  Copyright © 2015 Nichollas Fonseca. All rights reserved.
//

import UIKit

class W1GamesViewController: UIViewController, NSXMLParserDelegate, UITableViewDataSource, UITableViewDelegate {
    
    var games = [String]()
    var teams = [Any]()
    var parser = NSXMLParser()
    @IBOutlet var gamesTV: UITableView!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        parser = NSXMLParser(contentsOfURL: NSURL(string: "http://football.myfantasyleague.com/2015/export?TYPE=nflSchedule&W=1")!)!
        parser.delegate = self
        parser.parse()
    }

    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        
        if elementName == "matchup"{
            let matchup = attributeDict["kickoff"]
            games.append(matchup!)
            
        }
        if elementName == "team" {
            var team = ""
            var score = ""
            for (att, value) in attributeDict{
                if att == "id" {
                    team = value
                }
                if att == "score" {
                    score = value
                }
                if team != "" && score != "" {
                    teams.append([team, score])
                    return
                }
            }
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "matchup"{
            self.gamesTV.reloadData()
        }
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MatchCell", forIndexPath: indexPath) as! MatchTableViewCell
        cell.team1.text = (teams[indexPath.row*2] as! [String])[0]
        cell.score1.text = (teams[indexPath.row*2] as! [String])[1]
        cell.team2.text = (teams[indexPath.row*2 + 1] as! [String])[0]
        cell.score2.text = (teams[indexPath.row*2 + 1] as! [String])[1]
        
        // Configure the cell...

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
