//
//  PostVC.swift
//  trainee-task
//
//  Created by Stas Bezhan on 08.07.2022.
//

import UIKit

class PostVC: UIViewController {
    
    var post: Post!
    
    @IBOutlet weak var postDate: UILabel!
    @IBOutlet weak var postLikes: UILabel!
    @IBOutlet weak var postText: UILabel!
    @IBOutlet weak var postName: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    
    var id = K.postId
    override func viewDidLoad() {
        super.viewDidLoad()
//        postImage.image = UIImage(imageLiteralResourceName: "https://miro.medium.com/max/1400/1*tkjabDrdbOTTQuiPB8_5Qg.jpeg")
//        self.post?.getPost {
//            self.post?.urlString = "https://raw.githubusercontent.com/anton-natife/jsons/master/api/posts/\(self.id).json"
//        }
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
            print(response?.suggestedFilename ?? url.lastPathComponent)
            DispatchQueue.main.async() { [weak self] in
                self?.postImage.image = UIImage(data: data)
            }
        }
    }


    func updateUI() {

        let previousDate = Date(timeIntervalSince1970: TimeInterval((post?.currentPost!.timeshamp ?? 1)))
        let now = Date()
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .brief
        formatter.allowedUnits = [.day]
        formatter.maximumUnitCount = 1
        let stringDate = formatter.string(from: previousDate, to: now)
        let url = URL(string: (post?.currentPost?.postImage) ?? "")
        downloadImage(from: url!)
        postDate.text = stringDate
        postName.text = post!.currentPost?.title
        postText.text = post!.currentPost?.text
        postLikes.text = String(describing:
                                    post!.currentPost?.likes_count)
    }
}
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
