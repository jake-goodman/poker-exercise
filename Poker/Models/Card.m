//
//  Card.m
//  Poker
//
//  Created by Jake Goodman on 6/4/18.
//  Copyright © 2018 Jake Martin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@implementation Card

- (instancetype)initWithRank:(Rank)rank suit:(Suit)suit
{
    self = [super init];
    if (self) {
        _rank = rank;
        _suit = suit;
    }
    return self;
    
}

+ (NSString *)stringForRank:(Rank)rank
{
    switch(rank){
        case Ace:
            return @"A";
        case Jack:
            return @"J";
        case Queen:
            return @"Q";
        case King:
            return @"K";
        default:
            return [@((NSInteger)rank) stringValue];
    }
}

+ (NSString *)imagePathForSuit:(Suit)suit
{
    switch(suit){
        case Spades:
            return @"spade";
        case Clubs:
            return @"club";
        case Hearts:
            return @"heart";
        case Diamonds:
            return @"diamond";
    }
}

@end
