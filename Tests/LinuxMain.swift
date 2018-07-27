import XCTest

import ExtraEncodableTests

var tests = [XCTestCaseEntry]()
tests += ExtraEncodableTests.allTests()
XCTMain(tests)