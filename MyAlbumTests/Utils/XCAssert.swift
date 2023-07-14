//
//  XCAssert.swift
//  MyAlbumTests
//
//  Created by Kiarash Vosough on 7/13/23.
//

import XCTest

func XCTAssertThrowsError<T>(
    _ expression: @autoclosure () async throws -> T,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #filePath,
    line: UInt = #line,
    _ errorHandler: (_ error: Error) -> Void = { _ in }
) async {
    do {
        _ = try await expression()
        XCTAssert(false, file: file, line: line)
    } catch {
        errorHandler(error)
    }
}
