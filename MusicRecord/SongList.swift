//
//  SongList.swift
//  MusicRecord
//
//  Created by User20 on 2020/11/18.
//

import SwiftUI

struct SongList: View {
    
    @StateObject var songsData = SongData()
    @State private var showEditSong = false
    
    func move(from source: IndexSet, to destination: Int) {
        songsData.songs.move(fromOffsets: source, toOffset: destination)
    }
    
    func delete(at offsets: IndexSet) {
        songsData.songs.remove(atOffsets: offsets)
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(songsData.songs.indices, id: \.self) { (index) in
                    NavigationLink(destination: SongEditor(songsData: songsData, editSongIndex: index)) {
                        SongRowView(song: songsData.songs[index])
                    }
                }
                .onMove(perform: move)
                .onDelete(perform: delete)
            }
            .listRowBackground(Color.gray)
            .navigationBarTitle("歌曲列表")
            .toolbar(content: {
                /*ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Image(systemName: "trash")
                    })
                }*/
                
                ToolbarItem() {
                    Button(action: {
                        showEditSong.toggle()
                    }, label: {
                        Image(systemName: "plus.circle")
                    })
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            })
            .sheet(isPresented: $showEditSong) {
                NavigationView {
                    SongEditor(songsData: songsData)
                }
            }
        }
    }
}

struct SongList_Previews: PreviewProvider {
    static var previews: some View {
        SongList()
    }
}
