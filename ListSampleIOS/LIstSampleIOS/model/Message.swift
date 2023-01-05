//
//  Message.swift
//  LIstSampleIOS
//
//  Created by Spud Hsu on 2023/1/5.
//

import Foundation

struct Message : Hashable, Identifiable, Codable {
    let id: Int
    let content: String?
    let time: Date
}
