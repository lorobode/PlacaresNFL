//
//  W1GamesViewController.swift
//  PlacaresNFL
//
//  Created by Nichollas Fonseca on 31/10/15.
//  Copyright © 2015 Nichollas Fonseca. All rights reserved.
//

import UIKit

class W1GamesViewController: UIViewController, NSXMLParserDelegate, UITableViewDataSource, UITableViewDelegate {
    
    var week:Int = 1
    var games = [Any]()
    var teams = [Any]()
    var parser = NSXMLParser()
    var hasRefreshControl = false
    var refreshControl:UIRefreshControl!
    @IBOutlet var gamesTV: UITableView!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.gamesTV.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0);
        self.title = "Semana \(week)"
    }
    
    override func viewDidAppear(animated: Bool) {
        loadData()
    }

    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        
        if elementName == "matchup"{
            let matchup = attributeDict["kickoff"]
            let date = NSDate(timeIntervalSince1970: Double(matchup!)!)
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "E dd/MM hh:mm" //format style. Browse online to get a format that fits your needs.
            let dateString = dateFormatter.stringFromDate(date)
            let time = attributeDict["gameSecondsRemaining"]
            
            if Int(time!) == 0{
                games.append([dateString, "0"])
            } else {
                //It means that this week has at least one game running or to start. So we want to add pull to refresh
                addRefreshControl()
                if Int(time!) > 0 {
                    games.append([dateString, "1"])
                } else if Int(time!) == 3600 {
                    games.append([dateString, "2"])
                }
            }        }
        if elementName == "team" {
            var team = ""
            var score = ""
            for (att, value) in attributeDict{
                if att == "id" {
                    team = value
                    teams.append([team, score])
                }
                if att == "score" {
                    score = value
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
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.backgroundColor = UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0);
        
        cell.logo1.image = UIImage(named: (teams[indexPath.row*2] as! [String])[0])
        cell.team1.text = (teams[indexPath.row*2] as! [String])[0]
        cell.score1.text = (teams[indexPath.row*2] as! [String])[1]
        cell.score1.font = UIFont.systemFontOfSize(13.0)
        cell.score1.textColor = UIColor.whiteColor()
        
        cell.logo2.image = UIImage(named: (teams[indexPath.row*2 + 1] as! [String])[0])
        cell.team2.text = (teams[indexPath.row*2 + 1] as! [String])[0]
        cell.score2.text = (teams[indexPath.row*2 + 1] as! [String])[1]
        cell.score2.font = UIFont.systemFontOfSize(13.0)
        cell.score2.textColor = UIColor.whiteColor()
        
        let gameStatus = (games[indexPath.row] as! [String])
        cell.gameTime.text = gameStatus[0]
        
        if gameStatus[1] == "0" {
            if Int(cell.score1.text!) > Int(cell.score2.text!) {
                cell.score1.font = UIFont.boldSystemFontOfSize(18.0)
                cell.score1.textColor = UIColor.whiteColor()
                cell.score2.textColor = UIColor.grayColor()
            } else {
                cell.score2.font = UIFont.boldSystemFontOfSize(18.0)
                cell.score2.textColor = UIColor.whiteColor()
                cell.score1.textColor = UIColor.grayColor()
            }
            cell.gameTime.text = gameStatus[0].characters.split{$0 == " "}.map(String.init)[1]
        } else if gameStatus[1] == "1" {
        } else if gameStatus[1] == "2"{
        }

        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 90
    }
    
    func loadData(){
        games = []
        teams = []
        parser = NSXMLParser(contentsOfURL: NSURL(string: "http://football.myfantasyleague.com/2015/export?TYPE=nflSchedule&W=\(week)")!)!
        parser.delegate = self
        parser.parse()
    }
    
    func addRefreshControl(){
        if(!hasRefreshControl){
            self.refreshControl = UIRefreshControl()
            self.refreshControl.attributedTitle = NSAttributedString(string: "Puxe para recarregar", attributes: [NSForegroundColorAttributeName: UIColor.whiteColor()])
            self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
            self.gamesTV.addSubview(refreshControl)
            hasRefreshControl = true
        }
    }
    
    func refresh(sender:AnyObject)
    {
        loadData()
        self.refreshControl.endRefreshing()
    }
}
