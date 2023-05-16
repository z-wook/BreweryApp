//
//  BeerDetailVC.swift
//  BreweryApp
//
//  Copyright (c) 2023 oasis444. All right reserved.
//

import UIKit

class BeerDetailVC: UIViewController {

    var tableView = UITableView(frame: .zero, style: .insetGrouped)
    var beer: Beer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = beer?.name ?? "이름 없는 맥주"

        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "BeerDetailListCell")
        tableView.rowHeight = UITableView.automaticDimension

        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 300)
        let headerView = UIImageView(frame: frame)
        let imageURL = URL(string: beer?.imageURL ?? "")

        headerView.contentMode = .scaleAspectFit
        headerView.kf.setImage(with: imageURL, placeholder: UIImage(named: "beer_icon"))

        tableView.tableHeaderView = headerView // tableView 전체에 대한 Header
    }
}

extension BeerDetailVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 3:
            return beer?.foodParing?.count ?? 0
            
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section { // 각 Section에 대한 Header
        case 0:
            return "ID"
        case 1:
            return "Description"
        case 2:
            return "Brewers Tips"
        case 3:
            let isFoodParingEmpty = beer?.foodParing?.isEmpty ?? true
            return isFoodParingEmpty ? nil : "Food Paring"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BeerDetailListCell") else { return UITableViewCell() }
        cell.textLabel?.numberOfLines = 0 // titleLabel, imageView 기본으로 존재 / Deprecated!!!
        cell.selectionStyle = .none
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = "\(beer?.id ?? 0)"
            return cell
        case 1:
            cell.textLabel?.text = beer?.description ?? "설명 없는 맥주"
            return cell
        case 2:
            cell.textLabel?.text = beer?.brewersTips ?? "팁 없는 맥주"
            return cell
        case 3:
            cell.textLabel?.text = beer?.foodParing?[indexPath.row] ?? ""
            return cell
        default:
            return cell
        }
    }
}
