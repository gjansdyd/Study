//
//  NewsListTableViewController.swift
//  GoodNews
//
//  Created by mun on 2023/03/10.
//

import UIKit

class NewsListTableViewController: UITableViewController {
    
    private var articleListVM: ArticleListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(displayP3Red: 47/255,
                                             green: 54/255,
                                             blue: 64/255,
                                             alpha: 1.0)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=a3aad58231a3463c86338cf7a5ffee24")!
        WebService().getArticles(url: url,
                                 completion: { articles in
            self.articleListVM = ArticleListViewModel(articles: articles ?? [])
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.articleListVM == nil ? 0 : self.articleListVM.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleListVM.numberOfRowsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell",
                                                       for: indexPath) as? ArticleTableViewCell
        else { fatalError("ArticleTableViewCell not exist") }
        
        cell.titleLabel.text = self.articleListVM.articleAtIndex(indexPath.row).title
        cell.descriptionLabel.text = self.articleListVM.articleAtIndex(indexPath.row).description
        return cell
    }
}
