//
//  VCSubSectionViewModel.swift
//  VehicleCheck
//
//  Created by Nghia Tran on 5/2/18.
//  Copyright © 2018 io.pie.core. All rights reserved.
//

import Foundation
import RxSwift

protocol VCSubSectionViewModelType {

    var input: VCSubSectionViewModelInput { get }
    var output: VCSubSectionViewModelOutput { get }
}

protocol VCSubSectionViewModelInput {

}

protocol VCSubSectionViewModelOutput {

    var attributes: Variable<[VCAttributeViewModelType]> { get }
    var subSectionStream: Variable<SubSection> { get }
}

class VCSubSectionViewModel: VCSubSectionViewModelType, VCSubSectionViewModelInput, VCSubSectionViewModelOutput {

    var input: VCSubSectionViewModelInput { return self }
    var output: VCSubSectionViewModelOutput { return self }

    private let bag = DisposeBag()
    var attributes = Variable<[VCAttributeViewModelType]>([])
    var subSectionStream: Variable<SubSection>

    // MARK: - Init
    init(subSection: SubSection) {

        subSectionStream = Variable(subSection)

        subSectionStream.asObservable().map { (subSection) -> [VCAttributeViewModelType] in
            return subSection.attributes.map({ (attribute) -> VCAttributeViewModelType in
                return VCAttributeViewModel(attribute: attribute)
            })
        }
        .bind(to: attributes)
        .disposed(by: bag)

    }
}

