//
//  VCDetailViewModel.swift
//  VehicleCheck
//
//  Created by Nghia Tran on 5/1/18.
//  Copyright © 2018 io.pie.core. All rights reserved.
//

import Foundation
import RxSwift
import Action

protocol VCDetailViewModelType {

    var input: VCDetailViewModelInput { get }
    var output: VCDetailViewModelOutput { get }
}

protocol VCDetailViewModelInput {

    var presentSection: PublishSubject<VCCheckSectionViewModelType> { get }
    var nextSectionAction: CocoaAction { get }
}

protocol VCDetailViewModelOutput {

    var selectedSection: Variable<VCCheckSectionViewModelType?> { get }
    var nextBtnEnable: Observable<Bool>! { get }
}

class VCDetailViewModel: VCDetailViewModelType, VCDetailViewModelInput, VCDetailViewModelOutput {

    var input: VCDetailViewModelInput { return self }
    var output: VCDetailViewModelOutput { return self }

    // MARK: - Variable
    private let bag = DisposeBag()

    // MARK: - Init
    init() {

        // Bind to selected section
        presentSection.asObservable().bind(to: selectedSection)
        .disposed(by: bag)

        selectedSection.asObservable().filterNil().subscribe(onNext: { (viewModel) in
            self.nextBtnEnable = viewModel.output.nextBtnEnable
        })
        .disposed(by: bag)
    }

    // MARK: - Input
    let presentSection = PublishSubject<VCCheckSectionViewModelType>()

    // MARK: - Output
    var nextBtnEnable: Observable<Bool>!
    let selectedSection = Variable<VCCheckSectionViewModelType?>(nil)
    var nextSectionAction: CocoaAction {
        return CocoaAction {
            NotificationCenter.default.post(name: NSNotification.Name("Next"), object: nil)
            return .empty()
        }
    }
}
