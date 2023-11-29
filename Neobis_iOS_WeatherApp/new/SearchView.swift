//
//  SearchView.swift
//  Neobis_iOS_WeatherApp
//
//  Created by iPak Tulane on 29/11/23.
//

import UIKit
import SnapKit

class SearchView: UIView {
    
    let gradientLayer = CAGradientLayer()
    
    let closeButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close"), for: .normal)
        return button
    }()
    
    let searchField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0)
        textField.placeholder = "   SEARCH LOCATION"
        textField.textColor = .black
        textField.layer.cornerRadius = 22
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let searchButton: UIButton = {
        let button = UIButton()
//        button.setTitle("Search", for: .normal)
        button.setImage(UIImage(named: "search"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 22
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let backgroundView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 40
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [
            UIColor(red: 48/255, green: 162/255, blue: 197/255, alpha: 1.0).cgColor,
            UIColor(red: 0/255, green: 36/255, blue: 47/255, alpha: 1.0).cgColor
        ]
        layer.addSublayer(gradientLayer)
        setupViews()
        setupConstraints()
    }
    
    func setupViews(){
        backgroundView.addSubview(closeButton)
        addSubview(backgroundView)
        addSubview(searchField)
//        addSubview(searchButton)
        searchField.addSubview(searchButton)
    }
    
    func setupConstraints(){
        backgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(350)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(backgroundView.snp.topMargin).offset(22)
            make.trailing.equalTo(backgroundView.snp.trailingMargin).offset(-17)
        }
        
        searchField.snp.makeConstraints { make in
            make.top.equalTo(backgroundView.snp.top).offset(65)
            make.leading.trailing.equalToSuperview().inset(55)
            make.height.equalTo(44)
        }
        
//        searchButton.snp.makeConstraints { make in
//            make.top.equalTo(searchField.snp.bottom).offset(20)
//            make.centerX.equalToSuperview()
//            make.width.equalTo(120)
//            make.height.equalTo(44)
//        }
        searchButton.snp.makeConstraints { make in
            make.centerY.equalTo(searchField.snp.centerY)
            make.trailing.equalTo(searchField.snp.trailing).offset(-10)
            make.width.height.equalTo(30)
        }

    }
    
}
