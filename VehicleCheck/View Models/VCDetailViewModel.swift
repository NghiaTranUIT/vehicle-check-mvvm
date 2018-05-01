//
//  VCDetailViewModel.swift
//  VehicleCheck
//
//  Created by Nghia Tran on 5/1/18.
//  Copyright © 2018 io.pie.core. All rights reserved.
//

import Foundation

protocol VCDetailViewModelType {

    var input: VCDetailViewModelInput { get }
    var output: VCDetailViewModelOutput { get }
}

protocol VCDetailViewModelInput {

}

protocol VCDetailViewModelOutput {

}

class VCDetailViewModel: VCDetailViewModelType, VCDetailViewModelInput, VCDetailViewModelOutput {

    var input: VCDetailViewModelInput { return self }
    var output: VCDetailViewModelOutput { return self }
}
