
import UIKit
import SWXMLHash

class BuecherController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var xmlliste =      [String]()  // Liste der XML Dateien
    private var buecherliste =  [String]()  // Liste der Büchernamen
    private var tableView:      UITableView!
    
    // Tapevent: Wenn ein Zeile ausgewählt wird ...
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let KapitelView: KapitelController? = KapitelController()
        KapitelView?.Buch       = buecherliste[indexPath.row]
        KapitelView?.xmlfile    = xmlliste[indexPath.row]
        
        // Rufe anderen Controller auf dem navigationController von AppDelegate auf
        self.navigationController?.pushViewController(KapitelView!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buecherliste.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        cell.textLabel!.text = "\(buecherliste[indexPath.row])"
        return cell
    }
       
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO unklar wie man dies für alle Controller global setzt. 
        self.view.backgroundColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0)
        
        
        // Alle XMLs in ein Array schreiben
        let dummy   = Bundle.main.path(forResource: "01_Matthaeus", ofType: "xml", inDirectory: "data") // Workaround um harten Pfad zu "data" Folder zu bekommen.
        let url     = URL(fileURLWithPath: dummy!)
        let dirUrl  = url.deletingLastPathComponent()
        let en      = FileManager().enumerator(atPath: dirUrl.path)
        while let element = en?.nextObject() as? String {
            if element.hasSuffix("xml") {
                self.xmlliste.append(dirUrl.path+"/"+element)
                break
            }
        }
        
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
        print(self.buecherliste)
        
        
        let textView = UITextView(frame: CGRect(x: 20.0, y: 90.0, width: 250.0, height: 300))
        
        textView.center = self.view.center
        textView.textAlignment = NSTextAlignment.justified
        textView.textColor = UIColor.black
        textView.backgroundColor = UIColor.white
        textView.text = "vb"
        
        
//        // 1. base our script font on the preferred body font size
//        let bodyFontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: UIFontTextStyle.body)
//        let bodyFontSize = bodyFontDescriptor.fontAttributes[UIFontDescriptor.AttributeName.size] as! NSNumber
//        let scriptFont = UIFont(descriptor: scriptFontDescriptor, size: CGFloat(bodyFontSize.floatValue))
//
//        // 2. create the attributes
//        let boldAttributes = createAttributesForFontStyle(style: UIFontTextStyle.body.rawValue, withTrait:.traitBold)
//        let italicAttributes = createAttributesForFontStyle(style: UIFontTextStyle.body.rawValue, withTrait:.traitItalic)
//        let scriptAttributes = [NSAttributedStringKey.font : scriptFont]
//        let redTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.red]
        
        
        
        
        
        let largeFont = UIFont(name: "Arial-BoldMT", size: 20)!
        let smallFont = UIFont(name: "Arial", size: 15)!
        
        let string1 = NSAttributedString(string: "loading", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red, NSAttributedStringKey.font: largeFont])
        let string2 = NSAttributedString(string: "success", attributes: [NSAttributedStringKey.foregroundColor: UIColor.green])
        
        
        
        let newMutableString = textView.attributedText.mutableCopy() as! NSMutableAttributedString
        newMutableString.append(string2)
        newMutableString.append(string1)
        textView.attributedText = newMutableString.copy() as! NSAttributedString
       
        
        
        // Table view initialisieren
        let barHeight:      CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth:   CGFloat = self.view.frame.width
        let displayHeight:  CGFloat = self.view.frame.height
        
        // Statt "44" self.navigationController.navigationBar.frame.size.height
        tableView = UITableView(frame: CGRect(x: 0, y: barHeight + 44, width: displayWidth, height: displayHeight - barHeight))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
//         self.view.addSubview(textView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}




