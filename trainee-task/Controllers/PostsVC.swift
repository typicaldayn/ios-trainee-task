//
//  ViewController.swift
//  trainee-task
//
//  Created by Stas Bezhan on 07.07.2022.
//

import UIKit

class PostsVC: UIViewController {
    
    var posts = Posts()
    var post = Post()
    var isAutomaticContent = false
    
    @IBOutlet weak var sorting: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        posts.getData {
            DispatchQueue.main.async {
                self.sortData()
            }
        }
        tableView.register(UINib(nibName: K.nibName, bundle: nil), forCellReuseIdentifier: K.cellId)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func sortData(){
        switch sorting.selectedSegmentIndex {
        case 0:
            posts.postsArray.sort(by: {$1.timeshamp < $0.timeshamp})
        case 1:
            posts.postsArray.sort(by: {$1.likes_count < $0.likes_count})
        default:
            print("error")
        }
        tableView.reloadData()
    }
    
    @IBAction func sortingChanged(_ sender: UISegmentedControl) {
        sortData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PostVC {
            destination.post = post.currentPost
        }
    }
}




//MARK: - UITableViewDelegate, UITableViewDataSource

extension PostsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  posts.postsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: K.cellId, for: indexPath) as? PostsCell{
            
            cell.postName.text = posts.postsArray[indexPath.row].title
            cell.postPreview.text = posts.postsArray[indexPath.row].preview_text
            cell.postLikes.text = String("❤️\(posts.postsArray[indexPath.row].likes_count)")
            
            cell.postPreview.numberOfLines = self.isAutomaticContent == false ? 2 : 0
            if self.isAutomaticContent == false{
                cell.but.setTitle("Expand", for: .normal)
            }else {
                cell.but.setTitle("Collapse", for: .normal)
            }
            
            cell.button = {[weak self] in
                self?.isAutomaticContent = !(self?.isAutomaticContent ?? false)
                self?.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
            
            
            let previousDate = Date(timeIntervalSince1970: TimeInterval(posts.postsArray[indexPath.row].timeshamp))
            let now = Date()
            let formatter = DateComponentsFormatter()
            formatter.unitsStyle = .brief
            formatter.allowedUnits = [.day]
            formatter.maximumUnitCount = 1
            let stringDate = formatter.string(from: previousDate, to: now)
            cell.postDate.text = stringDate
            K.iD = []
            posts.postsArray.forEach { post in
                K.iD.append(post.postId)
            }
            return cell
        }else{
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        K.postId = K.iD[indexPath.row]
        post.urlString = "https://raw.githubusercontent.com/anton-natife/jsons/master/api/posts/\(K.postId).json"
        post.getPost {
            DispatchQueue.main.async {[weak self] in
                self?.performSegue(withIdentifier: K.segue, sender: self)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

