//
//  ContentView.swift
//  CoolBeans
//
//  Created by Or Israeli on 10/07/2023.
//

import SwiftUI

struct ContentView: View {
	@StateObject var menu = Menu()
	
    var body: some View {
      MenuView()
			.environmentObject(menu)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
