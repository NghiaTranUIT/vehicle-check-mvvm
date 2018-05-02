//
//  VCMasterViewModel.swift
//  VehicleCheck
//
//  Created by Nghia Tran on 5/1/18.
//  Copyright © 2018 io.pie.core. All rights reserved.
//

import Foundation
import Action
import RxSwift

protocol VCMasterViewModelType {

    var input: VCMasterViewModelInput { get }
    var output: VCMasterViewModelOutput { get }
}

protocol VCMasterViewModelInput {

    var loadVehicleCheckAction: Action<Leg, [Section]>! { get }
    var selectedSection: PublishSubject<Int> { get }
}

protocol VCMasterViewModelOutput {

    var vehicleCheck: Variable<[VCCheckSectionViewModelType]> { get }
    var shouldSelectSectionOnTableView: PublishSubject<Int> { get }
    var presentSignatureController: PublishSubject<Void> { get }
}

class VCMasterViewModel: VCMasterViewModelType, VCMasterViewModelOutput, VCMasterViewModelInput {

    var input: VCMasterViewModelInput { return self }
    var output: VCMasterViewModelOutput { return self }

    // MARK: - Variable
    private let detailViewModel: VCDetailViewModelType
    private let network: NetworkingServiceType
    private let bag = DisposeBag()
    private var row = 0

    // MARK: - Init
    init(network: NetworkingServiceType = NetworkingService.shared, detailViewModel: VCDetailViewModelType) {
        self.network = network
        self.detailViewModel = detailViewModel

        // Load
        loadVehicleCheckAction = Action(workFactory: { (leg) in
            return self.network.fetchVehicleCheck(for: leg)
        })

        // Bind to data source
        loadVehicleCheckAction.elements
            .map({ (sections) -> [VCCheckSectionViewModelType] in
                return sections.map {
                    return VCCheckSectionViewModel(section: $0)
                }
            })
            .bind(to: vehicleCheck).disposed(by: bag)

        // Bind to Detail
        selectedSection.asObserver().map { [unowned self] (row) -> VCCheckSectionViewModelType in
            self.row = row
            return self.vehicleCheck.value[row]
        }
        .bind(to: detailViewModel.input.presentSection)
        .disposed(by: bag)

        //
        NotificationCenter.default.rx.notification(NSNotification.Name("Next"))
            .subscribe(onNext: { (_) in
                let nextRow = self.row + 1
                guard nextRow < self.vehicleCheck.value.count else {
                    self.presentSignatureController.onNext(())
                    return
                }
                self.shouldSelectSectionOnTableView.onNext(nextRow)
            })
        .disposed(by: bag)
    }

    // MARK: - Input
    var loadVehicleCheckAction: Action<Leg, [Section]>!
    let selectedSection = PublishSubject<Int>()

    // MARK: - Output
    let shouldSelectSectionOnTableView = PublishSubject<Int>()
    let vehicleCheck = Variable<[VCCheckSectionViewModelType]>([])
    let presentSignatureController = PublishSubject<Void>()

}
