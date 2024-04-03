import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
    }
    
    func setup() {
        
        let homeController = HomeViewController()
        homeController.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        
        homeController.extendedLayoutIncludesOpaqueBars = true
        
        let profileController = ProfileViewController()
        profileController.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill")
            
        )
        profileController.extendedLayoutIncludesOpaqueBars = true
        
        
        viewControllers = [homeController, profileController]
        self.setTabBarAppeareance()
        homeController.tabBarItem.imageInsets = UIEdgeInsets(top: 2, left: 0, bottom: -2, right: 0)
        profileController.tabBarItem.imageInsets = UIEdgeInsets(
            top: 2, left: 0, bottom: -2, right: 0)
        self.selectedIndex = 1
        
    }
    
    func setTabBarAppeareance() {
        let layer = CAShapeLayer()
        layer.path =
        UIBezierPath(
            roundedRect: CGRect(
                x: 16, y: self.tabBar.bounds.minY - 5, width: self.tabBar.bounds.width - 32,
                height: self.tabBar.bounds.height + 10), cornerRadius: (self.tabBar.frame.width / 2)
        ).cgPath
        
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        layer.shadowRadius = 25.0
        layer.shadowOpacity = 0.3
        layer.borderWidth = 1.0
        layer.opacity = 1.0
        layer.isHidden = false
        layer.masksToBounds = false
        layer.fillColor = UIColor.black.cgColor
        
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.backgroundColor = .clear
            
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = appearance
            
        } else {
            self.tabBar.barTintColor = .clear
            self.tabBar.isTranslucent = false
            
        }
        
        self.tabBar.layer.insertSublayer(layer, at: 0)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.interactivePopGestureRecognizer?.delaysTouchesBegan = false
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.delegate = self
        
        if #available(iOS 15.0, *) {
            let barAppearance = UINavigationBarAppearance()
            barAppearance.backgroundColor = .black
            navigationController?.navigationBar.standardAppearance = barAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = barAppearance
            
        }
        self.tabBar.backgroundColor = .clear
        
    }
    
}

extension MainTabBarController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let mainNavigation = self.navigationController else { return false }
        if let tabController = mainNavigation.visibleViewController as? MainTabBarController {
            guard let nav = tabController.selectedViewController as? UINavigationController else {
                return false
            }
            return nav.viewControllers.count > 1
        }
        return true
        
    }
    
}
