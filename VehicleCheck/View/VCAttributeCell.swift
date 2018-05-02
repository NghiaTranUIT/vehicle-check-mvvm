//
//  VCAttributeCell.swift
//  VehicleCheck
//
//  Created by Nghia Tran on 5/1/18.
//  Copyright © 2018 io.pie.core. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Action

class VCAttributeCell: UITableViewCell {

    // MARK: - OUTLET
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var segment: UISegmentedControl!
    private var bag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()

        segment.selectedSegmentIndex = UISegmentedControlNoSegment
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        bag = DisposeBag()
    }

    func config(with viewModel: VCAttributeViewModelType) {

        // Title
        viewModel.output.title.drive(titleLbl.rx.text).disposed(by: bag)

        // Status
        viewModel.output.status.asObservable().take(1).asDriver(onErrorJustReturn: Attribute.Status.notSelect).map { (status) -> Int in
            switch status {
            case .no:
                return 1
            case .yes:
                return 0
            case .notSelect:
                return UISegmentedControlNoSegment
            }
        }
        .drive(segment.rx.selectedSegmentIndex)
        .disposed(by: bag)

        segment.rx.selectedSegmentIndex.asDriver().drive(onNext: { (index) in
            viewModel.input.selectSegmentAction.execute(index)
        }).disposed(by: bag)
    }
}
