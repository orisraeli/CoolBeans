//
//  CustomizeView.swift
//  CoolBeans
//
//  Created by Or Israeli on 17/07/2023.
//

import SwiftUI

struct CustomizeView: View {
	let drink: Drink
	
	@EnvironmentObject var menu: Menu
	
	@State private var size = 0
	@State private var isDecaff = false
	@State private var extraShots = 0
	@State private var milk = ConfigurationOption.none
	@State private var syrup = ConfigurationOption.none
	
	let sizeOptions = ["Small", "Medium", "Large"]
	
	var caffeine: Int {
		var caffeineAmount = drink.caffeine[size]
		caffeineAmount += extraShots * 60
		
		if isDecaff {
			caffeineAmount /= 20
		}
		
		return caffeineAmount
	}
	
	var calories: Int {
		var caloriesAmount = drink.baseCalories
		caloriesAmount += extraShots * 10
		
		if drink.coffeeBased {
			caloriesAmount += milk.calories
		} else {
			caloriesAmount += milk.calories / 8
		}
		
		caloriesAmount += syrup.calories
		return caloriesAmount * (size + 1)
	}
	
    var body: some View {
		Form {
			Section("Basic Options") {
				Picker("Size", selection: $size) {
					ForEach(sizeOptions.indices) { index in
						Text(sizeOptions[index])
					}
				}
				.pickerStyle(.segmented)
				
				if drink.coffeeBased {
					Stepper("Extra shots: \(extraShots)", value: $extraShots, in: 0...8)
				}
				
				Toggle("Decaffeinated", isOn: $isDecaff)
			}
			
			Section("Customizations") {
				Picker("Milk", selection: $milk) {
					ForEach(menu.milkOptions) { option in
						Text(option.name)
							.tag(option)
					}
				}
				
				if drink.coffeeBased {
					Picker("Syrup", selection: $syrup) {
						ForEach(menu.syrupOptions) { option in
							Text(option.name)
								.tag(option)
						}
					}
				}
			}
			
			
			Section("Estimates") {
				Text("**Caffeine:** \(caffeine) _mg_")
				Text("**Calories:** \(calories) cal")
			}
		}
		.navigationBarTitleDisplayMode(.inline)
		.navigationTitle(drink.name)
    }
}

struct CustomizeView_Previews: PreviewProvider {
    static var previews: some View {
		NavigationStack {
			CustomizeView(drink: Drink.example)
				.environmentObject(Menu())
		}
    }
}
