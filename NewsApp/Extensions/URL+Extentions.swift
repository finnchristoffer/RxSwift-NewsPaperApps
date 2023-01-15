//
//  URL+Extentions.swift
//  NewsApp
//
//  Created by Finn Christoffer Kurniawan on 15/01/23.
//

import Foundation

extension URL {
    static func urlForNews() -> URL? {
            return URL(string: "https://newsapi.org/v2/top-headlines?country=id&apiKey=003f9cf2364c4f338df38fe6400114e7")
        }
}
