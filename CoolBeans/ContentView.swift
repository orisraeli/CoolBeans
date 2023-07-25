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
	
    var body: some View {
		NavigationStack {
			List {
				if history.servings.isEmpty {
					Button("Add your first drink") {
						presentingAddScreen = true
					}
				} else {
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
