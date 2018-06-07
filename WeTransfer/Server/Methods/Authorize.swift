//
//  Authorize.swift
//  WeTransfer
//
//  Created by Pim Coumans on 01/05/2018.
//  Copyright © 2018 WeTransfer. All rights reserved.
//

import Foundation

extension WeTransfer {

	private struct AuthorizeResponse: Decodable {
		let success: Bool
		let token: String?
	}
	
	/// Authorizes the current user with the configured API key
	///
	/// - Parameter completion: Executes when either succeeded or failed
	/// - Parameter result: Result with empty value when succeeded, or error when failed
	public static func authorize(completion: @escaping (_ result: Result<Void>) -> Void) {
		
		let callCompletion = { result in
			DispatchQueue.main.async {
				completion(result)
			}
		}
		
		if client.authenticationBearer != nil {
			callCompletion(.success(()))
			return
		}
		
		WeTransfer.request(.authorize()) { (result: Result<AuthorizeResponse>) in
			switch result {
			case .failure(let error):
				callCompletion(.failure(error))
			case .success(let response):
				if let token = response.token, response.success {
					client.authenticationBearer = token
					callCompletion(.success(()))
				} else {
					callCompletion(.failure(RequestError.authorizationFailed))
				}
			}
		}
	}
}
