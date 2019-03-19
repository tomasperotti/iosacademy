//
//  APIMarvelTests.swift
//  SuperheroesTests
//
//  Created by Tomas Mateo Perotti on 19/03/2019.
//  Copyright © 2019 Tomas Mateo Perotti. All rights reserved.
//

import XCTest
@testable import Superheroes

class APIMarvelTests: XCTestCase {

    func testExample () {
        let helloWorld = "Hello World"
        XCTAssertEqual(helloWorld, "Hello World")
    }
    
    /*
     Use this function to test getHeroes method from CharacterManager.
     */
    func testGetHeroes() {
        
        let exp = self.expectation(description: "Test passed")
        let characterManager = CharacterManager()
        
        characterManager.getHeroes { (characterList) in
            XCTAssertNotNil(characterList)
            XCTAssertFalse(characterList.isEmpty, "Correcto: La lista no es vacia.")
            exp.fulfill()
        }
        
        self.wait(for: [exp], timeout: 5)
        
    }
    
    func testGetAllComicsFromAPI() {
        
        let exp = self.expectation(description: "Test passed")
        
        // Try to obtain all comics from API
        ComicManager.getComicsFromAPI { (comicList) in
            XCTAssertNotNil(comicList)
            XCTAssertFalse(comicList.isEmpty, "List should not be empty.")
            
            exp.fulfill()
        }
        
        self.wait(for: [exp], timeout: 5)

    }
    
    /**
     Try to obtain all comics from a certain character ID with a random ID that not belongs to a particular character
     */
    
    func testGetComicFromAPIByIDNotFound (){

        let exp = self.expectation(description: "Test passed")
        
        ComicManager.getComicsFromAPI(heroID: 1) { (comicList) in
            print(comicList)
            XCTAssertNotNil(comicList)
            XCTAssertTrue(comicList.isEmpty, "List should be empty.")
            exp.fulfill()
        }
 
        self.wait(for: [exp], timeout: 5)
    }
    /**
     Try to obtain all comics from a certain character ID that belongs to a particular character
     */
    func testGetComicFromAPIByExistingID (){
        
        let exp = self.expectation(description: "Test passed")
        // Get comics from a certain character with an existing ID like 3-D Man 1011334
        
        ComicManager.getComicsFromAPI(heroID: 1011334) { (comicList) in
            print(comicList)
            XCTAssertNotNil(comicList)
            XCTAssertFalse(comicList.isEmpty, "List should not be empty.")
            exp.fulfill()
        }
        self.wait(for: [exp], timeout: 5)
        
    }
    
    

}
