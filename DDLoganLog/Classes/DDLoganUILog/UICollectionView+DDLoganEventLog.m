//
//  UICollectionView+DDLoganEventLog.m
//  ThousandsWords
//
//  Created by DDLi on 2019/8/2.
//  Copyright © 2019 LittleLights. All rights reserved.
//

#import "UICollectionView+DDLoganEventLog.h"
#import "NSObject+DDSwizzlingMethods.h"

@implementation UICollectionView (DDLoganEventLog)

+ (void)load {
    [self swizzlingMethodWithOriginalSel:@selector(setDelegate:)
                             swizzledSel:@selector(dd_collectionview_setDelegate:)];
}

- (void)dd_collectionview_setDelegate:(id<UICollectionViewDelegate>)delegate {
    [self dd_collectionview_setDelegate:delegate];
    
    dd_exchangeMethod([delegate class], @selector(collectionView:didSelectItemAtIndexPath:), [self class], @selector(dd_replace_collectionView:didSelectItemAtIndexPath:), @selector(dd_add_collectionView:didSelectItemAtIndexPath:));
}

- (void)dd_replace_collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    logan(DDEventCollectionviewDidSelect, [NSString stringWithFormat:@"collectionView select section=%ld,row=%ld,frame.x=%f,frame.y=%f",indexPath.section,indexPath.row,collectionView.frame.origin.x,collectionView.frame.origin.y]);
    [self dd_replace_collectionView:collectionView didSelectItemAtIndexPath:indexPath];
}

- (void)dd_add_collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    logan(DDEventCollectionviewDidSelect, [NSString stringWithFormat:@"collectionView select section=%ld,row=%ld,frame.x=%f,frame.y=%f",indexPath.section,indexPath.row,collectionView.frame.origin.x,collectionView.frame.origin.y]);
    [self dd_add_collectionView:collectionView didSelectItemAtIndexPath:indexPath];
}

@end
