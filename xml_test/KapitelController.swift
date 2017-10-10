
import UIKit
import SWXMLHash

class KapitelController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var Buch: String?
    var Kapitel: Int? // Sollte nach Inhaltscontroller verschoben werden.
    private var kapitelliste = [String]()
    var xmlfile: String?
    
    private var myTableView: UITableView!
    
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
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        // Statt "44" self.navigationController.navigationBar.frame.size.height
        myTableView = UITableView(frame: CGRect(x: 0, y: barHeight + 44, width: displayWidth, height: displayHeight - barHeight))
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView.dataSource = self
        myTableView.delegate = self
        self.view.addSubview(myTableView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}




