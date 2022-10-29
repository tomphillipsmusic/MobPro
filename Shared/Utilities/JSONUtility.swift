//
//  JSONUtility.swift
//  MobPro (iOS)
//
//  Created by Tom Phillips on 10/29/22.
//

import Foundation

struct JSONUtility {

    static func write<T: Codable>(_ data: T, to pathComponent: String) -> Void {
        do {
            let filePath = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent(pathComponent)

            try JSONEncoder().encode(data)
                .write(to: filePath)
            
        } catch (let error) {
            print(error)
        }
    }
    
    static func read<T: Codable> (from pathComponent: String) -> T? {
        do {
            let filePath = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                .appendingPathComponent(pathComponent)
            
            let data = try Data(contentsOf: filePath)
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            #if DEBUG
            print(error)
            #endif
            return nil
        }
    }
}
