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

    var presentSection: PublishSubject<Section> { get }
}

protocol VCDetailViewModelOutput {

    var selectedSection: Variable<Section?> { get }
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
    }

    // MARK: - Input
    let presentSection = PublishSubject<Section>()

    // MARK: - Output
    let selectedSection = Variable<Section?>(nil)
}
