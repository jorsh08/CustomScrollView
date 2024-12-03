//
//  TabModel.swift
//  CustomScrollView
//
//  Created by Jorge Verdugo on 01/12/24.
//

import SwiftUI

struct TabModel: Identifiable {
    private(set) var id: Tab
    var size: CGSize = .zero
    var minX: CGFloat = .zero
    
    enum Tab: String, CaseIterable {
        case research = "Research"
        case deployment = "Development"
        case analyrics = "Analytics"
        case audience = "Audience"
        case privacy = "Privacy"
    }
}
