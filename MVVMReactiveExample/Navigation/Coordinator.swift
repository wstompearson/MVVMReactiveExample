//
//  Coordinator.swift
//  MVVMReactiveExample
//
//  Created by Tom Pearson on 25/12/2018.
//  Copyright © 2018 Tom Pearson. All rights reserved.
//

import UIKit

final class Coordinator {
    let splitViewController: UISplitViewController

    var postsNavigationController: UINavigationController {
        return splitViewController.viewControllers[0] as! UINavigationController
    }
    
    init(_ splitView: UISplitViewController) {
        self.splitViewController = splitView
        self.splitViewController.loadViewIfNeeded()
        postsNavigationController.navigationBar.prefersLargeTitles = true
        
        let postsVC = postsNavigationController.viewControllers.first as! PostsTableViewController
        postsVC.delegate = self
    }
    
    func presentErrorAlert(_ error: Error) {
        DispatchQueue.main.async {
            self.postsNavigationController.presentErrorAlert(title: error.localizedDescription)
        }
    }
}

extension Coordinator: PostsViewControllerDelegate {
    func didSelect(_ post: Post) {
        let vc = PostDetailViewController()
        vc.viewModel = PostDetailViewModel(post: post)
        splitViewController.showDetailViewController(vc, sender: self)
    }
}
