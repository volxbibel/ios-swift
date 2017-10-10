
import UIKit
import SWXMLHash

class VerseController: UIViewController {

    var Buch: String?
    var Kapitel: Int?
    var xmlfile: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title                  = "Kapitel "+String(describing: self.Kapitel!)
        self.view.backgroundColor   = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0)
        
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
            // textView.text.append("a");
            
            
            // Verse ausgeben
            let elem2 = xml["Bibel"]["Buch"]["Kapitel"][self.Kapitel!-1]
            for elem4 in elem2["Abschnitt"].all {
                
                // TODO hier unklar wie die (Zwischen)Überschriften "elem4["Us1"].element!.text" speziell formatiert dargestellt werden können.

//                print(elem4["Us1"].element!.text)
//
//                let existingTextString = textView.text
//                let ueberschrift = elem4["Us1"].element!.text
//                let textString = "\(existingTextString!)\n\(ueberschrift)"
//                let attrText = NSMutableAttributedString(string: textString)
//                let smallFont = UIFont(name: "Arial", size: 18.0)!
//                let smallTextRange = (textString as NSString).range(of: ueberschrift)
//                attrText.addAttribute(NSAttributedStringKey.font, value: smallFont, range: smallTextRange)
//
//                textView.attributedText = attrText

                
                for elem3 in elem4["Grundtext"]["Vers"].all {
                    textView.text.append(elem3["Versziffer"].element!.text+" "+elem3["Verstext"].element!.text+"\n");
                    
//                    let existingTextString = textView.text
//                    let ueberschrift = elem3["Versziffer"].element!.text+" "+elem3["Verstext"].element!.text
//                    let textString = "\(existingTextString!)\n\(ueberschrift)"
//                    let attrText = NSMutableAttributedString(string: textString)
////                    let smallFont = UIFont(name: "Arial", size: 18.0)!
////                    let smallTextRange = (textString as NSString).range(of: ueberschrift)
//                    attrText.addAttribute(NSAttributedStringKey.font, value: smallFont, range: smallTextRange)
//
//                    textView.append( = textString
                }
            }

            // TODO hier fehlen auch noch die Fußnoten in spezieller Formatierung

        } catch {
            print(error)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}




