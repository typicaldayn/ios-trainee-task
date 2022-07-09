//
//  PostManager.swift
//  trainee-task
//
//  Created by Stas Bezhan on 07.07.2022.
//

import Foundation

class Post {

    var urlString = ""
    var currentPost: CurrentPost?
    
    struct CurrentPost: Codable{
        let post: SpecificPost
    }
    
    struct SpecificPost: Codable {
        let postId: Int
        let timeshamp: Int
        let title: String
        let text: String
        let postImage: String
        let likes_count: Int
    }
    
    func getPost(completed: @escaping ()->()) {
        guard let url = URL(string: urlString) else {
            print("url error")
            completed()
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, respone, error )in
            if let e = error {
                print("error")
                print(e.localizedDescription)
            }
            do{
                let post = try JSONDecoder().decode(CurrentPost.self, from: data!)
                self.currentPost = post
            }catch{
                print(error.localizedDescription)
            }
            completed()
        }
        task.resume()
    }
}
