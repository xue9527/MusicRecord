//
//  SongEditor.swift
//  MusicRecord
//
//  Created by User20 on 2020/11/18.
//

import SwiftUI

struct SongEditor: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var name = ""
    @State private var singer = ""
    @State private var loveRate = 0
    @State private var record = ""
    @State private var languageType = "未知"
    //@State private var songCount = 0
    //@State private var languageCount = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    //@State private var rateCount = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    var songsData: SongData
    var editSongIndex: Int?
    var language = ["未知", "中文", "台語", "客語", "粵語", "原住民語", "英文", "日文", "韓文", "其他"]
    
    var body: some View {
        //NavigationView {
        //ScrollView(.vertical, showsIndicators: /*@START_MENU_TOKEN@*/false/*@END_MENU_TOKEN@*/) {
            Form {
                TextField("歌名", text: $name)
                TextField("歌手或團體", text: $singer)
                    
                Stepper("喜愛程度 \(loveRate) 分", value: $loveRate, in: 0...10)
                
                VStack {
                    Text("選擇語言")
                    Picker(selection: $languageType, label: Text("選擇語言")) {
                        ForEach(language, id: \.self) { type in
                            Text(type)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(height: 140)
                    .clipped()
                }
                
                VStack {
                    Text("下方可以紀錄聽歌心情唷！")
                    TextEditor(text: $record)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 2))
                        .frame(height: 300)
                }
                .padding()
            }
            .onAppear(perform: {
                if let editSongIndex = editSongIndex {
                    let editSong = songsData.songs[editSongIndex]
                    name = editSong.name
                    singer = editSong.singer
                    loveRate = editSong.loveRate
                    languageType = editSong.languageType
                    record = editSong.record
                }
            })
            .navigationBarTitle(editSongIndex == nil ? "增加新歌" : "編輯")
            .navigationBarItems(trailing: Button("儲存") {
                let song = Song(name: name, singer: singer, loveRate: loveRate, languageType: languageType, record: record)
                if let editSongIndex = editSongIndex {
                    songsData.songs[editSongIndex] = song
                } else {
                    songsData.songs.insert(song, at: 0)
                    /*
                    //計算歌曲的語言總數
                    for index in 0..<language.count {
                        if languageType == language[index] {
                            languageCount[index] += 1
                        }
                    }
                    
                    //計算歌曲的分數總數
                    rateCount[loveRate] += 1
                    */
                }
                presentationMode.wrappedValue.dismiss()
            })
        //}
    }
}

struct SongEditor_Previews: PreviewProvider {
    static var previews: some View {
        SongEditor(songsData: SongData())
    }
}
