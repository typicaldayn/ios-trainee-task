//
//  PostsManager.swift
//  trainee-task
//
//  Created by Stas Bezhan on 07.07.2022.
//

import Foundation

class Posts {
    var urlString = "https://raw.githubusercontent.com/anton-natife/jsons/master/api/main.json"
    
    var postsArray: [Posts] = []
    
    struct AllPosts: Codable {
        var posts: [Posts]
    }
    
    struct Posts: Codable {
        var postId: Int
        var timeshamp: Int
        var title: String
        var preview_text: String
        var likes_count: Int
    }
    
    func getData(completed: @escaping ()->()) {
        
        guard let url = URL(string: urlString) else {
            print("Error creating url")
            completed()
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            if let e = error {
                print(e.localizedDescription)
            }
            
            do{
                let posts = try JSONDecoder().decode(AllPosts.self
                                                 ,from: data!)
                self.postsArray = posts.posts
            }catch{
                print(error.localizedDescription)
            }
            completed()
        }
        
        task.resume()
    }
}
