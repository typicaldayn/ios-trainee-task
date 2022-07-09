//
//  PostVC.swift
//  trainee-task
//
//  Created by Stas Bezhan on 08.07.2022.
//

import UIKit

class PostVC: UIViewController {
    
    var post: Post.CurrentPost!
    
    @IBOutlet weak var postDate: UILabel!
    @IBOutlet weak var postLikes: UILabel!
    @IBOutlet weak var postName: UILabel!
    @IBOutlet weak var postText: UITextView!
    @IBOutlet weak var postImage: UIImageView!
    
    var id = K.postId
    override func viewDidLoad() {
        super.viewDidLoad()
        guard post != nil else {
            print("post is nil")
            return
        }
        updateUI()
    }

    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
//            print(response?.suggestedFilename ?? url.lastPathComponent)
            DispatchQueue.main.async() { [weak self] in
                self?.postImage.image = UIImage(data: data)
            }
        }
    }


    func updateUI() {

        let previousDate = Date(timeIntervalSince1970: TimeInterval((post.post.timeshamp)))
        let now = Date()
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .brief
        formatter.allowedUnits = [.day]
        formatter.maximumUnitCount = 1
        let stringDate = formatter.string(from: previousDate, to: now)
        let url = URL(string: (post.post.postImage))
        downloadImage(from: url!)
        postDate.text = stringDate
        postName.text = post.post.title
        postText.text = post.post.text
        postLikes.text = String(describing:
                                    "❤️ \(post.post.likes_count)")
    }
}
