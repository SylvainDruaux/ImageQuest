//
//  Date+Ext.swift
//  ImageQuest
//
//  Created by Sylvain Druaux on 06/04/2024.
//

import Foundation

extension Date {
    func formattedDate(style: DateFormatter.Style) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = style
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: self)
    }
}
