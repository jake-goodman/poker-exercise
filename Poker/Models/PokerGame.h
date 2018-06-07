//
//  PokerGame.h
//  Poker
//
//  Created by Jake Goodman on 6/5/18.
//  Copyright © 2018 Jake Martin. All rights reserved.
//

#ifndef PokerGame_h
#define PokerGame_h

@interface PokerGame: NSObject
enum
{
    POKER_HAND_SIZE_CONST = 5
};

typedef NS_ENUM(NSInteger, GameState) {
    START,
    DEAL,
    GO,
    DONE
};


@property (nonatomic, readonly) Hand* currentHand;
@property (readonly) int score;
@property (nonatomic) GameState state;

-(void)addPointsToScore: (int) newPoints;

-(Boolean) hasNextHand;
-(void) dealNextHand;

- (Boolean) canReplaceNumberOfCards: (NSInteger) numCards;
-(void) replaceCardsAtIndices: (NSArray *) indicies;

@end

#endif /* PokerGame_h */
