//
//  HoursOfOperationView.swift
//  Sessionz2
//
//  Created by C4Q on 8/27/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import UIKit

class HoursOfOperationView: UIView {

    var hoursOfOperation: [HoursOfOperation]?
    
    
    
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
    
    
    
}
