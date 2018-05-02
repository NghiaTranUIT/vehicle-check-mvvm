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
    @IBOutlet weak var statusBtn: UIButton!
    
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
            switch status {
            case .completed:
                self.statusBtn.isHidden = false
                self.statusBtn.isHighlighted = false
                self.statusBtn.isSelected = true
            case .failed:
                self.statusBtn.isHidden = false
                self.statusBtn.backgroundColor = UIColor.red
                self.statusBtn.isHighlighted = true
                self.statusBtn.isSelected = false
            case .none:
                self.statusBtn.isHidden = true
            }
        })
        .disposed(by: bag)
    }
    
}
