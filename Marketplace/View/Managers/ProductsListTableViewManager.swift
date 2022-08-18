//
//  ProductsListTableViewManager.swift
//  Marketplace
//
//  Created by Marcos Vicente on 13/08/22.
//

import UIKit

final class ProductsListTableViewManager: NSObject {

    private weak var tableView: UITableView?

    private let managerViewModel: ProductsListManagerViewModel
    private var viewModels: [ProductCellViewModel] = [ProductCellViewModel]()
    private var handleNavigation: ((ProductCellViewModel) -> Void)

    init(tableView: UITableView,
         managerViewModel: ProductsListManagerViewModel,
         handleNavigation: @escaping ((ProductCellViewModel) -> Void)) {
        self.tableView = tableView
        self.managerViewModel = managerViewModel
        self.handleNavigation = handleNavigation

        super.init()
        setupTableView()
        populateDataSource()
    }

    private func setupTableView() {
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.identifier)
    }

    private func populateDataSource() {
        managerViewModel.posts.bind { [weak self] cellViewModels in
            guard let self = self,
                  let cellViewModels = cellViewModels else { return }
            self.viewModels = cellViewModels
            DispatchQueue.main.async {
                self.tableView?.reloadData()
            }
        }
    }
}

extension ProductsListTableViewManager: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let viewModel = viewModels[indexPath.row]
        handleNavigation(viewModel)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier) as! ProductTableViewCell

        cell.fill(with: viewModels[indexPath.row])
        
        return cell
    }
}
