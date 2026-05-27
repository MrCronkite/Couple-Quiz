//
//  StorageManager.swift
//  Couple Quiz
//
//  Created by Влад Шимченко on 27.05.2026.
//

import Foundation


protocol StorageManager {

    func set<Value>(
        _ value: Value,
        forKey key: StorageKey
    )

    func value<Value: Decodable>(
        forKey key: StorageKey,
        as type: Value.Type
    ) -> Value?

    func removeValue(
        forKey key: StorageKey
    )

    func contains(
        _ key: StorageKey
    ) -> Bool
}

// MARK: - Keys

enum StorageKey: String {

    case isOnboardingCompleted
    case accessToken
    case refreshToken
    case user
    case appTheme
}

// MARK: - Implementation

final class StorageManagerImpl: StorageManager {

    // MARK: Properties

    private let userDefaults: UserDefaults
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder

    // MARK: Init

    init(
        userDefaults: UserDefaults = .standard,
        encoder: JSONEncoder = JSONEncoder(),
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.userDefaults = userDefaults
        self.encoder = encoder
        self.decoder = decoder
    }

    // MARK: Public

    func set<Value>(
        _ value: Value,
        forKey key: StorageKey
    ) {

        switch value {

        case let value as Bool:
            userDefaults.set(value, forKey: key.rawValue)

        case let value as String:
            userDefaults.set(value, forKey: key.rawValue)

        case let value as Int:
            userDefaults.set(value, forKey: key.rawValue)

        case let value as Double:
            userDefaults.set(value, forKey: key.rawValue)

        case let value as Data:
            userDefaults.set(value, forKey: key.rawValue)

        default:

            guard let codableValue = value as? Codable else {
                assertionFailure("Unsupported type")
                return
            }

            do {
                let data = try encoder.encode(AnyEncodable(codableValue))
                userDefaults.set(data, forKey: key.rawValue)
            } catch {
                print("Storage encoding error:", error)
            }
        }
    }

    func value<Value: Decodable>(
        forKey key: StorageKey,
        as type: Value.Type
    ) -> Value? {

        switch type {

        case is Bool.Type:
            return userDefaults.bool(forKey: key.rawValue) as? Value

        case is String.Type:
            return userDefaults.string(forKey: key.rawValue) as? Value

        case is Int.Type:
            return userDefaults.integer(forKey: key.rawValue) as? Value

        case is Double.Type:
            return userDefaults.double(forKey: key.rawValue) as? Value

        case is Data.Type:
            return userDefaults.data(forKey: key.rawValue) as? Value

        default:

            guard let data = userDefaults.data(forKey: key.rawValue) else {
                return nil
            }

            do {
                return try decoder.decode(Value.self, from: data)
            } catch {
                print("Storage decoding error:", error)
                return nil
            }
        }
    }

    func removeValue(
        forKey key: StorageKey
    ) {
        userDefaults.removeObject(forKey: key.rawValue)
    }

    func contains(
        _ key: StorageKey
    ) -> Bool {
        userDefaults.object(forKey: key.rawValue) != nil
    }
}

struct AnyEncodable: Encodable {

    private let encodeClosure: (Encoder) throws -> Void

    init<T: Encodable>(_ wrapped: T) {
        self.encodeClosure = wrapped.encode
    }

    func encode(to encoder: Encoder) throws {
        try encodeClosure(encoder)
    }
}

