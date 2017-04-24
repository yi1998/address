//
//  ViewController.m
//  zhou
//
//  Created by 卖女孩的小火柴 on 17/4/22.
//  Copyright © 2017年 卖女孩的小火柴. All rights reserved.
//


#import "ViewController.h"
#import "FMDatabase.h"


@interface ViewController()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
    _array = [[NSMutableArray alloc]init];
    for(int i=0;i<10;i++){
        NSString *str = [NSString stringWithFormat:@"%d",i];
    
        [_array addObject:str ];
        
        self.navigationController.toolbarHidden = NO;
        
        
    }
    
    
    
    [self.view addSubview:_tableView];
    
    [self setNavTitle];
    
    
    
    [_tableView  reloadData];
    
    [self creeatBtn];
    }




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _array.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellStr = @"cell";
    
    UITableViewCell*cell = [_tableView dequeueReusableCellWithIdentifier:cellStr];
    
    
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    
    
    cell.textLabel.text = _array[indexPath.row];
        
    return cell;
}





-(void)setNavTitle{
        [self.navigationItem setTitle:@"addressBook"];
    
    }
    
-(void)creeatBtn{
    _isEdit = NO;
    
    _btnEdit=[[UIBarButtonItem alloc]initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(pressEdit)];
    _btnFinish=[[UIBarButtonItem alloc]initWithTitle:@"Finish" style:UIBarButtonItemStylePlain target:self action:@selector(pressFinish)];
     _btnAdd = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(pressAdd)];
    _btnSearch = [[UIBarButtonItem alloc]initWithTitle:@"查找" style:UIBarButtonItemStylePlain target:self action:@selector(pressSearch)];
    
    btn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    self.navigationItem.rightBarButtonItem = _btnEdit;
    
    NSArray*arrayBtn = [NSArray arrayWithObjects:_btnAdd, btn , _btnSearch, nil];
    
    self.toolbarItems = arrayBtn;
}

-(void)pressEdit{
    _isEdit= YES;
    self.navigationItem.rightBarButtonItem = _btnFinish;
    [_tableView setEditing:YES];
    NSString* strPath = [NSHomeDirectory() stringByAppendingString:@"/Documents/db01.db"];
    
    _DB = [FMDatabase databaseWithPath:strPath];
    
    if(_DB != nil){
        NSLog(@"数据库创建成功！");
    }
    
    NSString * strCreateTable = @"create table if not exists per(id integer primary key, name varchar(20),number integer) ";
    
    BOOL isCreat = [_DB executeUpdate:strCreateTable];
    
    BOOL  isopen= [_DB open];
    
    BOOL  isclose=[_DB close];
    if(isopen){
        NSLog(@"数据库打开成功");
    }
    
    if(isclose){
        NSLog(@"数据库关闭成功");
    }
    
    if(isCreat == YES)
    {
        NSLog(@"创建数据表成功");
    }

}

-(void)pressAdd{
    NSString* strPath = [NSHomeDirectory() stringByAppendingString:@"/Documents/db01.db"];
    
    _DB = [FMDatabase databaseWithPath:strPath];
    
    
    if(_DB != nil){
        
        if([_DB open]){
            
            NSString* strInsert = @"insert into per values(1,'周子艺',186);";
            
            BOOL isok= [_DB executeUpdate:strInsert];
            
            if(isok == YES){
                
                NSLog(@"tianjiachengong");
                
                NSString* id1 = [[NSString alloc]initWithFormat:@"1" ];
                
                [_array addObject:id1];
                
                [_tableView reloadData];
                
            }
        }
    }
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger id2 = indexPath.row ;
    NSLog(@"%d",id2);
}

