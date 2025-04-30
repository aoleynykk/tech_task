//
//  PaginationResponse.swift
//  tech_task
//
//  Created by Alex Oliynyk on 30.04.2025.
//

import Foundation

struct PageInfo: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
