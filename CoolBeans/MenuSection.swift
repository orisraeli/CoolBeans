//
//  MenuSection.swift
//  CoolBeans
//
//  Created by Or Israeli on 10/07/2023.
//

import Foundation

struct MenuSection: Identifiable, Codable {
	let id: UUID
	let name: String
	let drinks: [Drink]
}
