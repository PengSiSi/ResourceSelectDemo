//
//  ResourceListTableViewCell.m
//  QianfengSchool
//
//  Created by AlicePan on 16/8/4.
//  Copyright © 2016年 Combanc. All rights reserved.
//

#import "ResourceListTableViewCell.h"
#import "ResourceListModel.h"
#import "ResourceFileModel.h"

@implementation ResourceListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setResourceListModel:(id)resourceListModel {
    if ([resourceListModel isKindOfClass:[ResourceListModel class]]) {
        ResourceListModel *folderModel = (ResourceListModel *)resourceListModel;
        _titleLabel.text = folderModel.folderName;
        _dateLabel.text = folderModel.date;
        if ([folderModel.date containsString:@"."]) {
            _dateLabel.text = [[folderModel.date componentsSeparatedByString:@"."] firstObject];
        }
        _resourceTimeLabel.text = @"";
        _iconImgV.image = [UIImage imageNamed:@"virtualroom_resource_file"];
    }
}


@end
