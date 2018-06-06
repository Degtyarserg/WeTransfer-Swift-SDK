//
//  Result.swift
//  WeTransfer Swift SDK
//
//  Created by Pim Coumans on 26/04/2018.
//  Copyright © 2018 WeTransfer. All rights reserved.
//

import Foundation

public enum Result<Value> {
	case success(Value)
	case failure(Error)

	public var error: Error? {
		guard case .failure(let error) = self else { return nil }
		return error
	}

	public var value: Value? {
		guard case .success(let value) = self else { return nil }
		return value
	}
}
