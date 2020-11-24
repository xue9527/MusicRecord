//
//  ContentView.swift
//  MusicRecord
//
//  Created by User20 on 2020/11/18.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var songsData = SongData()
    
    var body: some View {
        TabView {
            //PieChartView()
            SongList()
                .tabItem { Text("歌單") }
            PieChartView(songsData: songsData)
                .tabItem { Text("歌曲統計") }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
