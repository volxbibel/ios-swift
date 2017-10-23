
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
            textView.isEditable = false
            view.addSubview(textView)
            
            
            let textViewText    = textView.attributedText.mutableCopy() as! NSMutableAttributedString
            let us1Font         = UIFont.preferredFont(forTextStyle: .title1) // UIFont(name: "Arial", size: 20)!
            let versFont        = UIFont.preferredFont(forTextStyle: .body)
            let fussnoteFont    = UIFont.preferredFont(forTextStyle: .footnote)

            var fussnoteParagraphStyle: NSMutableParagraphStyle = {
                let style = NSMutableParagraphStyle()
                style.lineSpacing = 3.5
                style.paragraphSpacingBefore = 0
                style.paragraphSpacing = 10.5
                return style
            }()

            var us1ParagraphStyle: NSMutableParagraphStyle = {
                let style = NSMutableParagraphStyle()
                style.lineSpacing = 1
                style.paragraphSpacingBefore = 33
                style.paragraphSpacing = 5
                return style
            }()
            
            // Verse ausgeben
            let elem2 = xml["Bibel"]["Buch"]["Kapitel"][self.Kapitel!-1] // Hier wird genau der Kapitel-Node im XML ausgewählt!
            for elem4 in elem2["Abschnitt"].all {

                let us1 = NSAttributedString(string: elem4["Us1"].element!.text+"\n", attributes: [NSAttributedStringKey.font: us1Font, NSAttributedStringKey.paragraphStyle: us1ParagraphStyle])
                textViewText.append(us1)

                for elem3 in elem4["Grundtext"]["Vers"].all {
                    let vers = NSAttributedString(string: elem3["Versziffer"].element!.text+" "+elem3["Verstext"].element!.text+"\n", attributes:[NSAttributedStringKey.font: versFont])
                    textViewText.append(vers)
                }
                
                for elem3 in elem4["Fussnote"].all {
                    let fussnote = NSAttributedString(string: "\n"+elem3["Fussnotenummer"].element!.text+" "+elem3["Fussnotetext"].element!.text, attributes:[NSAttributedStringKey.font: fussnoteFont, NSAttributedStringKey.paragraphStyle: fussnoteParagraphStyle])
                    textViewText.append(fussnote)
                    print(elem3["Fussnotetext"].element!.text)
                }
            }
            
            
            func enumerate(indexer: XMLIndexer) {
                for child in indexer.children {
                    print(child.element!.name)
                    enumerate(indexer: child)
                }
            }
            enumerate(indexer: xml["Bibel"]["Buch"]["Kapitel"][self.Kapitel!-1])
            
            
            // TODO hier fehlen auch noch die Fußnoten in spezieller Formatierung
            
            textView.attributedText = textViewText.copy() as! NSAttributedString
            
        } catch {
            print(error)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}




