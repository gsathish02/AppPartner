//
//  ChatViewController.m
//  iOSTest
//
//  Created by App Partner on 9/6/16.
//  Copyright © 2016 AppPartner. All rights reserved.
//

#import "ChatViewController.h"
#import "MenuViewController.h"
#import "ChatTableViewCell.h"
#import "ChatClient.h"

@interface ChatViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *chatTable;
@property (nonatomic, strong) ChatClient *client;
@property (nonatomic, strong) NSMutableArray *messages;

@end

@implementation ChatViewController

/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 * 1) Make the UI look like it does in the mock-up.
 *
 * 2) Using the following endpoint, fetch chat data
 *    URL: http://dev3.apppartner.com/AppPartnerDeveloperTest/scripts/chat_log.php
 *
 * 3) Parse the chat data using 'Message' model
 *
 **/

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.messages = [[NSMutableArray alloc] init];
    [self configureTable:self.chatTable];
    self.title = @"Chat";
    self.chatTable.estimatedRowHeight = 50;
    self.chatTable.rowHeight = UITableViewAutomaticDimension;
    [self setUpChat];
    self.chatTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.chatTable reloadData];
}
-(void)setUpChat{
    ChatClient *chatCl = [[ChatClient alloc]init];
    [chatCl fetchChatData:^(id responseObject, NSError *error) {
        if (responseObject) {
            NSArray * dataArray = [responseObject objectForKey:@"data"];
            for (int i = 0; i<dataArray.count; i++){
                NSDictionary *separatedData = [dataArray objectAtIndex:i];
                [self.messages addObject:[[Message alloc]initWithDictionary:separatedData]];
            }
            [self.chatTable reloadData];
        }
    }];

}
- (void)configureTable:(UITableView *)tableView
{
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerNib:[UINib nibWithNibName:@"ChatTableViewCell" bundle:nil] forCellReuseIdentifier:@"ChatTableViewCell"];
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}


#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatTableViewCell *cell = nil;
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ChatTableViewCell" owner:self options:nil];
        cell = (ChatTableViewCell *)[nib objectAtIndex:0];
    }
    [cell setCellData:self.messages[indexPath.row]];
    [cell.body sizeToFit];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messages.count;
}


//#pragma mark - UITableViewDelegate
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//  // return UITableViewAutomaticDimension;
//    return 89.5f;
//}

@end
