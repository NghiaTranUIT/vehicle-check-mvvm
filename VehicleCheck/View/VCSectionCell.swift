//
//  VCSectionCell.swift
//  VehicleCheck
//
//  Created by Nghia Tran on 5/1/18.
//  Copyright © 2018 io.pie.core. All rights reserved.
//

import UIKit
import RxSwift

class VCSectionCell: UITableViewCell {

    // MARK: - OUTLET
    @IBOutlet weak var titleLbl: UILabel!

    // MARK: - Private
    private let bag = DisposeBag()

    // MARK: - VIEW
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func config(with viewModel: VCCheckSectionViewModelType) {

        // Name
        viewModel.output.name.drive(titleLbl.rx.text).disposed(by: bag)

        // Complete or Failed
        viewModel.output.status.drive(onNext: { (status) in
            print(" ✅ status = \(status)")
        })
        .disposed(by: bag)
    }
    
}
