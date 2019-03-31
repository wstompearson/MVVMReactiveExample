//
//  PostsTableViewController.swift
//  MVVMReactiveExample
//
//  Created by Tom Pearson on 24/12/2018.
//  Copyright © 2018 Tom Pearson. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol PostsViewControllerDelegate: class {
    func didSelect(_ post: Post)
}

class PostsTableViewController: UITableViewController {
    weak var delegate: PostsViewControllerDelegate?
    let disposeBag = DisposeBag()

    let viewModel = PostsTableViewViewModel()

    override func viewDidLoad() {
        createSearchController()
        bindSearchController()
        bindViewModel()
    }

    func createSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        navigationItem.searchController = searchController
    }

    func bindSearchController() {
        navigationItem.searchController?.searchBar.rx.text
            .orEmpty
            .throttle(0.3, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .bind(to: viewModel.searchValue)
            .disposed(by: disposeBag)
    }

    func bindViewModel() {
        viewModel.navigationTitle
            .drive(navigationItem.rx.title)
            .disposed(by: disposeBag)

        tableView.dataSource = nil
        viewModel.postTitles
            .drive(tableView.rx.items(cellIdentifier: .cellIdentifier)) { _, title, cell in
                cell.textLabel?.text = title
            }.disposed(by: disposeBag)

        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else {
                    return
                }
                self.viewModel.didSelectRowAt(index: indexPath.row, delegate: self.delegate)
                self.tableView.deselectRow(at: indexPath, animated: true)
            })
            .disposed(by: disposeBag)
    }
}

private extension String {
    static let cellIdentifier = "cell"
}
