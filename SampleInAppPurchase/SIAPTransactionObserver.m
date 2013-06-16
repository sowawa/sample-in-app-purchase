//
//  SIAPTransactionObserver.m
//  SampleInAppPurchase
//

#import "SIAPTransactionObserver.h"

static SIAPTransactionObserver* _sharedObject = nil;

@implementation SIAPTransactionObserver

// シングルトンインスタンス取得用のメソッド
+ (id)sharedObject {
    @synchronized(self) {
        if (_sharedObject == nil) {
            _sharedObject = [[self alloc] init];
        }
    }
    return _sharedObject;
}

// SKPaymentTransactionObserverプロトコルの必須メソッド
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions {
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStateRestored:
                break;
                
            case SKPaymentTransactionStatePurchasing:
                break;
                
            case SKPaymentTransactionStateFailed:
                [[NSNotificationCenter defaultCenter] postNotificationName:@"TransactionFailed" object:transaction];
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
                
            case SKPaymentTransactionStatePurchased:
                [[NSNotificationCenter defaultCenter] postNotificationName:@"TransactionSucceeded" object:transaction];
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
                
            default:
                break;
        }
    }
}

@end
