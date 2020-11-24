//
//  Song.swift
//  MusicRecord
//
//  Created by User20 on 2020/11/18.
//

import Foundation

struct Song: Identifiable, Codable, Hashable {
    var id = UUID()
    var name: String
    var singer: String
    var loveRate: Int
    var languageType: String
    var record: String
}

