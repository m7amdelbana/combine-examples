//
//  ExampleThreeViewController.swift
//  CombineExamples
//
//  Created by Mohamed Elbana on 03/10/2022.
//  Copyright © 2022 Mohamed Elbana. All rights reserved.
//

import UIKit
import Combine

class ExampleThreeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var cancellable: AnyCancellable?
    
    var posts: [Post] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    init() {
        super.init(nibName: String(describing: Self.self),
                   bundle: .init(for: Self.self))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadPosts()
    }
}

// MARK: - API calls

extension ExampleThreeViewController {
    
    // MARK: - 1. Load posts and ignore error
    
    func loadPostsIgnoreError() {
        guard let routeUrl = API.posts else { return }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: routeUrl)
            .map { $0.data }
            .decode(type: [Post].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .eraseToAnyPublisher()
            .sink(receiveValue: { posts in
                self.posts = posts
            })
    }
    
    // MARK: - 2. Load posts and ignore error with assign
    
    func loadPostsIgnoreErrorWithAssign() {
        guard let routeUrl = API.posts else { return }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: routeUrl)
            .map { $0.data }
            .decode(type: [Post].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .eraseToAnyPublisher()
            .assign(to: \.posts, on: self)
    }
    
    // MARK: - 3. Load posts with error handling
    
    func loadPosts() {
        guard let routeUrl = API.posts else { return }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: routeUrl)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse else {
                    throw APIError.noResponse
                }
                
                guard response.statusCode == 200 else {
                    throw APIError.know(statusCode: response.statusCode)
                }
                
                return output.data
            }
            .decode(type: [Post].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case let .failure(error):
                    _ = APIError.failure(error: error)
                }
            }, receiveValue: { posts in
                self.posts = posts
            })
    }
    
    // MARK: - 4. Load posts and Todos (Group multiple requests)
    
    func loadPostsAndTodos() {
        guard let routePostsUrl = API.posts,
              let routeTodosUrl = API.todos else { return }
        
        let decoder = JSONDecoder()
        
        let postsPublisher = URLSession.shared.dataTaskPublisher(for: routePostsUrl)
            .map { $0.data }
            .decode(type: [Post].self, decoder: decoder)
        
        let todosPublisher = URLSession.shared.dataTaskPublisher(for: routeTodosUrl)
            .map { $0.data }
            .decode(type: [Todo].self, decoder: decoder)
        
        cancellable = Publishers.Zip(postsPublisher, todosPublisher)
            .eraseToAnyPublisher()
            .catch { _ in
                Just(([], []))
            }
            .sink(receiveValue: { posts, todos in
                self.posts = posts
                print("TODOS COUNT: \(todos.count)")
            })
    }
    
    // MARK: - 5. Load posts with details (Request dependency)
    
    func loadPostWithDetails() {
        guard let routeUrl = API.posts else { return }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: routeUrl)
            .map { $0.data }
            .decode(type: [Post].self, decoder: JSONDecoder())
            .tryMap { posts in
                guard let id = posts.first?.id else {
                    throw APIError.noResponse
                }
                return id
            }
            .flatMap { id in
                return self.details(for: id)
            }
            .sink(receiveCompletion: { completion in
                
            }) { post in
                print("POST TITLE: \(post.title)")
            }
    }
    
    func details(for id: Int) -> AnyPublisher<Post, Error> {
        let url = URL(string: "\(API.posts?.absoluteString ?? "")/\(id)")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .mapError { $0 as Error }
            .map { $0.data }
            .decode(type: Post.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
