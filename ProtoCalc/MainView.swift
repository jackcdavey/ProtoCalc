import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ContentView()
                .badge(2)
                .tabItem {
                    Label("Calculator", systemImage: "tray.and.arrow.down.fill")
                }
            TestingRange()
                .badge(2)
                .tabItem {
                    Label("Testing", systemImage: "tray.and.arrow.up.fill")
                }
            
            
        }
    }
}
