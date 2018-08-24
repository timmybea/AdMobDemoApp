//
//  IAPProduct.swift
//  AdMobDemoApp
//
//  Created by Tim Beals on 2018-08-21.
//  Copyright © 2018 Roobi Creative. All rights reserved.
//

import Foundation
import StoreKit

extension SKProduct {

    enum product: String {
        case nonConsumable = "com.roobicreative.AdMobDemoApp.removeAds"
    }

}

extension SKPaymentTransactionState {
    
    func status() -> String {
        switch self {
        case .deferred:     return "deferred"
        case .failed:       return "failed"
        case .purchased:    return "purchased"
        case .purchasing:   return "purchasing"
        case .restored:     return "restored"
        }
    }
}


