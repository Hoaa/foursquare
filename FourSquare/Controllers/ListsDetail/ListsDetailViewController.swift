//
//  ListsDetailViewController.swift
//  FourSquare
//
//  Created by nmint8m on 19.12.16.
//  Copyright © 2016 Duy Linh. All rights reserved.
//

import UIKit

class ListsDetailViewController: ViewController {

    @IBOutlet weak var listsDetailContainerTableView: UITableView!
    
    // MARK: - Override func
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        configureListsDetailContainerTableView()
    }

    override func loadData() {
        //
    }
    
    override func configureUI() {
        //
    }
    
    // MARK: - Private func
    func configureListsDetailContainerTableView() {
        // Frame
        listsDetailContainerTableView.frame = self.view.bounds
        
        // Cell
        listsDetailContainerTableView.rowHeight = UITableViewAutomaticDimension
        listsDetailContainerTableView.estimatedRowHeight = 500
        listsDetailContainerTableView.estimatedSectionHeaderHeight = 300
        
        // Register
        let nibForHeader = UINib(nibName: "ListsDetailHeaderTableViewCell", bundle: nil)
        listsDetailContainerTableView.register(nibForHeader, forCellReuseIdentifier: "ListsDetailHeaderTableViewCell")
        let nibForContent = UINib(nibName: "ListsDetailContentTableViewCell", bundle: nil)
        listsDetailContainerTableView.register(nibForContent, forCellReuseIdentifier: "ListsDetailContentTableViewCell")
        
        // DataSource and Delegate
        listsDetailContainerTableView.dataSource = self
        listsDetailContainerTableView.delegate = self
    }
}

extension ListsDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let listsDetailContentTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ListsDetailContentTableViewCell", for: indexPath) as? ListsDetailContentTableViewCell else { return UITableViewCell() }
        return listsDetailContentTableViewCell
    }
}

extension ListsDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let listsDetailHeaderTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ListsDetailHeaderTableViewCell") as?ListsDetailHeaderTableViewCell else { return UITableViewCell() }
        return listsDetailHeaderTableViewCell
    }
    
//    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
//        return 300
//    }
//    
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 500
//    }
}
