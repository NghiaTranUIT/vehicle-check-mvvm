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

    var vehicleCheck: Variable<[Section]> { get }
}

class VCMasterViewModel: VCMasterViewModelType, VCMasterViewModelOutput, VCMasterViewModelInput {

    var input: VCMasterViewModelInput { return self }
    var output: VCMasterViewModelOutput { return self }

    // MARK: - Variable
    private let network: NetworkingServiceType
    private let bag = DisposeBag()

    // MARK: - Init
    init(network: NetworkingServiceType = NetworkingService.shared, detailViewModel: VCDetailViewModelType) {
        self.network = network

        // Load
        loadVehicleCheckAction = Action(workFactory: { (leg) in
            return self.network.fetchVehicleCheck(for: leg)
        })

        // Bind to data source
        loadVehicleCheckAction.elements.bind(to: vehicleCheck).disposed(by: bag)
    }

    // MARK: - Input
    var loadVehicleCheckAction: Action<Leg, [Section]>!
    let selectedSection = PublishSubject<Int>()

    // MARK: - Output
    let vehicleCheck = Variable<[Section]>([])

}
