//
//  APIClient.swift
//  WeTransfer Swift SDK
//
//  Created by Pim Coumans on 01/05/2018.
//  Copyright © 2018 WeTransfer. All rights reserved.
//

import Foundation

final class APIClient {
	internal(set) var apiKey: String?
	internal(set) var baseURL: URL?
	var authenticationBearer: String?
	
	let urlSession: URLSession = URLSession(configuration: .default, delegate: nil, delegateQueue: nil)
	
	let operationQueue: OperationQueue = OperationQueue()
	
	let decoder: JSONDecoder = {
		let decoder = JSONDecoder()
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		return decoder
	}()
	
	let encoder: JSONEncoder = {
		let encoder = JSONEncoder()
		encoder.keyEncodingStrategy = .convertToSnakeCase
		return encoder
	}()
}

extension APIClient {
	
	/// Creates a URLRequest from an enpoint and optionally data to send along
	///
	/// - Parameters:
	///   - endpoint: Endpoint describing the url and HTTP method
	///   - data: Optional data to add to the request body
	/// - Returns: URLRequest pointing to URL with appropriate HTTP method set
	/// - Throws: `WeTransfer.Error` when not configured or not authorized
	func createRequest(_ endpoint: APIEndpoint, data: Data? = nil) throws -> URLRequest {
		// Check auth
		guard let apiKey = apiKey else {
			throw WeTransfer.Error.notConfigured
		}
		guard !endpoint.requiresAuthentication || authenticationBearer != nil else {
			throw WeTransfer.Error.notAuthorized
		}
		guard let baseURL = baseURL, let url = endpoint.url(with: baseURL) else {
			throw WeTransfer.Error.notConfigured
		}
		
		var request = URLRequest(url: url)
		request.httpMethod = endpoint.method.rawValue
		request.addValue(apiKey, forHTTPHeaderField: "x-api-key")
		
		if let token = authenticationBearer {
			request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
		}
		if let data = data {
			request.httpBody = data
		}
		return request
	}
}