-(void)pressSearch{
    NSString* strPath = [NSHomeDirectory() stringByAppendingString:@"/Documents/db01.db"];
    
    _DB = [FMDatabase databaseWithPath:strPath];
    
    
    NSString* cha = @"select * from per ;";
    
    BOOL isOpen = [_DB open];
    
    if(isOpen){
        
        FMResultSet* result = [_DB executeQuery:cha];
        
        while([result next]){
            NSInteger perID = [result intForColumn:@"id"];
            
            NSString* perName = [result stringForColumn:@"name"];
            
            NSInteger perNumber = [result intForColumn:@"number"];
            
            NSLog(@"per id = %ld , name = %@ , number = %ld ",(long)perID,perName,(long)perNumber);
        }
    }
}


-(void)pressFinish{
    _isEdit=NO;
    self.navigationItem.rightBarButtonItem=_btnEdit;
    [_tableView setEditing:NO];
    
}

-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    [_array removeObjectAtIndex:indexPath.    row];
    NSString* strPath = [NSHomeDirectory() stringByAppendingString:@"/Documents/db01.db"];
    
    _DB = [FMDatabase databaseWithPath:strPath];
    
    if([_DB open]){
        
        NSString* strDelete = @"delete from per where id = 1" ;
        
        BOOL isdelete= [_DB executeUpdate:strDelete];
        
        if(isdelete){
            
            NSLog(@"shanchuchenggong");
        }
    }

    [_tableView reloadData];
}
/*-(void)add{
        AddViewController *VC = [[AddViewController alloc]init];
        [self.navigationController pushViewController:VC animated:YES];


-(void) pressBtn:(UIButton*) btn
{
    //chuangjian
    if(btn.tag == 100){
        NSString* strPath = [NSHomeDirectory() stringByAppendingString:@"/Documents/db01.db"];
        
        _DB = [FMDatabase databaseWithPath:strPath];
        
        if(_DB != nil){
            NSLog(@"数据库创建成功！");
        }
        
        NSString * strCreateTable = @"create table if not exists per(id integer primary key, name varchar(20),number integer) ";
        
        BOOL isCreat = [_DB executeUpdate:strCreateTable];
        
        BOOL  isopen= [_DB open];
        
        BOOL  isclose=[_DB close];
        if(isopen){
            NSLog(@"数据库打开成功");
        }
        
        if(isclose){
            NSLog(@"数据库关闭成功");
        }
        
            if(isCreat == YES)
        {
            NSLog(@"创建数据表成功");
        }
        
    }
    
    
    //tianjia
    else if(btn.tag == 101){
        
        NSString* strPath = [NSHomeDirectory() stringByAppendingString:@"/Documents/db01.db"];
        
        _DB = [FMDatabase databaseWithPath:strPath];
        
        
        if(_DB != nil){
            
            if([_DB open]){
                
                NSString* strInsert = @"insert into per values(1,'周子艺',186);";
                
                BOOL isok= [_DB executeUpdate:strInsert];
                
                if(isok == YES){
                    
                    NSLog(@"tianjiachengong");
                }
            }
        }
    }
    //shanchu
    else if(btn.tag == 102){
        NSString* strPath = [NSHomeDirectory() stringByAppendingString:@"/Documents/db01.db"];
        
        _DB = [FMDatabase databaseWithPath:strPath];
        
        if([_DB open]){
        
        NSString* strDelete = @"delete from per where id = 1" ;
        
        BOOL isdelete= [_DB executeUpdate:strDelete];

        if(isdelete){
            
            NSLog(@"shanchuchenggong");
        }
      }
    }
    else if(btn.tag == 103)
    {
        
        NSString* strPath = [NSHomeDirectory() stringByAppendingString:@"/Documents/db01.db"];
        
        _DB = [FMDatabase databaseWithPath:strPath];
        
        
        NSString* cha = @"select * from per ;";
        
        BOOL isOpen = [_DB open];
        
        if(isOpen){
            
            FMResultSet* result = [_DB executeQuery:cha];
            
            while([result next]){
                NSInteger perID = [result intForColumn:@"id"];
                
                NSString* perName = [result stringForColumn:@"name"];
                
                NSInteger perNumber = [result intForColumn:@"number"];
                
                NSLog(@"per id = %d , name = %@ , number = %d ",perID,perName,perNumber);
            }
        }
    }
}*/



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
