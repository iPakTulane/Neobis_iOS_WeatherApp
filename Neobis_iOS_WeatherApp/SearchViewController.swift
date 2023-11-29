//
//  SearchViewController.swift
//  Neobis_iOS_WeatherApp
//
//  Created by iPak Tulane on 22/11/23.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {
    
    let viewModel = WeatherViewModel()
    
    // MARK: - UI components
    
    var containerView: UIView = {
        let image = UIView()
        image.backgroundColor = .white
        image.layer.cornerRadius = 40.0
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "close"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
        return button
    }()
    
    var searchField: UITextField = {
        let field = UITextField()
        field.placeholder = "SEARCH LOCATION"
        field.autocapitalizationType = .none
        field.autocorrectionType = .yes
        field.backgroundColor = .lightGray
        field.layer.cornerRadius = 8
        field.layer.borderWidth = 0.5
        field.layer.borderColor = UIColor.label.cgColor
        return field
    }()
    
//    private lazy var searchLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 10)
//        label.textColor = .black
//        label.textAlignment = .left
//        label.text = "London"
//        label.layer.borderColor = .none
//        return label
//    }()
    
    var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(didTapSearch), for: .touchUpInside)
        return button
    }()
    
    var gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        return gradient
    }()
    
    // MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupConstraints()
        setupGradient()
    }
    
    // MARK: - Setup UI
    func setupHierarchy() {
        view.addSubview(containerView)
        containerView.addSubview(closeButton)
        containerView.addSubview(searchField)
//        containerView.addSubview(searchLabel)
//        searchField.addSubview(searchButton)
        containerView.addSubview(searchButton)
    }
    
    func setupConstraints() {
        
        // containerView
        containerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(70)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(365)
        }
        
        // closeButton
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(20)
            make.trailing.equalTo(containerView.snp.trailing).offset(-20)
            make.width.height.equalTo(30)
        }
        
        // searchField
        searchField.snp.makeConstraints { make in
            make.centerX.equalTo(containerView)
            make.top.equalTo(containerView.snp.top).offset(65)
            make.width.equalTo(305)
            make.height.equalTo(45)
        }
        
//        // searchLabel
//        searchLabel.snp.makeConstraints { make in
//            make.centerX.equalTo(containerView)
//            make.top.equalTo(searchField.snp.bottom).offset(30)
//            make.width.equalTo(305)
//            make.height.equalTo(45)
//        }
        
        // searchButton
        searchButton.snp.makeConstraints { make in
            make.centerY.equalTo(searchField)
            make.right.equalToSuperview().inset(17)
            make.width.height.equalTo(30)
        }
    }
    
    func setupGradient() {
        gradientLayer.frame = view.bounds
        let startColor = UIColor(red: 0.189, green: 0.637, blue: 0.771, alpha: 1)
        let endColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.locations = [0, 1]
        gradientLayer.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.75, y: 0.5)
        gradientLayer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0, b: 1, c: -1, d: 0, tx: 1, ty: 0))
        gradientLayer.bounds = view.bounds.insetBy(dx: -0.5 * view.bounds.size.width, dy: -0.5 * view.bounds.size.height)
        gradientLayer.position = view.center
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    // MARK: - Add targets
    @objc func didTapClose() {
        let vc = WeatherViewController()
        present(vc, animated: true, completion: nil)
    }

    @objc func didTapSearch() {
        
        guard let name = searchField.text else {
            return
        }
        viewModel.fetchWeatherData(by: name) { result in
            switch result {
            case .success:
                print("City is: ", name)
                print("Success")
            case .failure:
                print("Error")
            }
        }
    }
    
}
