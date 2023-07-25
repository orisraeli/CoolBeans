//
//  ConfigurationOption.swift
//  CoolBeans
//
//  Created by Or Israeli on 17/07/2023.
//

import Foundation

struct ConfigurationOption: Identifiable, Codable, Hashable {
	let id: UUID
	let name: String
	let calories: Int
	
	static let none = ConfigurationOption(id: UUID(), name: "None", calories: 0)
}
