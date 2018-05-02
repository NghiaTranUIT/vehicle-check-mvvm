//
//  VCCheckSectionViewModel.swift
//  VehicleCheck
//
//  Created by Nghia Tran on 5/1/18.
//  Copyright © 2018 io.pie.core. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol VCCheckSectionViewModelType {

    var input: VCCheckSectionViewModelInput { get }
    var output: VCCheckSectionViewModelOutput { get }
}

protocol VCCheckSectionViewModelInput {

}

protocol VCCheckSectionViewModelOutput {

    var name: Driver<String> { get }
    var status: Driver<VCCheckSectionViewModel.Status> { get }
    var subSections: Variable<[VCSubSectionViewModel]> { get }
}

class VCCheckSectionViewModel: VCCheckSectionViewModelType, VCCheckSectionViewModelInput, VCCheckSectionViewModelOutput {

    var input: VCCheckSectionViewModelInput { return self }
    var output: VCCheckSectionViewModelOutput { return self }

    enum Status {
        case completed
        case failed
        case none
    }

    // MARK: - Private
    private let bag = DisposeBag()
    private let sectionSteam: Observable<Section>

    // MARK: - Output
    var name: Driver<String>
    let status: Driver<VCCheckSectionViewModel.Status>
    let subSections = Variable<[VCSubSectionViewModel]>([])

    // MARK: - Init
    init(section: Section) {
        sectionSteam = Observable.just(section).share()

        // Name
        name = sectionSteam.map { $0.name }.asDriver(onErrorJustReturn: "")

        // Sub section
        sectionSteam.map { (section) -> [VCSubSectionViewModel] in
            return section.subSections.map {
                return VCSubSectionViewModel(subSection: $0)
            }
        }
        .bind(to: subSections)
        .disposed(by: bag)

        // Complete or Failed Status
        status = subSections.asObservable().flatMap { (subSections) -> Observable<Status> in

            // If has any failed
            for subSection in subSections {
                for attribute in subSection.attributes.value {
                    if attribute.output.status.value == Attribute.Status.no {
                        return .just(Status.failed)
                    }
                }
            }

            // Get YES Attrubute count
            let statusYESCount = subSections.reduce(0, { (oldResult, subSection) -> Int in
                return oldResult + subSection.attributes.value.reduce(0, { (oldResult, attribute) -> Int in
                    if attribute.output.status.value == Attribute.Status.yes {
                        return oldResult + 1
                    }
                    return oldResult
                })
            })

            // Get total attribute
            let totalAttribute = subSections.reduce(0, { (oldResult, subSection) -> Int in
                return oldResult + subSection.attributes.value.count
            })

            // Compare
            if totalAttribute == statusYESCount {
                return .just(Status.completed)
            }

            return .just(Status.none)
        }
        .asDriver(onErrorJustReturn: VCCheckSectionViewModel.Status.none)

    }
}
