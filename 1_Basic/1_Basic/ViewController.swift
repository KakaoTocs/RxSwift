//
//  ViewController.swift
//  1_Basic
//
//  Created by Jinu Kim on 2018. 9. 23..
//  Copyright © 2018년 Jinu Kim. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var shownCities = [String]()
    let allCities = ["New York", "London", "Oslo", "Warsaw", "Berlin", "Tokyo", "Slovenian", "Akita", "Cologne", "Quebec", "Munich"]
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        searchBar
            .rx.text
            .orEmpty
            .debounce(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .filter { !$0.isEmpty }
            .subscribe(onNext: { [unowned self] query in
                print(query)
                self.shownCities = self.allCities.filter { $0.hasPrefix(query) }
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shownCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath)
        cell.textLabel?.text = shownCities[indexPath.row]
        
        return cell
    }

}

