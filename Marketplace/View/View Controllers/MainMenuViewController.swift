//
//  ViewController.swift
//  Marketplace
//
//  Created by Marcos Vicente on 13/08/22.
//

import UIKit

final class MainMenuViewController: UIViewController {

    private lazy var productsButton: UIButton = {
        let button = UIButton()
        button.layer.borderColor = Appearance.buttonColor.cgColor
        button.layer.borderWidth = Appearance.borderWidth
        button.layer.cornerRadius = Appearance.cornerRadius

        button.setTitleColor(Appearance.buttonColor, for: .normal)
        button.setTitle(Text.productsButtonLabel.uppercased(), for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        layoutButton()
    }

    private func setupUI() {
        title = Text.mainMenuTitleLabel
        navigationController?.navigationBar.prefersLargeTitles = true

        view.backgroundColor = .systemBackground
        view.addSubview(productsButton)
        
        productsButton.addTarget(self,
                                 action: #selector(navigateToProducts),
                                 for: .touchUpInside)
    }

    private func layoutButton() {
        productsButton.frame = CGRect(x: 0.0,
                                      y: 0.0,
                                      width: Appearance.screenSize.width - 160.0,
                                      height: 44.0)
        productsButton.center = CGPoint(x: Appearance.screenSize.width / 2,
                                        y: Appearance.screenSize.height / 2)
    }

    @objc private func navigateToProducts(sender: UIButton) {
        let productsListVC = ProductsListViewController()
        navigationController?.pushViewController(productsListVC, animated: true)
    }
}

