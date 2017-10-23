
import UIKit
import SWXMLHash

class KapitelController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var Buch:                   String?     // Ausgewähltes Buch
    private var kapitelliste =  [String]()  // Liste aller Kapitel
    var xmlfile:                String?     // Der Pfad zur XML Datei des ausgewählten Buches
    private var tableView:    UITableView!
    
    // Tapevent: Wenn ein Zeile ausgewählt wird ...
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let VerseView: VerseController? = VerseController()
        VerseView?.Buch       = kapitelliste[indexPath.row]
        VerseView?.Kapitel    = Int(indexPath.row + 1)
        VerseView?.xmlfile    = xmlfile
        
        self.navigationController?.pushViewController(VerseView!, animated: true)
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
        self.view.backgroundColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0)
        self.title = self.Buch ?? ""
        
        // XML
        do {
            let text = try String(contentsOfFile:self.xmlfile!, encoding: String.Encoding.utf8)
            let xml = SWXMLHash.config {
                config in
                config.shouldProcessLazily = true
            }.parse(text)
            
            for elem in xml["Bibel"]["Buch"]["Kapitel"].all {
                self.kapitelliste.append("Kapitel "+elem["Kapitelziffer"].element!.text)
            }
            
        } catch {
            print(error)
        }
        
        
        // Table view initialisieren
        // let barHeight:      CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth:   CGFloat = self.view.frame.width
        let displayHeight:  CGFloat = self.view.frame.height
        
        // Statt "44" self.navigationController.navigationBar.frame.size.height
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: displayWidth, height: displayHeight))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}




