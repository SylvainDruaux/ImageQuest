//
//  View+Ext.swift
//  ImageQuest
//
//  Created by Sylvain Druaux on 18/04/2024.
//

import SwiftUI

extension View {
    func errorAlert<T: AppAlert>(alert: Binding<T?>, action: (() -> Void)? = nil) -> some View {
        self
            .alert(alert.wrappedValue?.title ?? "Error", isPresented: .constant(alert.wrappedValue != nil), actions: {
                alert.wrappedValue?.getButtonsForAlert {
                    action?()
                }
            }, message: {
                if let message = alert.wrappedValue?.message {
                    Text(message)
                }
            })
    }
}
