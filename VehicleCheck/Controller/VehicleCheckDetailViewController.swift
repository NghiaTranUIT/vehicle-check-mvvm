//
//  VehicleCheckDetailViewController.swift
//  VehicleCheck
//
//  Created by Nghia Tran on 5/1/18.
//  Copyright © 2018 io.pie.core. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxOptional

class VehicleCheckDetailViewController: UIViewController {

    // MARK: - Variable
    var viewModel: VCDetailViewModelType!
    private let bag = DisposeBag()

    // MARK: - OUTLET
    @IBOutlet weak var tableView: UITableView!

    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()

        initTableView()
        binding()
    }

    private func initTableView() {
        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(UINib(nibName: "VCAttributeCell", bundle: nil), forCellReuseIdentifier: "VCAttributeCell")
    }

    private func binding() {

        let input = viewModel.input
        let output = viewModel.output

        // Bind to data source
        output.selectedSection.asObservable().filterNil().observeOn(MainScheduler.instance)
            .subscribe(onNext: {[weak self] (secton) in
                guard let strongSelf = self else { return }

                // Reload
                strongSelf.tableView.reloadData()
            })
        .disposed(by: bag)
    }
}

extension VehicleCheckDetailViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        guard let section = viewModel.output.selectedSection.value else { return 0 }
        return section.subSections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionData = viewModel.output.selectedSection.value else { return 0 }
        return sectionData.subSections[section].attributes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VCAttributeCell", for: indexPath) as! VCAttributeCell

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
