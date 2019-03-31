//
//  PostDetailViewController.swift
//  MVVMReactiveExample
//
//  Created by Tom Pearson on 23/12/2018.
//  Copyright © 2018 Tom Pearson. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PostDetailViewController: UIViewController {
    private let titleLabel = UILabel.makeMultiLineLabel()
    private let bodyLabel = UILabel.makeMultiLineLabel()
    private let authorLabel = UILabel.makeMultiLineLabel()
    private let numberOfCommentsLabel = UILabel.makeMultiLineLabel()

    var viewModel: PostDetailViewModel!

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        bindViewModel()
        createStackView()
    }

    private func bindViewModel() {
        viewModel.body
            .drive(bodyLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.title
            .drive(titleLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.author
            .drive(authorLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.numberOfCommentsDescription
            .drive(numberOfCommentsLabel.rx.text)
            .disposed(by: disposeBag)
    }

    private func createStackView() {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            bodyLabel,
            authorLabel,
            numberOfCommentsLabel
            ])

        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        view.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }
}
