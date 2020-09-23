//
//  HoursOfOperationView.swift
//  Sessionz2
//
//  Created by C4Q on 8/27/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import UIKit

class HoursOfOperationView: UIView {

    var hoursOfOperation: [HoursOfOperation]? {
        didSet {
            setupLabelsWithHours()
        }
    }
    
    
    
    private lazy var sundayLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 12)
            label.textAlignment = .center
            return label
    }()
    
    private lazy var mondayLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 12)
            label.textAlignment = .center
            return label
    }()
    
    private lazy var tuesdayLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 12)
            label.textAlignment = .center
            return label
    }()
    
    private lazy var wednesdayLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 12)
            label.textAlignment = .center
            return label
    }()
    
    private lazy var thursdayLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 12)
            label.textAlignment = .center
            return label
    }()
    
    private lazy var fridayLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 12)
            label.textAlignment = .center
            return label
    }()
    
    private lazy var saturdayLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 12)
            label.textAlignment = .center
            return label
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
       
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupLabelsWithHours() {
         let labels = [sundayLabel, mondayLabel, tuesdayLabel, wednesdayLabel,thursdayLabel,fridayLabel,saturdayLabel]
        
        guard let hoursOfOperation = self.hoursOfOperation else {return}
        
        let stackView = UIStackView(arrangedSubviews: labels)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        addSubview(stackView)
        stackView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 4, paddingLeft: 4, paddingBottom: 4, paddingRight: 4)
        
        for num in 0..<hoursOfOperation.count {
            labels[num].text = hoursOfOperation[num].generateDisplayText()
        }
        
    }
    
    
}
