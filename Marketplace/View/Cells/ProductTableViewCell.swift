//
//  ProductTableViewCell.swift
//  Marketplace
//
//  Created by Marcos Vicente on 13/08/22.
//

import UIKit

final class ProductTableViewCell: UITableViewCell {

    static let identifier: String = Text.productCellIdentifier

    private var downloadTask: URLSessionDataTask?

    private lazy var productContentView: UIView = {
        UIView()
    }()

    private lazy var loaderView: UIActivityIndicatorView = {
        UIActivityIndicatorView(style: .large)
    }()

    private lazy var pictureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = Appearance.cornerRadius
        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: Appearance.nameFontSize)
        return label
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        downloadTask?.cancel()
        pictureImageView.image = nil
    }

    private func setupUI() {
        addSubviews()
        makeConstraints()
    }

    private func addSubviews() {
        productContentView.subviews.forEach { $0.removeFromSuperview() }
        productContentView.removeFromSuperview()

        contentView.addSubview(productContentView)
        productContentView.addSubview(pictureImageView)
        productContentView.addSubview(nameLabel)
        productContentView.addSubview(priceLabel)

        pictureImageView.addSubview(loaderView)
    }

    private func makeConstraints() {
        productContentView.enableAutoLayout()
        productContentView.setConstraints(to: contentView)

        pictureImageView.enableAutoLayout()
        pictureImageView.setWidthConstraint(width: Appearance.imageSize)
        pictureImageView.setHeightConstraint(height: Appearance.imageSize, .defaultHigh)
        pictureImageView.setTopConstraint(to: productContentView,
                                          top: Appearance.contentSpacement)
        pictureImageView.setBottomConstraint(to: productContentView,
                                             bottom: -Appearance.contentSpacement)
        pictureImageView.setLeadingConstraint(to: productContentView,
                                              leading: Appearance.contentSpacement)

        loaderView.enableAutoLayout()
        loaderView.setCenterConstraint(to: pictureImageView)
        pictureImageView.bringSubviewToFront(loaderView)

        nameLabel.enableAutoLayout()
        nameLabel.setLeadingConstraint(to: pictureImageView,
                                       trailing: Appearance.contentSpacement)
        nameLabel.setTopConstraint(to: productContentView,
                                   top: Appearance.contentSpacement)
        nameLabel.setTrailingConstraint(to: productContentView,
                                        trailing: -Appearance.contentSpacement)

        priceLabel.enableAutoLayout()
        priceLabel.setLeadingConstraint(to: pictureImageView,
                                        trailing: Appearance.contentSpacement)
        priceLabel.setTopConstraint(to: nameLabel, bottom: Appearance.contentSpacement)
        priceLabel.setTrailingConstraint(to: productContentView, trailing: -Appearance.contentSpacement)
    }
}

extension ProductTableViewCell: Networking {
    func fill(with viewModel: ProductCellViewModel) {
        loaderView.startAnimating()
        downloadTask = downloadImage(from: viewModel.imageUrl) { [weak self] result in
            guard let self = self else { return }

            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self.loaderView.stopAnimating()
                    self.pictureImageView.image = image
                case .failure:
                    break
                }
            }
        }

        nameLabel.text = viewModel.name.uppercased()
        nameLabel.sizeToFit()

        priceLabel.attributedText = viewModel.generatePriceAttributedText()
    }
}
