//
//  TodoListView.swift
//  TodoLite
//
//  Created by pengli on 9/27/25.
//

import SwiftUI

struct TodoListView: View {
    @StateObject private var viewModel = TodoListViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HStack {
                    TextField("Add a new task", text: $viewModel.newTitle)
                        .textFieldStyle(.roundedBorder)
                        .onSubmit { viewModel.addItem() }
                    Button(action: viewModel.addItem) {
                        Image(systemName: "plus.circle.fill")
                            .imageScale(.large)
                    }
                    .disabled(viewModel.newTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    .accessibilityLabel("Add task")
                }
                .padding()

                List {
                    ForEach(viewModel.items) { item in
                        Button {
                            viewModel.toggle(item)
                        } label: {
                            HStack {
                                Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                                    .foregroundStyle(item.isDone ? .green : .secondary)
                                Text(item.title)
                                    .strikethrough(item.isDone)
                                    .foregroundStyle(item.isDone ? .secondary : .primary)
                                    .animation(.default, value: item.isDone)
                            }
                        }
                        .buttonStyle(.plain)
                        .accessibilityLabel(item.title)
                        .accessibilityHint(item.isDone ? "Mark as not done" : "Mark as done")
                    }
                    .onDelete(perform: viewModel.delete)
                }
                .listStyle(.inset)
            }
            .navigationTitle("My Todos")
        }
    }
}

#Preview {
    TodoListView()
}
