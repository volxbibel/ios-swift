
import UIKit
import SWXMLHash

class VerseController: UIViewController {

    var Buch:       String? // Ausgewähltes Buch
    var Kapitel:    Int?    // Ausgewähltes Kapitel
    var xmlfile:    String? // Der Pfad zur XML Datei des ausgewählten Buches
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0)
        self.title = "Kapitel "+String(describing: self.Kapitel!)
        
        // XML
        do {
            let text = try String(contentsOfFile:self.xmlfile!, encoding: String.Encoding.utf8)
            let xml = SWXMLHash.config {
                config in
                config.shouldProcessLazily = true
            }.parse(text)
            
            
            let textView = UITextView(frame: CGRect(x: 0, y: 0, width: 250.0, height: 100.0))
            // textView.isSelectable = true
            textView.frame.size.width  = UIScreen.main.bounds.width
            textView.frame.size.height = UIScreen.main.bounds.height
            view.addSubview(textView)
            
            let newMutableString = textView.attributedText.mutableCopy() as! NSMutableAttributedString
            let largeFont = UIFont(name: "Arial", size: 20)!

            // Verse ausgeben
            let elem2 = xml["Bibel"]["Buch"]["Kapitel"][self.Kapitel!-1] // Hier wird genau der Kapitel-Node im XML ausgewählt!
            for elem4 in elem2["Abschnitt"].all {

                let us1 = NSAttributedString(string: elem4["Us1"].element!.text, attributes: [
                    NSAttributedStringKey.foregroundColor: UIColor.red,
                    NSAttributedStringKey.font: largeFont
                    // NSAttributedStringKey.paragraphStyle: UIFontTextStyle.headline
                    ])
                newMutableString.append(us1)

                for elem3 in elem4["Grundtext"]["Vers"].all {
                    let attrString1 = NSAttributedString(string: elem3["Versziffer"].element!.text+" "+elem3["Verstext"].element!.text+"\n")
                    newMutableString.append(attrString1)
                }
            }

            // TODO hier fehlen auch noch die Fußnoten in spezieller Formatierung
            
            textView.attributedText = newMutableString.copy() as! NSAttributedString
            
        } catch {
            print(error)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}




