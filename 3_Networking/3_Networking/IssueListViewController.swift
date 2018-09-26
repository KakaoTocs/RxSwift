//
//  ViewController.swift
//  3_Networking
//
//  Created by Jinu Kim on 2018. 9. 24..
//  Copyright © 2018년 Jinu Kim. All rights reserved.
//

import UIKit
import Moya
import Moya_ModelMapper
import RxCocoa
import RxSwift

class IssueListViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    var provider: MoyaProvider<GitHub>!
    var issueTrackerModel: IssueTrackerModel!
    var latestRepositoryName: Observable<String> {
        return searchBar
            .rx.text
            .orEmpty
            .debounce(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRx()
    }
    

    func setupRx() {
        provider = MoyaProvider<GitHub>()
        issueTrackerModel = IssueTrackerModel(provider: provider, repositoryName: latestRepositoryName)
        
        issueTrackerModel
            .trackIssues()
            .bind(to: tableView.rx.items) { tableView, row, item in
                let cell = tableView.dequeueReusableCell(withIdentifier: "issueCell", for: IndexPath(row: row, section: 0))
                cell.textLabel?.text = item.title
                
                return cell
            }
            .disposed(by: disposeBag)
        
        tableView
            .rx.itemSelected
            .subscribe(onNext: { indexPath in
                if self.searchBar.isFirstResponder == true {
                    self.view.endEditing(true)
                }
            })
            .disposed(by: disposeBag)
    }

}

