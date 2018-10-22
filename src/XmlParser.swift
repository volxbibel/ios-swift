//
//  XmlParser.swift
//  xml_test
//
//  Created by Simon Brüchner on 12.10.17.
//  Copyright © 2017 Brüchner IT Consulting. All rights reserved.
//

import Foundation
import SWXMLHash

class XMLParser {
    
    var xmlliste =      [String]()  // Liste der XML Dateien
    var buecherliste =  [String]()  // Liste der Büchernamen
    var stuff:[(Buch: String, Kapitel: [(Int)])] = []
    
    func getXMLliste() -> [String]  {
        print(xmlliste.count)
        if (xmlliste.count == 0) {
            
            // Alle XMLs in ein Array schreiben
            let dummy   = Bundle.main.path(forResource: "01_Matthaeus", ofType: "xml", inDirectory: "data") // Workaround um harten Pfad zu "data" Folder zu bekommen.
            let url     = URL(fileURLWithPath: dummy!)
            let dirUrl  = url.deletingLastPathComponent()
            let en      = FileManager().enumerator(atPath: dirUrl.path)
            while let element = en?.nextObject() as? String {
                if element.hasSuffix("xml") {
                    self.xmlliste.append(dirUrl.path+"/"+element)
                }
            }
        }
        return self.xmlliste
    }
    
    func getBuecherliste() -> [String] {
        if (buecherliste.count == 0) {
            
            self.getXMLliste()
            
            // Büchernamen aus XML holen
            for element in self.xmlliste {
                do {
                    let text = try String(contentsOfFile:element, encoding: String.Encoding.utf8)
                    let xml = SWXMLHash.config {
                        config in
                        config.shouldProcessLazily = true
                        }.parse(text)
                    self.buecherliste.append((xml["Bibel"]["Buch"]["Titel"].element?.text)!)
                    break
                } catch {
                    print(error)
                }
            }
        }
        return self.buecherliste
    }
    
    func getKapitelliste(Buchname: String) -> [String] {
        
//        do {
//            let text = try String(contentsOfFile:self.xmlfile!, encoding: String.Encoding.utf8)
//            let xml = SWXMLHash.config {
//                config in
//                config.shouldProcessLazily = true
//                }.parse(text)
//
//            for elem in xml["Bibel"]["Buch"]["Kapitel"].all {
//                self.kapitelliste.append("Kapitel "+elem["Kapitelziffer"].element!.text)
//            }
//            
//        } catch {
//            print(error)
//        }
        
        
        
        return self.buecherliste
    }
}



