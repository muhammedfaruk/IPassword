//
//  InterstitialAd.swift
//  IPassword
//
//  Created by Muhammed Faruk Söğüt on 30.04.2023.
//

import UIKit
import GoogleMobileAds
import SwiftUI

class AdCoordinator: NSObject {
  private var ad: GADInterstitialAd?

  func loadAd() {
    GADInterstitialAd.load(
      withAdUnitID: "ca-app-pub-3940256099942544/4411468910", request: GADRequest()
    ) { ad, error in
      if let error = error {
        return print("Failed to load ad with error: \(error.localizedDescription)")
      }

      self.ad = ad
    }
  }

  func presentAd(from viewController: UIViewController) {
    guard let fullScreenAd = ad else {
      return print("Ad wasn't ready")
    }

    fullScreenAd.present(fromRootViewController: viewController)
  }
}

struct AdViewControllerRepresentable: UIViewControllerRepresentable {
  let viewController = UIViewController()

  func makeUIViewController(context: Context) -> some UIViewController {
    return viewController
  }

  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    // No implementation needed. Nothing to update.
  }
}
