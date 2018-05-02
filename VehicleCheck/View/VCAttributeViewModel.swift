//
//  VCAttributeViewModel.swift
//  VehicleCheck
//
//  Created by Nghia Tran on 5/1/18.
//  Copyright © 2018 io.pie.core. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol VCAttributeViewModelType {

    var input: VCAttributeViewModelInput { get }
    var output: VCAttributeViewModelOutput { get }
}

protocol VCAttributeViewModelInput {

}

protocol VCAttributeViewModelOutput {

    var title: Driver<String> { get }
    var subTitle: Driver<String> { get }
    var status: Variable<Attribute.Status> { get }
}

class VCAttributeViewModel: VCAttributeViewModelType, VCAttributeViewModelInput, VCAttributeViewModelOutput {

    var input: VCAttributeViewModelInput { return self }
    var output: VCAttributeViewModelOutput { return self }

    private let bag = DisposeBag()

    // MARK: - Output
    let title: Driver<String>
    let subTitle: Driver<String>
    let status = Variable<Attribute.Status>(Attribute.Status.notSelect)

    // MARK: - Init
    init(attribute: Attribute) {

        let attributeStream = Observable.just(attribute).share()

        title = attributeStream.map { $0.name }.asDriver(onErrorJustReturn: "")
        subTitle = attributeStream.map { $0.name }.asDriver(onErrorJustReturn: "")
        attributeStream.map { $0.status }.bind(to: status).disposed(by: bag)
    }
}
