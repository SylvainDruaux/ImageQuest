//
//  AppAlert.swift
//  ImageQuest
//
//  Created by Sylvain Druaux on 20/05/2024.
//

import SwiftUI

protocol AppAlert {
    var title: String { get }
    var message: String? { get }
    func getButtonsForAlert(action: (() -> Void)?) -> AnyView
}
