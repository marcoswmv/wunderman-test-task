//
//  ProductDetailViewController.swift
//  Marketplace
//
//  Created by Marcos Vicente on 13/08/22.
//

import UIKit

final class ProductDetailViewController: UIViewController {

    private var viewModel: ProductDetailViewModel

    private lazy var pictureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: Appearance.detailNameFontSize)
        return label
    }()

    init(viewModel: ProductDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        layoutViews()
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground

        view.addSubview(nameLabel)
        view.addSubview(pictureImageView)

        nameLabel.text = viewModel.productName.uppercased()
        viewModel.setImage(for: pictureImageView)
    }

    private func layoutViews() {
        pictureImageView.frame = CGRect(origin: .zero,
                                        size: CGSize(width: Appearance.screenSize.width - (Appearance.contentSpacement * 2),
                                                     height: Appearance.screenSize.height - (Appearance.contentSpacement * 2)))
        pictureImageView.center = view.center

        nameLabel.frame = CGRect(origin: .zero,
                                 size: CGSize(width: Appearance.screenSize.width - (Appearance.contentSpacement * 2),
                                              height: Appearance.nameLabelHeight))
        nameLabel.center = CGPoint(x: Appearance.screenSize.width / 2,
                                   y: Appearance.screenSize.height - (Appearance.screenSize.height * 0.85))
        nameLabel.sizeToFit()
    }
}
