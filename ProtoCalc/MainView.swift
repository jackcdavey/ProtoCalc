import SwiftUI

struct MainView: View {
	
	init() {
		UITabBar.appearance().isTranslucent = true
		UITabBar.appearance().shadowImage = UIImage()
	}
	
	var body: some View {
		
		
		
			TabView(selection: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Selection@*/.constant(1)/*@END_MENU_TOKEN@*/) {
				ContentView()
					.tabItem {
						Label("Calculator", systemImage: "function")
							.tag(1)
					}
				TestingRange()
					.tabItem {
						Label("Testing", systemImage: "testtube.2")
							.tag(5)
					}
			}
	}
}

struct MainView_Previews: PreviewProvider {
	static var previews: some View {
		MainView()
	}
}

