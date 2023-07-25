//
//  History.swift
//  CoolBeans
//
//  Created by Or Israeli on 25/07/2023.
//

import Foundation

class History: ObservableObject {
	@Published private(set) var servings: [Serving]
	
	let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedDrinks")
	
	init() {
		do {
			let data = try Data(contentsOf: savePath)
			servings = try JSONDecoder().decode([Serving].self, from: data)
		} catch {
			servings = []
		}
	}
	
	func save() {
		do {
			let encoded = try JSONEncoder().encode(servings)
			try encoded.write(to: savePath, options: [.atomic, .completeFileProtection])
		} catch {
			print("Unable to save servings history (\(error.localizedDescription)).")
		}
	}
	
	func add(_ drink: Drink, size: String, extraShots: Int, isDecaf: Bool, milk: ConfigurationOption, syrup: ConfigurationOption, caffeine: Int, calories: Int) {
		var description = [String]()
		description.append(size)
		
		if isDecaf {
			description.append("decaffeinated")
		}
		
		switch extraShots {
			case 0:
				break
			case 1:
				description.append("1 extra shot")
			default:
				description.append("\(extraShots) extra shots")
		}
		
		if milk != .none {
			description.append("\(milk.name.lowercased()) milk")
		}
		
		if syrup != .none {
			description.append("\(syrup.name.lowercased()) syrup")
		}
		
		let descriptionString = description.joined(separator: ", ")
		
		let serving = Serving(id: UUID(), name: drink.name, description: descriptionString, caffeine: caffeine, calories: calories)
		servings.insert(serving, at: 0)
		save()
	}
}
