//
//  ListViewModel.swift
//  MovieApp
//
//  Created by Mert Polat on 08.08.24.
//

import Foundation

class ListViewModel {
    static let shared = ListViewModel()
    
    private let userDefaults = UserDefaults.standard
    private let listKey = "userList"
    
    private init() {}
    
    func addToList(_ item: ListItem) {
        var currentList = getList()
        if !currentList.contains(where: { $0.id == item.id }) {
            currentList.append(item)
            saveList(currentList)
        }
    }
    
    func removeFromList(_ item: ListItem) {
        var currentList = getList()
        currentList.removeAll(where: { $0.id == item.id })
        saveList(currentList)
    }
    
    func getList() -> [ListItem] {
        guard let data = userDefaults.data(forKey: listKey),
              let list = try? JSONDecoder().decode([ListItem].self, from: data) else {
            return []
        }
        return list
    }
    
    private func saveList(_ list: [ListItem]) {
        if let encoded = try? JSONEncoder().encode(list) {
            userDefaults.set(encoded, forKey: listKey)
        }
    }
    
    func isInList(_ item: ListItem) -> Bool {
        return getList().contains(where: { $0.id == item.id })
    }
}
