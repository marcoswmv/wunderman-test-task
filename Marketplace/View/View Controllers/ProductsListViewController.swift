//
//  ProductsListViewController.swift
//  Marketplace
//
//  Created by Marcos Vicente on 13/08/22.
//

import UIKit

final class ProductsListViewController: UIViewController {

    private var productsListTableViewManager: ProductsListTableViewManager?

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupListManager()
    }

    private func setupUI() {
        title = Text.productsTitleLabel.uppercased()

        view.backgroundColor = .systemBackground
        view.addSubview(tableView)

        tableView.frame = CGRect(x: 0.0,
                                 y: 0.0,
                                 width: Appearance.screenSize.width,
                                 height: Appearance.screenSize.height)
    }

    private func setupListManager() {
        let managerViewModel = ProductsListManagerViewModel(urlString: Text.jsonUrlString) { [weak self] errorMessage in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.showAlert(with: errorMessage)
            }
        }
        productsListTableViewManager = ProductsListTableViewManager(tableView: tableView,
                                                                    managerViewModel: managerViewModel,
                                                                    handleNavigation: { [weak self] viewModel in
            guard let self = self else { return }
            let detailViewModel = ProductDetailViewModel(productName: viewModel.name,
                                                         imageUrl: viewModel.imageUrl)
            let detailVC = ProductDetailViewController(viewModel: detailViewModel)
            self.navigationController?.pushViewController(detailVC, animated: true)
        })
    }
}
