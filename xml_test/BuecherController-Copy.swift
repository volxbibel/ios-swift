//
//  BuecherController2.swift
//  xml_test
//
//  Created by Simon Brüchner on 07.10.17.
//  Copyright © 2017 Brüchner IT Consulting. All rights reserved.
//

import UIKit
import SWXMLHash

class BuecherController2: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Table
    private var kapitelliste = [String]() // ["First","Second","Third", "vier"]
    private var myTableView: UITableView!
    
    // Tapevent: Wenn ein Zeile ausgewählt wird ...
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(kapitelliste[indexPath.row])")
        
        // let loginPageView =  self.storyboard?.instantiateBuecherController2WithIdentifier("LoginPageID") as! BuecherController2

        let KapitelView: KapitelController? = KapitelController()
        KapitelView?.Buch       = "Matthaeus"
        KapitelView?.Kapitel    = Int(indexPath.row + 1)
        self.present(KapitelView!, animated: true, completion: nil)

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kapitelliste.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        cell.textLabel!.text = "\(kapitelliste[indexPath.row])"
        return cell
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let color = UIColor(red: 0.5, green: 0.0, blue: 0.5, alpha: 1.0)
        let txtField: UITextField = UITextField(frame: CGRect(x: 0, y: 0, width: 500.00, height: 30.00));
        txtField.text = "myString"
        txtField.borderStyle = UITextBorderStyle.line
        txtField.backgroundColor = color
        self.view.addSubview(txtField)
        
        // XML
        let file = "01_Matthaeus" //this is the file. we will write to and read from it
        
        if let audioFilePath = Bundle.main.path(forResource: file, ofType: "xml", inDirectory: "data") {
            print(audioFilePath)
            
            
            
            
            do {
                let text = try String(contentsOfFile:audioFilePath, encoding: String.Encoding.utf8)
                print(text)
            
                let xml = SWXMLHash.config {
                    config in
                    config.shouldProcessLazily = true
                }.parse(text)
                
                
                print(xml)
                
                print(xml["Bibel"]["Buch"]["Titel"].element?.text as Any)
                
                // print(xml["Bibel"]["Buch"]["Abschnitt"].element!.text)
                
//                for elem in xml["Bibel"]["Buch"]["Kapitel"].all {
//                    print(elem["Kapitelziffer"].element!.text)
//                }
                
                for elem in xml["Bibel"]["Buch"]["Kapitel"].all {
                    // print(elem["Kapitelziffer"].element!.text)
                    print("Kapitel "+elem["Kapitelziffer"].element!.text)
                    
                    
                    self.kapitelliste.append("Kapitel "+elem["Kapitelziffer"].element!.text)
                    
                    
                    for elem2 in elem["Abschnitt"].all {
                        print(elem2["Us1"].element?.text as Any)
                        
                        for elem3 in elem2["Grundtext"]["Vers"].all {
                            print(elem3["Versziffer"].element!.text+" "+elem3["Verstext"].element!.text)
                        }
                        
                    }
                }
                
                
                
                func enumerate(indexer: XMLIndexer) {
                    for child in indexer.children {
                        print(child.element!.name)
                        enumerate(indexer: child)
                    }
                }
                
                enumerate(indexer: xml)
                
                
                
                
                // Table
                let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
                let displayWidth: CGFloat = self.view.frame.width
                let displayHeight: CGFloat = self.view.frame.height
                
                myTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
                myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
                myTableView.dataSource = self
                myTableView.delegate = self
                self.view.addSubview(myTableView)
                
            } catch {
                print(error)
            }
        }
        
        

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

