import UIKit
class NavigationController: UINavigationController, UIViewControllerTransitioningDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Status bar white font
        self.navigationBar.barStyle = UIBarStyle.black
        self.navigationBar.tintColor = UIColor.red
        
        print("a")
    }
}
