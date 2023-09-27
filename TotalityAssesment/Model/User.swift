//
//  User.swift
//  TotalityAssesment
//
//  Created by Varun Bagga on 27/09/23.
//

import Foundation
import SwiftUI

// For having track of IDs for geometry effect
struct User: Identifiable {
    var id: UUID = UUID()
    
    static var samples: [User] = [
        User(),
        User(),
        User()
    ]
}

