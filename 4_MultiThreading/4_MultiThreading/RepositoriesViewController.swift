//
//  ViewController.swift
//  4_MultiThreading
//
//  Created by Jinu Kim on 2018. 9. 24..
//  Copyright © 2018년 Jinu Kim. All rights reserved.
//

import UIKit
import ObjectMapper
import RxAlamofire
import RxCocoa
import RxSwift

class RepositoriesViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    var repositoryNetworkModel: RepositoryNetworkModel!
    var rxSearchBarText: Observable<String> {
        return searchBar
            .rx.text
            .orEmpty
            .filter { $0.count > 0 }
            .throttle(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
    }
    
//    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupRx()
    }

    func setupRx() {
        repositoryNetworkModel = RepositoryNetworkModel(withNameObservable: rxSearchBarText)
        
        repositoryNetworkModel
            .rxRepositories
            .drive(tableView.rx.items) { (tv, i, repository) in
                let cell = tv.dequeueReusableCell(withIdentifier: "repositoryCell", for: IndexPath(row: i, section: 0))
                cell.textLabel?.text = repository.name
                
                return cell
            }
            .disposed(by: disposeBag)
        
        repositoryNetworkModel
            .rxRepositories
            .debounce(0.5)
            .drive(onNext: { repositories in
                if repositories.count == 0 {
                    let alert = UIAlertController(title: ":(", message: "No repositories for this user.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    if self.navigationController?.visibleViewController?.isMember(of: UIAlertController.self) != true {
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
    }

}

