//
//  MenuView.swift
//  CoolBeans
//
//  Created by Or Israeli on 10/07/2023.
//

import SwiftUI

struct MenuView: View {
	@EnvironmentObject var menu: Menu
	@Environment(\.dismiss) var dismiss
	@State private var searchText = ""
	
	let columns = [
		GridItem(.adaptive(minimum: 150))
	]
	
    var body: some View {
		NavigationStack {
			ScrollView {
				LazyVGrid(columns: columns, pinnedViews: .sectionHeaders) {
					ForEach(menu.sections) { section in
						Section {
							ForEach(section.matches(for: searchText)) { drink in
								NavigationLink {
									CustomizeView(drink: drink) {
										dismiss()
									}
								} label: {
									VStack {
										Image(drink.image)
											.resizable()
											.scaledToFit()
											.cornerRadius(10)
										
										Text(drink.name)
											.font(.system(.body, design: .serif))
									}
									.padding(.bottom)
								}
								.buttonStyle(.plain)
							}
						} header: {
							Text(section.name)
								.font(.system(.title, design: .serif))
								.frame(maxWidth: .infinity, alignment: .leading)
								.padding([.top, .bottom, .trailing], 5)
								.background(.background)
						}
					}
				}
				.padding(.horizontal)
			}
			.toolbar {
				Button("Cancel") {
					dismiss()
				}
			}
			.navigationTitle("Add Drink")
			.searchable(text: $searchText)
		}
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
			.environmentObject(Menu())
    }
}
