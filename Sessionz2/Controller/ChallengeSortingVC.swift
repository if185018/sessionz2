//
//  ChallengeSortingVC.swift
//  Sessionz2
//
//  Created by C4Q on 12/7/20.
//  Copyright © 2020 Iram Fattah. All rights reserved.
//

import UIKit


private let reuseIdentifier = "ChallengeSortCell"

class ChallengeSortingVC: UIViewController {
    
    
    
    
    let challengeSorts = [ChallengeSort(icon: #imageLiteral(resourceName: "play"), type: .all),
                          ChallengeSort(icon: #imageLiteral(resourceName: "play"), type: .completed),
                          ChallengeSort(icon: #imageLiteral(resourceName: "play"), type: .outgoing),
                          ChallengeSort(icon: #imageLiteral(resourceName: "play"), type: .recieved)]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ChallengeSortCell.self, forCellReuseIdentifier: reuseIdentifier)
         tableView.tableFooterView = UIView(frame: .zero)
        
    }
    
    
    lazy var tableView : UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        return tv
    }()
    
}

extension ChallengeSortingVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return challengeSorts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ChallengeSortCell
        cell.challengeSort = challengeSorts[indexPath.row]
        return cell
    }
    
    
}
