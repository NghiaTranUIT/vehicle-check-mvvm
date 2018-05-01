//
//  NetworkingService.swift
//  VehicleCheck
//
//  Created by Nghia Tran on 5/1/18.
//  Copyright © 2018 io.pie.core. All rights reserved.
//

import Foundation
import RxSwift

protocol NetworkingServiceType {

    func fetchVehicleCheck(for leg: Leg) -> Observable<[Section]>
}

class NetworkingService: NetworkingServiceType {

    static let shared = NetworkingService()

    func fetchVehicleCheck(for leg: Leg) -> Observable<[Section]> {
        return Observable.create({ (observer) -> Disposable in

            // Fake data
            let data = VehicleCheckFactory.generateVehicleCheckResponse()

            observer.onNext(data.sections)
            observer.onCompleted()

            return Disposables.create()
        })
    }
}
