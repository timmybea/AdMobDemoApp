//
//  GoogleAdService.swift
//  AdMobDemoApp
//
//  Created by Tim Beals on 2018-08-20.
//  Copyright © 2018 Roobi Creative. All rights reserved.
//

import Foundation
import GoogleMobileAds

protocol GoogleAdServiceDelegate {
    func adWasDismissed()
    func unableToShow()
}

class GoogleAdService: NSObject {
    
    var delegate: GoogleAdServiceDelegate?
    
    var interstitialAd: GADInterstitial?
    
    private var isShowing = false
    
    override init() {
        GADMobileAds.configure(withApplicationID: "ca-app-pub-7286043563325113~1921425646") //real app id
    }
    
    func createAndLoadInterstitial() {
        
        let request = GADRequest()
        //test device - window/devices/identifier
        
        request.testDevices = [kGADSimulatorID]
        request.tag(forChildDirectedTreatment: true) //Safe for COPPA
        
        //you need to create an adMob account and register the app
        let interstitial = GADInterstitial(adUnitID: "ca-app-pub-7286043563325113/5024416928") //test ad unit id
        interstitial.delegate = self
        interstitial.load(request)
        self.interstitialAd = interstitial
    }
    
    func showInterstitial(in vc: UIViewController) {
        if vc.presentedViewController != nil {
            print("VC ALREADY PRESENTING. CANNOT SHOW AD")
            self.delegate?.unableToShow()
        } else {
            if let interstitial = self.interstitialAd {
                if interstitial.isReady {
                    interstitial.present(fromRootViewController: vc)
                    isShowing = true
                }
            }
        }
    }
}

extension GoogleAdService: GADInterstitialDelegate {
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        isShowing = false
        self.createAndLoadInterstitial()
        self.delegate?.adWasDismissed()
    }
    
}

