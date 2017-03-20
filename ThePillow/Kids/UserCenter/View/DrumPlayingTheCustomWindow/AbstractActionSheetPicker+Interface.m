//
//  XKPEActionSheetPicker.m
//  PestatePatient
//
//  Created by YJunxiao on 16/1/6.
//  Copyright © 2016年 袁俊晓. All rights reserved.
//

#import "AbstractActionSheetPicker+Interface.h"

@implementation AbstractActionSheetPicker (Interface)

- (void)customizeInterface{
    self.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIColor blackColor], NSForegroundColorAttributeName,
                                [UIFont systemFontOfSize:16], NSFontAttributeName, nil];
    UIButton *doneBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 25)];
    [doneBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
    [doneBtn setTitle:NSLocalizedString(@"replace_weight_fragment_yes",nil) forState:UIControlStateNormal];
    [doneBtn setTitleColor:RGB(77, 207, 199) forState:UIControlStateNormal];
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithCustomView:doneBtn];
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 25)];
    [cancelBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
    [cancelBtn setTitle:NSLocalizedString(@"can_you_concern_device_fragment_cancel",nil) forState:UIControlStateNormal];
    [cancelBtn setTitleColor:RGB(138, 138, 138) forState:UIControlStateNormal];
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithCustomView:cancelBtn];
    [self setDoneButton:doneItem];
    [self setCancelButton:cancelItem];
}

@end
