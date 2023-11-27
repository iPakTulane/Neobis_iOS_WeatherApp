//
//  DailyCell.swift
//  Neobis_iOS_WeatherApp
//
//  Created by iPak Tulane on 22/11/23.
//

import UIKit
import SnapKit

class DailyCell: UICollectionViewCell {
    
    // MARK: - View model
    var viewModel: WeatherViewModel
    
    // MARK: - UI components
    private lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 7)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var iconView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.tintColor = .white
        return image
    }()

    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        viewModel = WeatherViewModel()
        super.init(frame: frame)
        setupHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup UI
    func setupHierarchy() {
        contentView.addSubview(dayLabel)
        contentView.addSubview(containerView)
        containerView.addSubview(iconView)
        containerView.addSubview(temperatureLabel)
    }

    func setupConstraints() {

        // Setup dayLabel
        dayLabel.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.top.equalTo(contentView.snp.top)
        }
        
        // Setup containerView
        containerView.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.bottom.equalTo(contentView.snp.bottom)
            make.width.equalTo(70)
            make.height.equalTo(75)
        }
        
        // Setup iconView
        iconView.snp.makeConstraints { make in
            make.centerX.equalTo(containerView)
            make.top.equalTo(containerView.snp.top).offset(10)
            make.width.height.equalTo(25)
        }
        
        // Setup temperatureLabel
        temperatureLabel.snp.makeConstraints { make in
            make.centerX.equalTo(containerView)
            make.bottom.equalTo(containerView.snp.bottom).offset(-10)
            make.width.equalTo(25)
            make.height.equalTo(15)
        }
        
    }
    
    // MARK: - Configure UI
    func configureCell(with data: WeatherData) {
//        dayLabel.text = data.day
//        iconView.image = UIImage(named: data.image)
//        temperatureLabel.text = data.temperature
    }
    
}


