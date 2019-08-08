//
//  UITableView+DDLoganEventLog.m
//  ThousandsWords
//
//  Created by DDLi on 2019/8/1.
//  Copyright © 2019 LittleLights. All rights reserved.
//

#import "UITableView+DDLoganEventLog.h"

#import "NSObject+DDSwizzlingMethods.h"

@implementation UITableView (DDLoganEventLog)

+ (void)load {
    [self swizzlingMethodWithOriginalSel:@selector(setDelegate:)
                             swizzledSel:@selector(dd_tableview_setDelegate:)];
}

- (void)dd_tableview_setDelegate:(id<UITableViewDelegate>)delegate {
    [self dd_tableview_setDelegate:delegate];
    
    dd_exchangeMethod([delegate class], @selector(tableView:didSelectRowAtIndexPath:), [self class], @selector(dd_replace_tableView:didSelectRowAtIndexPath:), @selector(dd_add_tableView:didSelectRowAtIndexPath:));
}

- (void)dd_replace_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    logan(DDEventTableviewDidSelect, [NSString stringWithFormat:@"tableview select section=%ld,row=%ld,frame.x=%f,frame.y=%f",indexPath.section,indexPath.row,tableView.frame.origin.x,tableView.frame.origin.y]);
    [self dd_replace_tableView:tableView didSelectRowAtIndexPath:indexPath];
}

- (void)dd_add_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    logan(DDEventTableviewDidSelect, [NSString stringWithFormat:@"tableview select section=%ld,row=%ld,frame.x=%f,frame.y=%f",indexPath.section,indexPath.row,tableView.frame.origin.x,tableView.frame.origin.y]);
}

@end
