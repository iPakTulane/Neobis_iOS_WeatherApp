//
//  WeatherVC.swift
//  Neobis_iOS_WeatherApp
//
//  Created by iPak Tulane on 22/11/23.
//

import UIKit
import SnapKit

class WeatherVC: UIViewController {

    // MARK: - UI components
    let weatherView = CurrentView(viewModel: CurrentVM())
        
    // MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(weatherView)
        setupConstraints()
    }
    
    // MARK: - Setup UI 
    func setupConstraints() {
        weatherView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
        
    
}
