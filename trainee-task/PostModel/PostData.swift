//
//  PostData.swift
//  trainee-task
//
//  Created by Stas Bezhan on 07.07.2022.
//

import Foundation

struct PostData: Codable {
    let post: [Post]
}

struct Post: Codable {
    let postId: Int
    let timeshamp: Int
    let title: String
    let text: String
    let postImage: String
    let likes_count: Int
}
