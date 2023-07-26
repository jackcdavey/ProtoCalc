import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ContentView()
                .badge(1)
                .tabItem {
                    Label("Calculator", systemImage: "function")
						
                }
//				.background(.regularMaterial)
            TestingRange()
                .tabItem {
                    Label("Testing", systemImage: "testtube.2")
                }
//				.background(.regularMaterial)
            
            
        }
		.toolbarBackground(.regularMaterial)
		
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

