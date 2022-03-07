//
//  AppDelegate.swift
//  MovieDb_MVP
//
//  Created by Santiago del Castillo Gonzaga on 04/03/22.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

    func application( _ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

      let navController = UINavigationController()

      let coordinator = MainCoordinator()
      coordinator.navigationController = navController
      coordinator.start()

      window = UIWindow(frame: UIScreen.main.bounds)
      window?.rootViewController = navController
      window?.makeKeyAndVisible()
      return true
  }

    private func applicationWillResignActive( application: UIApplication) {
  }

    private func applicationDidEnterBackground( application: UIApplication) {
  }

    private func applicationWillEnterForeground( application: UIApplication) {
  }

    private func applicationDidBecomeActive( application: UIApplication) {
  }

    private func applicationWillTerminate( application: UIApplication) {
  }

}

