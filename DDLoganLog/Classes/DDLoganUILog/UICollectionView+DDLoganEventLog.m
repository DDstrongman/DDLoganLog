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
    [NSObject loganInit];
    [self swizzlingMethodWithOriginalSel:@selector(setDelegate:)
                             swizzledSel:@selector(dd_collectionview_setDelegate:)];
}

- (void)dd_collectionview_setDelegate:(id<UICollectionViewDelegate>)delegate {
    [self dd_collectionview_setDelegate:delegate];
    
    dd_exchangeMethod([delegate class], @selector(collectionView:didSelectItemAtIndexPath:), [self class], @selector(dd_replace_collectionView:didSelectItemAtIndexPath:), @selector(dd_add_collectionView:didSelectItemAtIndexPath:));
}

- (void)dd_replace_collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DDLoganLogModel *model = [DDLoganLogModel new];
    model.className = NSStringFromClass([self class]);
    model.indexPath = [NSString stringWithFormat:@"section=%ld,row=%ld",indexPath.section,indexPath.row] ;
    model.des = @"collectionView didSelectItemAtIndexPath";
    model.frame = NSStringFromCGRect(collectionView.frame);
    logan(DDEventCollectionviewDidSelect, [@"" objectToJson:model.mj_keyValues]);
    [self dd_replace_collectionView:collectionView didSelectItemAtIndexPath:indexPath];
}

- (void)dd_add_collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DDLoganLogModel *model = [DDLoganLogModel new];
    model.className = NSStringFromClass([self class]);
    model.indexPath = [NSString stringWithFormat:@"section=%ld,row=%ld",indexPath.section,indexPath.row] ;
    model.des = @"collectionView didSelectItemAtIndexPath";
    model.frame = NSStringFromCGRect(collectionView.frame);
    logan(DDEventCollectionviewDidSelect, [@"" objectToJson:model.mj_keyValues]);
}

@end
