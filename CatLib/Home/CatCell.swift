import UIKit

class CatCell: UITableViewCell {
    private let horizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 16
        stack.layer.cornerRadius = 15
        stack.backgroundColor = .white
        return stack
    }()
    
    private let catImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 35
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .gray
        return imageView
    }()

    
    private let verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .equalCentering
        return stack
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let originLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        addViewsInHierarchy()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    public func setup(cat: Cat) {
        nameLabel.text = cat.name
        originLabel.text = "Country of origin: \(cat.origin)"
        catImageView.download(from: cat.url)
    }    
    private func setupView() {
        selectionStyle = .none
    }
    
    private func addViewsInHierarchy() {
        contentView.addSubview(horizontalStack)
        horizontalStack.addArrangedSubview(catImageView)
        horizontalStack.addArrangedSubview(verticalStack)
        verticalStack.addArrangedSubview(UIView())
        verticalStack.addArrangedSubview(nameLabel)
        verticalStack.addArrangedSubview(originLabel)
        verticalStack.addArrangedSubview(UIView())
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            horizontalStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 17),
            horizontalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            horizontalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            horizontalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            horizontalStack.heightAnchor.constraint(equalToConstant: 90)
        ])
        
        NSLayoutConstraint.activate([
            catImageView.widthAnchor.constraint(equalTo: catImageView.superview!.widthAnchor, multiplier: 0.2),
            catImageView.heightAnchor.constraint(equalTo: catImageView.superview!.widthAnchor, multiplier: 0.2),
            catImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
        ])
    }
}
