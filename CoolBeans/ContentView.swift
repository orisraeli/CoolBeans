//
//  ContentView.swift
//  CoolBeans
//
//  Created by Or Israeli on 10/07/2023.
//

import SwiftUI

struct ContentView: View {
	@StateObject var menu = Menu()
	@StateObject var history = History()
	@State private var presentingAddScreen = false
	
	var totalCaffeine: Int {
		history.servings.map(\.caffeine).reduce(0, +)
	}
	
	var totalCalories: Int {
		history.servings.map(\.calories).reduce(0, +)
	}
	
	
    var body: some View {
		NavigationStack {
			List {
				if history.servings.isEmpty {
					Button("Add your first drink") {
						presentingAddScreen = true
					}
				} else {
					Section("Summary") {
						Text("Caffeine: \(totalCaffeine) mg")
						Text("Calories: \(totalCalories) cal")
					}
					
					Section("History") {
						ForEach(history.servings) { serving in
							HStack {
								VStack(alignment: .leading) {
									Text(serving.name)
										.font(.headline)
									
									Text(serving.description)
										.font(.caption)
								}
								
								Spacer()
								
								VStack(alignment: .trailing) {
									Text("\(serving.caffeine) mg")
									Text("\(serving.calories) cal")
								}
								.font(.subheadline)
							}
							.swipeActions {
								Button(role: .destructive) {
									withAnimation {
										history.delete(serving)
									}
								} label: {
									Label("Delete", systemImage: "trash")
								}
								
								Button {
									withAnimation {
										history.reorder(serving)
									}
								} label: {
									Label("Repeat", systemImage: "repeat")
								}
								.tint(.blue)
							}
						}
					}
				}
			}
			.sheet(isPresented: $presentingAddScreen, content: MenuView.init)
			.navigationTitle("Cool Beans")
			.toolbar {
				Button {
					presentingAddScreen = true
				} label: {
					Label("Add New Drink", systemImage: "plus")
				}
			}
		}
			.environmentObject(menu)
			.environmentObject(history)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
