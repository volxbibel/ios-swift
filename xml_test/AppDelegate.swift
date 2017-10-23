

// AppDelegate:
// rootViewController --> BuecherController (TableView, die Bücherliste, User wählt Buch ... )
// BuecherController --> KapitelController  (TableView, die entsprechende Kapitelliste, User wählt Kapitel ... )
// KapitelController --> VerseController    (TextView,  die entsprechenden Verse)


import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Starte mit dem BuecherController
        let initialViewController: BuecherController? = BuecherController()
        self.window?.rootViewController = initialViewController
        
        // TODO unklar wie man den Navigation Controller sauber in den anderen Controllern anspricht ... 
        // Navigation, see https://stackoverflow.com/a/38614047/22470
        let navigationController = UINavigationController(rootViewController: initialViewController!)

        navigationController.isNavigationBarHidden          = false
        navigationController.navigationBar.topItem?.title   = "Volxbibel"
        navigationController.navigationBar.tintColor        = UIColor.black
        navigationController.navigationBar.isTranslucent    = true
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {}
    func applicationDidEnterBackground(_ application: UIApplication) {}
    func applicationWillEnterForeground(_ application: UIApplication) {}
    func applicationDidBecomeActive(_ application: UIApplication) {}
    func applicationWillTerminate(_ application: UIApplication) {}
}




