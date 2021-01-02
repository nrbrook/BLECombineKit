//
//  BLECentralManagerMocks.swift
//  BLECombineKitTests
//
//  Created by Henry Javier Serrano Echeverria on 1/5/20.
//  Copyright © 2020 Henry Serrano. All rights reserved.
//

import Foundation
import CoreBluetooth
import BLECombineKit
import Combine

final class MockBLECentralManager: BLECentralManager {
    
    var centralManager: CBCentralManagerWrapper = MockCBCentralManagerWrapper()
    
    var isScanning: Bool = false
    
    var retrievePeripheralsWasCalledCount = 0
    func retrievePeripherals(withIdentifiers identifiers: [UUID]) -> AnyPublisher<BLEPeripheralProtocol, BLEError> {
        retrievePeripheralsWasCalledCount += 1
        return Just.init(BLEPeripheralMock())
            .setFailureType(to: BLEError.self)
            .eraseToAnyPublisher()
    }
    
    var retrieveConnectedPeripheralsWasCalledCount = 0
    func retrieveConnectedPeripherals(withServices serviceUUIDs: [CBUUID]) -> AnyPublisher<BLEPeripheralProtocol, BLEError> {
        retrieveConnectedPeripheralsWasCalledCount += 1
        return Just.init(BLEPeripheralMock())
            .setFailureType(to: BLEError.self)
            .eraseToAnyPublisher()
    }
    
    var scanForPeripheralsWasCalledCount = 0
    func scanForPeripherals(withServices services: [CBUUID]?, options: [String : Any]?) -> AnyPublisher<BLEScanResult, BLEError> {
        scanForPeripheralsWasCalledCount += 1
        
        let blePeripheral = BLEPeripheralMock()
        let advertisementData: [String: Any] = [:]
        let rssi = NSNumber.init(value: 0)
        
        let bleScanResult = BLEScanResult(peripheral: blePeripheral,
                                          advertisementData: advertisementData,
                                          rssi: rssi)
        
        return Just
            .init(bleScanResult)
            .setFailureType(to: BLEError.self)
            .eraseToAnyPublisher()
    }
    
    var stopScanWasCalledCount = 0
    func stopScan() {
        stopScanWasCalledCount += 1
    }
    
    var connectWasCalledCount = 0
    func connect(peripheralWrapper: CBPeripheralWrapper, options: [String:Any]?) {
        connectWasCalledCount += 1
    }
    
    var cancelPeripheralConnectionWasCalledCount = 0
    func cancelPeripheralConnection(_ peripheral: CBPeripheralWrapper) -> AnyPublisher<Bool, BLEError> {
        cancelPeripheralConnectionWasCalledCount += 1
        
        return Just.init(false).setFailureType(to: BLEError.self).eraseToAnyPublisher()
    }
    
    var registerForConnectionEventsWasCalledCount = 0
    func registerForConnectionEvents(options: [CBConnectionEventMatchingOption : Any]?) {
        registerForConnectionEventsWasCalledCount += 1
    }
    
}
