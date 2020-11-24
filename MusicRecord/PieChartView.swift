//
//  PieChartView.swift
//  MusicRecord
//
//  Created by User20 on 2020/11/23.
//

import SwiftUI

struct PieChartView: View {
    
    var songsData: SongData
    var language = ["未知", "中文", "台語", "客語", "粵語", "原住民語", "英文", "日文", "韓文", "其他"]
    var colors = [Color]()
    var percentages: [Double]
    //var angles: [Angle]
    var degree: [CGFloat]
    var totalSong = 0
    
    
    init(songsData: SongData) {
        self.songsData = songsData
        if songsData.songs.count != 0 {
            colors = [Color(red: 131/255, green: 151/255, blue: 136/255), Color(red: 238/255, green: 224/255, blue: 203/255),
                      Color(red: 186/255, green: 168/255, blue: 152/255), Color(red: 191/255, green: 215/255, blue: 234/255),
                      Color(red: 150/255, green: 187/255, blue: 187/255), Color(red: 242/255, green: 227/255, blue: 188/255),
                      Color(red: 193/255, green: 152/255, blue: 117/255), Color(red: 192/255, green: 201/255, blue: 153/255),
                      Color(red: 90/255, green: 188/255, blue: 185/255), Color(red: 176/255, green: 169/255, blue: 144/255)]
            //Color(red: 106/255, green: 153/255, blue: 78/255)
            percentages = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
            
            for song in self.songsData.songs {
                totalSong += 1
                //Type '()' cannot conform to 'View'; only struct/enum/class types can conform to protocols
                //ForEach(0..<language.count) { (index) in
                //    ...
                //}
                for index in 0..<language.count {
                    if song.languageType == language[index] {
                        percentages[index] += 1.0
                    }
                }
            }
            
            for index in 0..<language.count {
                percentages[index] /= Double(totalSong)
            }
            
            degree = [0.0, CGFloat(percentages[0])]
            
            for index in 2..<language.count {
                degree.append(CGFloat(percentages[index-1]) + degree[index-1])
            }
        } else {
            colors = [Color.white, Color.white, Color.white, Color.white, Color.white,
                      Color.white, Color.white, Color.white, Color.white, Color.white]
            percentages = [1.0]
            degree = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
        }
    }
    
    var body: some View {
        ZStack {
            ForEach(degree.indices) { (index) in
                PieChart(index: index, degree: self.degree, colors: self.colors)
            }
            Text("歌曲總數與各語言統計")
        }
    }
}

struct PieChartView_Previews: PreviewProvider {
    static var previews: some View {
        PieChartView(songsData: SongData())
    }
}

struct PieChart: View {
    var index : Int
    var degree : [CGFloat]
    var colors : [Color]
    var body: some View {
        VStack{
            if index == (self.degree.count-1){
                Circle()
                    .trim(from: self.degree[index], to:1)
                    .stroke(self.colors[index],lineWidth: CGFloat(30))
                    .frame(width: 300, height: 300)
            }
            else{
                Circle()
                    .trim(from: self.degree[index], to:self.degree[index+1])
                    .stroke(self.colors[index],lineWidth: CGFloat(30))
                    .frame(width: 300, height: 300)
            }
        }
    }
}
