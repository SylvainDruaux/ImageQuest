//
//  Date+Ext.swift
//  ImageQuest
//
//  Created by Sylvain Druaux on 06/04/2024.
//

import Foundation

extension Date {
    func formattedDate(style: DateFormatter.Style) -> String {
        DateFormatter.localizedString(from: self, dateStyle: style, timeStyle: .none)
    }
}
