//
//  Utility.swift
//  NewsVKApp
//
//  Created by Baha Sadyr on 12/7/24.
//

import Foundation

class Utilities {
    
    static func extractDomain(from url: String?) -> String? {
        guard let urlString = url,
              let url = URL(string: urlString) else { return nil }
        return url.host
    }
    
    static func formatDate(from apiDateString: String?) -> String? {
        guard let apiDateString = apiDateString else { return nil }
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "d MMMM yyyy"
        outputFormatter.locale = Locale(identifier: "ru_RU")
        if let date = inputFormatter.date(from: apiDateString) {
            return outputFormatter.string(from: date)
        } else {
            return nil
        }
    }
    
    static func formatDateForVKDate(from time: Int?) -> String {
            guard let time = time else { return "N/A" }
            let date = Date(timeIntervalSince1970: TimeInterval(time))
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
            formatter.locale = Locale.current
            return formatter.string(from: date)
        }
    
    
}
