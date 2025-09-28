//
//  TodoListViewModel.swift
//  TodoLite
//
//  Created by pengli on 9/27/25.
//

import Foundation
import Combine

@MainActor
final class TodoListViewModel: ObservableObject {
    @Published private(set) var items: [TodoItem] = []
    @Published var newTitle: String = ""

    private let storageKey = "todo.items"

    init() {
        load()
        if items.isEmpty {
            // Seed a few examples on first launch
            items = [
                TodoItem(title: "Buy milk"),
                TodoItem(title: "Walk the dog"),
                TodoItem(title: "Read a book", isDone: true)
            ]
            save()
        }
    }

    func addItem() {
        let trimmed = newTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        items.insert(TodoItem(title: trimmed), at: 0)
        newTitle = ""
        save()
    }

    func toggle(_ item: TodoItem) {
        guard let idx = items.firstIndex(of: item) else { return }
        items[idx].isDone.toggle()
        save()
    }

    func delete(at offsets: IndexSet) {
        // Remove in reverse order to keep indices valid
        for index in offsets.sorted(by: >) {
            guard items.indices.contains(index) else { continue }
            items.remove(at: index)
        }
        save()
    }

    private func save() {
        do {
            let data = try JSONEncoder().encode(items)
            UserDefaults.standard.set(data, forKey: storageKey)
        } catch {
            // In a sample app, we can ignore errors or log them.
            #if DEBUG
            print("Failed to save items: \(error)")
            #endif
        }
    }

    private func load() {
        guard let data = UserDefaults.standard.data(forKey: storageKey) else { return }
        do {
            items = try JSONDecoder().decode([TodoItem].self, from: data)
        } catch {
            #if DEBUG
            print("Failed to load items: \(error)")
            #endif
        }
    }
}
