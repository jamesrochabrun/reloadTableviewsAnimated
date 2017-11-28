//
//  ViewController.swift
//  ReloadSectionAnimation
//
//  Created by james rochabrun on 11/17/17.
//  Copyright © 2017 james rochabrun. All rights reserved.
//

import UIKit

struct DataSource {
    
    static var twoDimensionalArray: [[String]] {
        return [
            ["Iniesta", "Messi", "Suarez", "Mascherano", "Ter Stegen"],
            ["Cavanni", "Neymar", "Dimbae"],
            ["ronaldo", "zidane", "marcelo", "bale", "pepe", "ramos", "isco", "kross"],
            ["griezman", "torres", "koke" ,"oblak"],
            ["guerrero", "farfan", "gareca"]
        ]
    }
}

class ViewController: UIViewController {
    
    static let reuseIdentifier: String = "cell"
    var showPlayers = true
    var section: Int = 0
    
    @IBOutlet weak var sectionTetxField: UITextField! {
        didSet {
            sectionTetxField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
            sectionTetxField.keyboardType = UIKeyboardType.phonePad
        }
    }
    @IBOutlet weak var playersTableView: UITableView!
    @IBOutlet weak var showPlayersButton: UIBarButtonItem!
    @IBOutlet weak var reloadSectionButton: UIButton! {
        didSet {
            reloadSectionButton.isUserInteractionEnabled = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func reloadSectionAt(_ sender: UIButton) {
        self.view.endEditing(true)
        guard DataSource.twoDimensionalArray.count >= section else { return }
        var indexPathsToReload = [IndexPath]()
        for row in DataSource.twoDimensionalArray[section].indices {
            let indexPath = IndexPath(row: row, section: section)
            indexPathsToReload.append(indexPath)
        }
        self.playersTableView.reloadRows(at: indexPathsToReload, with: .bottom)
    }
    
    @IBAction func reloadItemsInTable(_ sender: UIBarButtonItem) {
        
        var indexPathsToReload = [IndexPath]()
        for section in DataSource.twoDimensionalArray.indices {
            for row in DataSource.twoDimensionalArray[section].indices {
                let indexPath = IndexPath(row: row, section: section)
                indexPathsToReload.append(indexPath)
            }
        }
        showPlayers = !showPlayers
        self.showPlayersButton.title = showPlayers ? "Show Jersey" : "Show Players"
        let animationStyle = showPlayers ? UITableViewRowAnimation.right : .left
        self.playersTableView.reloadRows(at: indexPathsToReload, with: animationStyle)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ViewController.reuseIdentifier)
        cell?.textLabel?.text = showPlayers ? DataSource.twoDimensionalArray[indexPath.section][indexPath.row] :
        "Player number \(indexPath.row)"
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return DataSource.twoDimensionalArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataSource.twoDimensionalArray[section].count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 40))
        label.backgroundColor = UIColor.darkGray
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Section \(section)"
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}

extension ViewController {
    
    @objc func textChanged() {
        guard let text = sectionTetxField.text else { return }
        reloadSectionButton.isUserInteractionEnabled = text.isEmpty ? false : true
        guard let section = Int(text) else { return }
        self.section = section
    }
    
    
}




















