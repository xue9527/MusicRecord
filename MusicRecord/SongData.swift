//
//  SongData.swift
//  MusicRecord
//
//  Created by User20 on 2020/11/18.
//

import Foundation
import SwiftUI

class SongData: ObservableObject {
    @AppStorage("songs") var songsData: Data?
    
    @Published var songs = [Song]() {
        didSet {
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(songs){
                UserDefaults.standard.set(data, forKey: "mySongs")
            }
            /*do {
                let data = try encoder.encode(songs)
                songsData = data
            } catch {
                //error
            }*/
        }
    }
    
    init() {
        if let songsData = UserDefaults.standard.data(forKey: "mySongs") {
            let decoder = JSONDecoder()
            if let decodedData = try? decoder.decode([Song].self, from: songsData) {
                songs = decodedData
            }
        }
    }
}
