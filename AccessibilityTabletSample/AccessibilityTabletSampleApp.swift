//
//  AccessibilityTabletSampleApp.swift
//  AccessibilityTabletSample
//
//  Created by Andrej Jasso on 07/04/2025.
//

import SwiftUI
import SwiftData
import UniformTypeIdentifiers

@main
struct AccessibilityTabletSampleApp: App {
    var body: some Scene {
        DocumentGroup(editing: .itemDocument, migrationPlan: AccessibilityTabletSampleMigrationPlan.self) {
            ContentView()
        }
    }
}

extension UTType {
    static var itemDocument: UTType {
        UTType(importedAs: "com.example.item-document")
    }
}

struct AccessibilityTabletSampleMigrationPlan: SchemaMigrationPlan {
    static var schemas: [VersionedSchema.Type] = [
        AccessibilityTabletSampleVersionedSchema.self,
    ]

    static var stages: [MigrationStage] = [
        // Stages of migration between VersionedSchema, if required.
    ]
}

struct AccessibilityTabletSampleVersionedSchema: VersionedSchema {
    static var versionIdentifier = Schema.Version(1, 0, 0)

    static var models: [any PersistentModel.Type] = [
        Item.self,
    ]
}
