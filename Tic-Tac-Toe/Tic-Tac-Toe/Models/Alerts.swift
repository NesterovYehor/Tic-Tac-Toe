//
//  Alerts.swift
//  Tic-Tac-Toe
//
//  Created by Егор  on 13.07.2022.
//

import Foundation
import SwiftUI

struct AlertItem: Identifiable{
    var id: UUID = UUID()
    var title: Text
    var massage: Text
    var buttonTitle: Text
}
