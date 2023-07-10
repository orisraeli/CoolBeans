//
//  MenuView.swift
//  CoolBeans
//
//  Created by Or Israeli on 10/07/2023.
//

import SwiftUI

struct MenuView: View {
	@EnvironmentObject var menu: Menu
	
	let columns = [
		GridItem(.adaptive(minimum: 150))
	]
	
    var body: some View {
		NavigationStack {
			ScrollView {
				LazyVGrid(columns: columns, pinnedViews: .sectionHeaders) {
					ForEach(menu.sections) { section in
						Section {
							ForEach(section.drinks) { drink in
								VStack {
									Text(drink.name)
										.font(.system(.body, design: .serif))
								}
								.padding(.bottom)
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
			.navigationTitle("Add Drink")
		}
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
			.environmentObject(Menu())
    }
}
