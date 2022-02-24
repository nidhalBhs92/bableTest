//
//  AppDelegate.swift
//  MyForcast
//
//  Created by Nidhal on 21/2/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    static let splashScreenDelay: CGFloat = 0.3

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if #available(iOS 13.0, *) {
            return true
        }
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UIStoryboard(name: "LaunchScreen",
                                                  bundle: nil).instantiateInitialViewController()
        window?.makeKeyAndVisible()
        
        rootUpdate()
        return true
    }
    
  
    func rootUpdate() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + AppDelegate.splashScreenDelay) {
            let rootVC = HomePageVC()
            self.window?.rootViewController = rootVC
            self.window?.makeKeyAndVisible()
        }
    }

}

