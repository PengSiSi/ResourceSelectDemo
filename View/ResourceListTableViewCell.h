//
//  ResourceListTableViewCell.h
//  QianfengSchool
//
//  Created by AlicePan on 16/8/4.
//  Copyright © 2016年 Combanc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ResourceListTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *iconImgV;/**< 图标*/
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;/**< 标题*/
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;/**< 日期*/
@property (strong, nonatomic) IBOutlet UILabel *resourceTimeLabel;/**< 上传时间*/

@property (nonatomic, strong) id resourceListModel;/**< ResourceListFolderModel or ResourceListFileModel*/

@end
