//
//  PostsData.swift
//  trainee-task
//
//  Created by Stas Bezhan on 07.07.2022.
//

import Foundation

struct PostsData: Codable {
    var posts: [Posts]
}

struct Posts: Codable {
    var postId: Int
    var timeshamp: Int
    var title: String
    var preview_text: String
    var likes_count: Int
}
