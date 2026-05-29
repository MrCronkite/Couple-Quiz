//
//  PurchaseManager.swift
//  Couple Quiz
//
//  Created by Влад Шимченко on 26.05.2026.
//

import SwiftUI
import SwiftyStoreKit
import StoreKit

enum PurchaseError: Error {
    case invalidProduct
    case purchaseFailed
    case restoreFailed
    case verificationFailed
}

protocol PurchaseManager {

    func completeTransactions()
    func getProduct(for id: String) async throws -> SKProduct
    func purchase(product id: String) async throws
    func restorePurchases() async throws
    func fetchReceipt() async throws -> String
    func verifySubscription(productId id: String) async throws -> Bool
}

final class PurchaseManagerImpl: PurchaseManager {

    private let sharedSecret = ""
    private let storage: StorageManager

    init() {
        storage = StorageManagerImpl()
    }
}

extension PurchaseManagerImpl {

    func completeTransactions() {
        SwiftyStoreKit.completeTransactions(atomically: true) { purchases in

            for purchase in purchases {

                switch purchase.transaction.transactionState {

                case .purchased, .restored:

                    if purchase.needsFinishTransaction {
                        SwiftyStoreKit.finishTransaction(purchase.transaction)
                    }

                case .failed, .purchasing, .deferred:
                    break

                @unknown default:
                    break
                }
            }
        }
    }

    func getProduct(for id: String) async throws -> SKProduct {
        try await withCheckedThrowingContinuation { continuation in

            SwiftyStoreKit.retrieveProductsInfo([id]) { result in

                if let product = result.retrievedProducts.first {
                    continuation.resume(returning: product)

                } else if let invalidProductId = result.invalidProductIDs.first {

                    print("Invalid product identifier: \(invalidProductId)")

                    continuation.resume(throwing: PurchaseError.invalidProduct)

                } else {

                    continuation.resume(
                        throwing: result.error ?? PurchaseError.invalidProduct
                    )
                }
            }
        }
    }

    func purchase(product id: String) async throws {

        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in

            SwiftyStoreKit.purchaseProduct(id, atomically: true) { [weak self] result in

                guard let self else {
                    continuation.resume(throwing: PurchaseError.purchaseFailed)
                    return
                }

                switch result {

                case .success(let purchase):

                    storage.set(true, forKey: .isPremium)

                    continuation.resume()

                case .error(let error):

                    if error.code == .paymentCancelled {
                        continuation.resume(throwing: error)
                    } else {
                        continuation.resume(throwing: error)
                    }

                case .deferred(purchase: let purchase):
                    continuation.resume()
                }
            }
        }
    }

    func restorePurchases() async throws {
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in

            SwiftyStoreKit.restorePurchases(atomically: true) { [weak self] results in

                guard let self else {
                    continuation.resume(throwing: PurchaseError.restoreFailed)
                    return
                }

                if results.restoreFailedPurchases.count > 0 {

                    continuation.resume(throwing: PurchaseError.restoreFailed)

                } else if results.restoredPurchases.count > 0 {

                    storage.set(true, forKey: .isPremium)

                    continuation.resume()

                } else {

                    continuation.resume(throwing: PurchaseError.restoreFailed)
                }
            }
        }
    }

    func fetchReceipt() async throws -> String {
        try await withCheckedThrowingContinuation { continuation in

            SwiftyStoreKit.fetchReceipt(forceRefresh: true) { result in

                switch result {

                case .success(let receiptData):

                    let receipt = receiptData.base64EncodedString()

                    continuation.resume(returning: receipt)

                case .error(let error):

                    continuation.resume(throwing: error)
                }
            }
        }
    }

    func verifySubscription(productId id: String) async throws -> Bool {
        let validator = AppleReceiptValidator(
            service: .production,
            sharedSecret: sharedSecret
        )

        return try await withCheckedThrowingContinuation { continuation in

            SwiftyStoreKit.verifyReceipt(using: validator) { result in

                switch result {

                case .success(let receipt):

                    let verifyResult = SwiftyStoreKit.verifySubscription(
                        ofType: .autoRenewable,
                        productId: id,
                        inReceipt: receipt
                    )

                    switch verifyResult {

                    case .purchased:

                        continuation.resume(returning: true)

                    case .expired:

                        continuation.resume(returning: false)

                    case .notPurchased:

                        continuation.resume(returning: false)
                    }

                case .error(let error):

                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
