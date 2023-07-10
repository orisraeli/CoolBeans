//
//  Drink.swift
//  CoolBeans
//
//  Created by Or Israeli on 10/07/2023.
//

import Foundation

struct Drink: Identifiable, Codable {
	let id: UUID
	let name: String
	
	static let example = Drink(id: UUID(), name: "Example Drink")
}
