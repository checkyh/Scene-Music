//
//  ChorusSongsViewController.m
//  chorusTest
//
//  Created by Deepkanwal Plaha on 2/8/2014.
//  Copyright (c) 2014 Deepkanwal Plaha. All rights reserved.
//

#import "ChorusSongsViewController.h"
#import "ChorusIndexSectionHeader.h"
#import "ChorusSongsCell.h"
#import "ChorusAppDelegate.h"
#import <MediaPlayer/MediaPlayer.h>

NSString *SongCellClassName = @"ChorusSongsCell";

@interface ChorusSongsViewController ()
@property (strong, nonatomic) NSCache *imagesCache;
@end

@implementation ChorusSongsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:SongCellClassName bundle:nil] forCellReuseIdentifier:SongCellClassName];
    
    ChorusAppDelegate *temp=[[UIApplication sharedApplication]delegate];
    [temp.corePlayer assignDynamicTableView:self.tableView];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)populateDataSource
{
    ChorusAppDelegate *temp=[[UIApplication sharedApplication]delegate];
    MPMediaItemCollection *collection=[temp.corePlayer getCollection];
    self.itemsArray = [collection items];
}
#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.itemsArray.count;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ChorusIndexSectionHeader *sectionHeader = [[[NSBundle mainBundle] loadNibNamed:@"ChorusIndexSectionHeader" owner:nil options:nil] lastObject];
    [sectionHeader updateWithText:@"List"];
    return sectionHeader;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChorusSongsCell *cell = [self.tableView dequeueReusableCellWithIdentifier:SongCellClassName forIndexPath:indexPath];
    
    NSInteger index = indexPath.row;
    
    if (index < self.itemsArray.count) {
        MPMediaItem *mediaItem = [self.itemsArray objectAtIndex:index];
        [cell updateWithMediaItem:mediaItem];
        [cell updateForIndex:indexPath.row];
    } else {
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kChorusSongsCellHeight;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
     ChorusAppDelegate *temp=[[UIApplication sharedApplication]delegate];
    [temp.corePlayer playWithIndex:indexPath.row];
}

@end
