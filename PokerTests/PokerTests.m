//
//  PokerTests.m
//  PokerTests
//
//  Created by Jake Goodman on 6/4/18.
//  Copyright © 2018 Jake Martin. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Card.h"
#import "Hand.h"
#import "Deck.h"
#import "PokerGame.h"

@interface PokerTests : XCTestCase

@end

@implementation PokerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testCreateDeck {
    Deck *deck = [[Deck alloc] init];
    XCTAssertEqual(deck.numberCardsRemaining, 52);
}

- (void)testDeckCanGetHandTrue {
    Deck *deck = [[Deck alloc] init];
    XCTAssertEqual([deck canGetHandOfSize:5], true);
}

- (void)test3_getHandDecrementsCount {
    Deck *deck = [[Deck alloc] init];
    [deck handOfSize:5];
    XCTAssertEqual(deck.numberCardsRemaining, 47);
}

- (void)test4_canGetHandFalse {
    Deck *deck = [[Deck alloc] init];
    XCTAssertEqual([deck canGetHandOfSize:53], false);
}

- (void)test5_handHasPair {
    Card *card1 = [[Card alloc] initWithRank:2 suit:Spades];
    Card *card2 = [[Card alloc] initWithRank:5 suit:Hearts];
    Card *card3 = [[Card alloc] initWithRank:7 suit:Diamonds];
    Card *card4 = [[Card alloc] initWithRank:6 suit:Spades];
    Card *card5 = [[Card alloc] initWithRank:2 suit:Hearts];
    
    NSMutableArray<Card*>* cards = (NSMutableArray<Card*>*)@[card1, card2, card3, card4, card5];
    
    Hand *hand = [[Hand alloc] initWithCards:cards];
    
    XCTAssertEqual([hand hasPair], true);
}

- (void)test6_handHasNoPair {
    Card *card1 = [[Card alloc] initWithRank:2 suit:Spades];
    Card *card2 = [[Card alloc] initWithRank:5 suit:Hearts];
    Card *card3 = [[Card alloc] initWithRank:7 suit:Diamonds];
    Card *card4 = [[Card alloc] initWithRank:6 suit:Spades];
    Card *card5 = [[Card alloc] initWithRank:9 suit:Hearts];
    
    NSMutableArray<Card*>* cards = (NSMutableArray<Card*>*)@[card1, card2, card3, card4, card5];
    
    Hand *hand = [[Hand alloc] initWithCards:cards];
    
    XCTAssertEqual([hand hasPair], false);
}

- (void)test7_handHasOrderedStraight {
    Card *card1 = [[Card alloc] initWithRank:2 suit:Spades];
    Card *card2 = [[Card alloc] initWithRank:3 suit:Hearts];
    Card *card3 = [[Card alloc] initWithRank:4 suit:Diamonds];
    Card *card4 = [[Card alloc] initWithRank:5 suit:Spades];
    Card *card5 = [[Card alloc] initWithRank:6 suit:Hearts];
    
    NSMutableArray<Card*>* cards = (NSMutableArray<Card*>*)@[card1, card2, card3, card4, card5];
    
    Hand *hand = [[Hand alloc] initWithCards:cards];
    
    XCTAssertEqual([hand hasStraight], true);
}

- (void)test8_handHasUnorderedStraight {
    Card *card1 = [[Card alloc] initWithRank:6 suit:Spades];
    Card *card2 = [[Card alloc] initWithRank:2 suit:Hearts];
    Card *card3 = [[Card alloc] initWithRank:4 suit:Diamonds];
    Card *card4 = [[Card alloc] initWithRank:3 suit:Spades];
    Card *card5 = [[Card alloc] initWithRank:5 suit:Hearts];
    
    NSMutableArray<Card*>* cards = (NSMutableArray<Card*>*)@[card1, card2, card3, card4, card5];
    
    Hand *hand = [[Hand alloc] initWithCards:cards];
    
    XCTAssertEqual([hand hasStraight], true);
}

- (void)test6_handHasNoStraight {
    Card *card1 = [[Card alloc] initWithRank:2 suit:Spades];
    Card *card2 = [[Card alloc] initWithRank:5 suit:Hearts];
    Card *card3 = [[Card alloc] initWithRank:7 suit:Diamonds];
    Card *card4 = [[Card alloc] initWithRank:6 suit:Spades];
    Card *card5 = [[Card alloc] initWithRank:9 suit:Hearts];
    
    NSMutableArray<Card*>* cards = (NSMutableArray<Card*>*)@[card1, card2, card3, card4, card5];
    
    Hand *hand = [[Hand alloc] initWithCards:cards];
    
    XCTAssertEqual([hand hasStraight], false);
}

- (void)test_pokerGameHasNextHandTrue {
    PokerGame* game = [[PokerGame alloc] init];
    XCTAssertEqual([game hasNextHand], true);
}

- (void)test_pokerGameDealFirstHand {
    PokerGame* game = [[PokerGame alloc] init];
    [game dealNextHand];
    XCTAssertEqual([game currentHand].size, 5);
}

- (void)test_pokerGameHasNextHandFalse {
    PokerGame* game = [[PokerGame alloc] init];
    for(int i=0; i<10; i++){
        [game dealNextHand];
    }
    //Two cards remaining
    XCTAssertEqual([game hasNextHand], false);
}

- (void)test_pokerGameCanReplaceNumberOfCardsTrue {
    PokerGame* game = [[PokerGame alloc] init];
    XCTAssertEqual([game canReplaceNumberOfCards:5], true);
}

- (void)test_pokerGameCanReplaceNumberOfCardsFalse {
    PokerGame* game = [[PokerGame alloc] init];
    XCTAssertEqual([game canReplaceNumberOfCards:100], false);
}

- (void)test_pokerGameCanReplaceNumberOfCardsFalse2 {
    PokerGame* game = [[PokerGame alloc] init];

    for(int i=0; i<10; i++){
        [game dealNextHand];
    }
    //Two cards remaining
    XCTAssertEqual([game canReplaceNumberOfCards:3], false);
}


- (void)test_pokerGameAddScore {
    PokerGame* game = [[PokerGame alloc] init];
    [game addPointsToScore:100];
    XCTAssertEqual(game.score, 100);
}




@end
