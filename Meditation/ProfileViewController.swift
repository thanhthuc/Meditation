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
            return profileViewModel.numOfRowsForSegmentOfType(type: .warmUp)
        case .CoolDown:
            return profileViewModel.numOfRowsForSegmentOfType(type: .coolDown)
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
            
        case .CoolDown:
            let cell = self.cellForCoolDownSectionForRowAtIndexPath(indexPath: indexPath)
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
        
        var result = UITableViewCell()
        
        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: Constant.profileEnableTableViewCell, for: indexPath) as? EnableTableViewCell {
                cell.enableLabel.text = "Enable"
                cell.enableSwitch.isOn = profileViewModel.segmentOfTypeEnabled(type: .warmUp)
                cell.switchHandler = { sender in
                    
                    self.profileViewModel.setSegmentOfType(type: .warmUp, enable: sender.isOn)
                    
                    if sender.isOn {
                        //Insert row
                        self.tableView.insertRows(at: [IndexPath.init(row: 1, section: indexPath.section) ], with: .top)
                    } else {
                        //delete row
                        self.tableView.deleteRows(at: [IndexPath.init(row: 1, section: indexPath.section)], with: .top)
                    }
                }
                result = cell
            }
        default:
            if let cell = tableView.dequeueReusableCell(withIdentifier: Constant.profileDefaultTableViewCell, for: indexPath) as? TimeTableViewCell {
                cell.tibetanLabel.text = ""
                cell.timeLabel.text = profileViewModel.timeForSegmentOfType(type: .warmUp)
                result = cell
            }
        }
        
        return result
    }
    
    private func cellForCoolDownSectionForRowAtIndexPath(indexPath: IndexPath) -> UITableViewCell {
        var result = UITableViewCell()
        
        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: Constant.profileEnableTableViewCell, for: indexPath) as? EnableTableViewCell {
                cell.enableLabel.text = "Enable"
                cell.enableSwitch.isOn = profileViewModel.segmentOfTypeEnabled(type: .coolDown)
                
                cell.switchHandler = { sender in
                    
                    var indexPaths = [IndexPath]()
                    
                    let currentNumberOfRows = self.profileViewModel.numOfRowsForSegmentOfType(type: .coolDown)
                    
                    self.profileViewModel.setSegmentOfType(type: .coolDown, enable: sender.isOn)
                    
                    let newNumberOfRows = self.profileViewModel.numOfRowsForSegmentOfType(type: .coolDown)
                    
                    
                    if sender.isOn {
                        //insert row
                        for row in (currentNumberOfRows)...(newNumberOfRows) {
                            indexPaths.append(IndexPath.init(row: row, section: indexPath.section))
                        }
                        self.tableView.insertRows(at: indexPaths, with: .top)
                        
                    } else {
                        //delete row
                        for row in (currentNumberOfRows)...(newNumberOfRows) {
                            indexPaths.append(IndexPath.init(row: row, section: indexPath.section))
                        }
                        self.tableView.deleteRows(at: indexPaths, with: .top)
                    }
                }
                result = cell
            }
            
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: Constant.profileDefaultTableViewCell, for: indexPath) as? TimeTableViewCell {
                cell.timeLabel.text = profileViewModel.timeForSegmentOfType(type: .coolDown)
                cell.tibetanLabel.text = ""
                
                result = cell
            }
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: Constant.profileEnableTableViewCell, for: indexPath) as? EnableTableViewCell {
                cell.enableLabel.text = "Enable"
                cell.enableSwitch.isOn = profileViewModel.segmentOfTypeEnabled(type: .coolDown)
                
                cell.switchHandler = { sender in
                    
                    var indexPaths = [IndexPath]()
                    
                    let currentNumberOfRows = self.profileViewModel.numOfRowsForSegmentOfType(type: .coolDown)
                    
                    //Update profile
                    self.profileViewModel.setSoundOfType(type: .Begin, enable: sender.isOn, forSegmentOfTime: .coolDown)
                    
                    let newNumberOfRows = self.profileViewModel.numOfRowsForSegmentOfType(type: .coolDown)
                    
                    
                    if sender.isOn {
                        //insert row
                        for row in (currentNumberOfRows)...(newNumberOfRows) {
                            indexPaths.append(IndexPath.init(row: row, section: indexPath.section))
                        }
                        self.tableView.insertRows(at: indexPaths, with: .top)
                        
                    } else {
                        //delete row
                        for row in (currentNumberOfRows)...(newNumberOfRows) {
                            indexPaths.append(IndexPath.init(row: row, section: indexPath.section))
                        }
                        self.tableView.deleteRows(at: indexPaths, with: .top)
                    }
                }
                result = cell
            }
            
        default:
            if let cell = tableView.dequeueReusableCell(withIdentifier: Constant.profileDefaultTableViewCell, for: indexPath) as? TimeTableViewCell {
                cell.timeLabel.text = "Name"
                cell.tibetanLabel.text = profileViewModel.nameSoundOfType(type: .Begin, forSegmentOfType: .coolDown)
                
                result = cell
            }
        }
        
        
        
        return result
    }
    
    
}









