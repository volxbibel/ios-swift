
import UIKit
import SWXMLHash

class BuecherController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Table
    private var xmlliste = [String]()
    private var buecherliste = [String]()
    
    private var tableView: UITableView!
    
    // Tapevent: Wenn ein Zeile ausgewählt wird ...
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let KapitelView: KapitelController? = KapitelController()
        KapitelView?.Buch       = buecherliste[indexPath.row]
        KapitelView?.Kapitel    = Int(indexPath.row + 1)
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
        
        // TODO unklar wie man dies in allen Controllern gleich setzt. 
        self.view.backgroundColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0)
        
        
        
//        let screenSize: CGRect = UIScreen.main.bounds
//        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x:0, y:20, width: screenSize.width, height:screenSize.height * 0.09))
//        let navItem = UINavigationItem(title: "Volxbibel");
//        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: nil, action: "selector");
//        navItem.rightBarButtonItem = doneItem;
//        navBar.setItems([navItem], animated: false);

        
        
        // Alle XMLs in ein Array schreiben
        let dummy   = Bundle.main.path(forResource: "01_Matthaeus", ofType: "xml", inDirectory: "data")
        let url     = URL(fileURLWithPath: dummy!)
        let dirUrl  = url.deletingLastPathComponent()
        let en      = FileManager().enumerator(atPath: dirUrl.path)
        while let element = en?.nextObject() as? String {
            if element.hasSuffix("xml") {
                self.xmlliste.append(dirUrl.path+"/"+element)
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
            } catch {
                print(error)
            }
        }
        print(self.buecherliste)
        
        
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}




