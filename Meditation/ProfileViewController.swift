//
//  ViewController.swift
//  Meditation
//
//  Created by Nguyen Thanh Thuc on 05/01/2017.
//  Copyright © 2017 Nguyen Thanh Thuc. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    
    var profileViewModel: ProfileViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ProfileViewController: UITableViewDelegate {
    
}

extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ProfileSection.count()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let profileSection = ProfileSection(rawValue: section) else {return 0}
        
        switch profileSection {
        case .WarmUp:
            return profileViewModel.numOfRowForSegmentOfType(type: .warmUp)
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = ProfileSection(rawValue: section) else {return ""}
        return section.sectionTitle()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let section = ProfileSection(rawValue: indexPath.section) else {return UITableViewCell()}
        
        switch section {
            
        case .Time:
            let cell = self.cellForTimeSectionForRowAtIndexPath(indexPath: indexPath)
            return cell
        
        case .WarmUp:
            let cell = self.cellForWarmUpSectionForRowAtIndexPath(indexPath: indexPath)
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    private func cellForTimeSectionForRowAtIndexPath(indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.profileDefaultTableViewCell, for: indexPath) as? TimeTableViewCell else {return UITableViewCell()}
        cell.timeLabel.text = profileViewModel.timeForProfile()
        return cell
    }
    
    private func cellForWarmUpSectionForRowAtIndexPath(indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
    
    
    
}

























