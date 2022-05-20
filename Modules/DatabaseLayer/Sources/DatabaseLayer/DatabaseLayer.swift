//
//  UserDefaultsService.swift
//  CoolPool
//
//  Created by Maksym Svitlovskyi on 19.01.2022.
//

import Foundation

public protocol FavouritesDataBaseProtocol {
    associatedtype T: Equatable & Codable
    
    func add(_ item: T) throws
    func remove(_ item: T) throws
    func isFavourite(_ item: T) -> Bool
}

private class Keys {
    static let favourites = "favourites"
}

//TODO: - Its just for MVP, then create CoreData/SQL lite DB, or save info on back-end
public class FavouritesDataBase<T: Equatable & Codable>: FavouritesDataBaseProtocol {
    @UserDefault(key: Keys.favourites, defaultValue: [])
    private var favourites: [Data]
    
    public init() {}
    
    public func add(_ item: T) throws {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(item)
            favourites.append(data)
        } catch {
            throw error
        }
    }
    
    public func remove(_ item: T) throws {
        let encoder = JSONEncoder()
        let data = try? encoder.encode(item)
        guard let index = favourites.firstIndex(where: { $0 == data }) else { return }
        favourites.remove(at: index)
    }
    
    public func isFavourite(_ item: T) -> Bool {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(item) else { return false }
        return favourites.contains(data)
    }
    
    public func getItems() -> [T] {
        let decoder = JSONDecoder()
        let items: [T] = favourites.compactMap {
            do {
                return try decoder.decode(T.self, from: $0)
            } catch {
                return nil
            }
        }
        return items
    }
}

