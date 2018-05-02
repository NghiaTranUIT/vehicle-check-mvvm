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
import Action

protocol VCAttributeViewModelType {

    var input: VCAttributeViewModelInput { get }
    var output: VCAttributeViewModelOutput { get }
}

protocol VCAttributeViewModelInput {

    var selectSegmentAction: Action<Int, Void>! { get }
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
    private let attributeStreamProperty = ReplaySubject<Attribute>.create(bufferSize: 1)
    private var attribute: Variable<Attribute>

    // MARK: - Output
    let title: Driver<String>
    let subTitle: Driver<String>
    let status = Variable<Attribute.Status>(Attribute.Status.notSelect)

    // MARK: - Input
    var selectSegmentAction: Action<Int, Void>!

    // MARK: - Init
    init(attribute: Attribute) {
        self.attribute = Variable<Attribute>(attribute)
        let attributeStream = self.attribute.asObservable().share()

        print("Init Attribute")
        
        title = attributeStream.map { $0.name }.asDriver(onErrorJustReturn: "")
        subTitle = attributeStream.map { $0.name }.asDriver(onErrorJustReturn: "")
        attributeStream.map { $0.status }.bind(to: status).disposed(by: bag)

        selectSegmentAction = Action { index in
            let currentAttribute = self.attribute.value
            switch index {
            case UISegmentedControlNoSegment:

                self.attribute.value = Attribute(id: currentAttribute.id, name: currentAttribute.name, status: .notSelect, key: currentAttribute.key)
            case 0:
                    self.attribute.value = Attribute(id: currentAttribute.id, name: currentAttribute.name, status: .yes, key: currentAttribute.key)
            case 1:
                    self.attribute.value = Attribute(id: currentAttribute.id, name: currentAttribute.name, status: .no, key: currentAttribute.key)
            default:
                    self.attribute.value = Attribute(id: currentAttribute.id, name: currentAttribute.name, status: .notSelect, key: currentAttribute.key)
            }

            return .just(())
        }
    }
}
