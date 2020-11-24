//
//  SongRowView.swift
//  MusicRecord
//
//  Created by User20 on 2020/11/18.
//

import SwiftUI

struct SongRowView: View {
    
    var song: Song
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(song.name)
                Text(song.singer)
                    .font(.footnote)
            }
            Spacer()
            Text("\(song.loveRate)")
        }
    }
}

struct SongRowView_Previews: PreviewProvider {
    static var previews: some View {
        SongRowView(song: Song(name: "這該死的拘執佮愛", singer: "珂拉琪 Collage", loveRate: 10, languageType: "台語", record: "愛團的歌"))
            .previewLayout(.sizeThatFits)
    }
}
