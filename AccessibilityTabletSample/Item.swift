//
//  Item.swift
//  AccessibilityTabletSample
//
//  Created by Andrej Jasso on 07/04/2025.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date

    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
