//
//  ViewController.swift
//  PlacaresNFL
//
//  Created by Nichollas Fonseca on 22/10/15.
//  Copyright © 2015 Nichollas Fonseca. All rights reserved.
//

import UIKit

class ViewController: UIViewController, NSXMLParserDelegate {
    
    var games = [String]()
    var team = [String:String]()
    var parser = NSXMLParser()

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
            for (att, value) in attributeDict{
                //print("\(att): \(value)")
            }
        }
        print(games.last)
    }


}

