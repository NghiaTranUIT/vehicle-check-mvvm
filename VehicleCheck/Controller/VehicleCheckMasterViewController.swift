//
//  VehicleCheckMasterViewController.swift
//  VehicleCheck
//
//  Created by Nghia Tran on 5/1/18.
//  Copyright © 2018 io.pie.core. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Action

class VehicleCheckMasterViewController: UIViewController {

    // MARK: - Variable
    var viewModel: VCMasterViewModelType!
    var leg: Leg!
    private let bag = DisposeBag()

    // MARK: - OUTLET
    @IBOutlet weak var tableView: UITableView!

    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()

        initCommon()
        initTableView()
        binding()
    }

    private func initCommon() {

    }

    private func initTableView() {
        tableView.register(UINib(nibName: "VCSectionCell", bundle: nil), forCellReuseIdentifier: "VCSectionCell")
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func binding() {

        // Type
        let input = viewModel.input
        let output = viewModel.output

        // Start Fetch
        input.loadVehicleCheckAction.execute(leg)

        // Bind to table view
        output.vehicleCheck.asDriver().drive(onNext: {[weak self] (sections) in
            guard let strongSelf = self else { return }

            // Reload
            strongSelf.tableView.reloadData()

            // Select first obj
            if sections.count > 0 {
                strongSelf.viewModel.input.selectedSection.onNext(0)
            }
        })
        .disposed(by: bag)
    }
}

extension VehicleCheckMasterViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.output.vehicleCheck.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VCSectionCell", for: indexPath) as! VCSectionCell

        let cellVM = viewModel.output.vehicleCheck.value[indexPath.row]
        cell.config(with: cellVM)
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.input.selectedSection.onNext(indexPath.row)
    }
}
