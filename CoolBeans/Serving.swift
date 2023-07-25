//
//  Serving.swift
//  CoolBeans
//
//  Created by Or Israeli on 25/07/2023.
//

import Foundation

struct Serving: Codable, Identifiable {
	var id: UUID
	let name: String
	let description: String
	let caffeine: Int
	let calories: Int
}
