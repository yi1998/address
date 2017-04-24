//
//  ViewController.h
//  zhou
//
//  Created by 卖女孩的小火柴 on 17/4/22.
//  Copyright © 2017年 卖女孩的小火柴. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDatabase.h"
@interface ViewController : UIViewController
<
UITableViewDelegate,
UITableViewDataSource>

{
    FMDatabase * _DB;
    UITableView* _tableView;
    UIBarButtonItem* _btnEdit;
    UIBarButtonItem* _btnFinish;
    NSMutableArray* _array;
    UIBarButtonItem* _btnAdd;
    UITabBarItem* _btnSearch;
    UIBarButtonItem* btn;
    BOOL _isEdit;
}

@end

