//
//  TNAlertView.m
//  BaseProject
//
//  Created by Tony on 2017/8/13.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import "TNAlertView.h"
#import "TNPopView.h"

@interface TNAlertView()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UITextField *inputView;
@property (nonatomic, strong) UIView *buttonView;
@property (nonatomic, assign) BOOL withKeyboard;
@property (nonatomic, strong) NSArray *actionItems;

@property (nonatomic, copy) TNAlertInputHandler inputHandler;

@property (nonatomic,strong) TNPopView *popView;

@end


@implementation TNAlertView

+ (instancetype)showWithInputTitle:(NSString*)title
                             detail:(NSString*)detail
                              items:(NSArray<TNAlertViewItem *> *)items
                        placeholder:(NSString*)inputPlaceholder
                            handler:(TNAlertInputHandler)inputHandler{
    TNAlertView *view = [[TNAlertView alloc]initWithInputTitle:title detail:detail items:items placeholder:inputPlaceholder handler:inputHandler];
    [view show];
    return view;
}


+  (instancetype)showWithTitle:(NSString*)title
                        detail:(NSString*)detail
                         items:(NSArray<TNAlertViewItem *> *)items{
    TNAlertView *view = [[TNAlertView alloc]initWithTitle:title detail:detail items:items];
    [view show];
    return view;
}

- (instancetype) initWithInputTitle:(NSString*)title
                             detail:(NSString*)detail
                              items:(NSArray<TNAlertViewItem *> *)items
                        placeholder:(NSString*)inputPlaceholder
                            handler:(TNAlertInputHandler)inputHandler{
    
    return [self initWithTitle:title detail:detail items:items inputPlaceholder:inputPlaceholder inputHandler:inputHandler];
}

- (instancetype) initWithTitle:(NSString*)title
                        detail:(NSString*)detail
                         items:(NSArray<TNAlertViewItem *> *)items{
    return [self initWithTitle:title detail:detail items:items inputPlaceholder:nil inputHandler:nil];
}



- (instancetype)initWithTitle:(NSString *)title
                       detail:(NSString *)detail
                        items:(NSArray<TNAlertViewItem *> *)items
                  inputPlaceholder:(NSString*)inputPlaceholder
                      inputHandler:(TNAlertInputHandler)inputHandler{
    if (self = [super init]) {
        
        CGFloat width          = 275.0f;
        CGFloat buttonHeight   = 50.0f;
        CGFloat innerMargin    = 25.0f;
        CGFloat cornerRadius   = 5.0f;
        
        CGFloat titleFontSize  = 18.0f;
        CGFloat detailFontSize = 14.0f;
        CGFloat buttonFontSize = 17.0f;
        
        UIColor *borderColor = tnHexColor(0xCCCCCCFF);
        UIColor *itemPressedColor = tnHexColor(0xEFEDE7FF);
        UIColor *itemNormalColor = tnHexColor(0x333333FF);
        UIColor *itemHighlightColor = tnHexColor(0xE76153FF);
        
        CGFloat borderWidth = tnSplitWidth;
        self.inputHandler = inputHandler;
        self.actionItems = items;
        self.withKeyboard = (inputHandler!=nil);
        
        self.layer.cornerRadius = cornerRadius;
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderWidth = borderWidth;
        self.layer.borderColor = borderColor.CGColor;
        
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(width);
        }];
        
        [self setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [self setContentHuggingPriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisVertical];
        
        MASViewAttribute *lastAttribute = self.mas_top;
        if ( title.length > 0 )
        {
            self.titleLabel = [UILabel new];
            [self addSubview:self.titleLabel];
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lastAttribute).offset(innerMargin);
                make.left.right.equalTo(self).insets(UIEdgeInsetsMake(0, innerMargin, 0, innerMargin));
            }];
            self.titleLabel.textColor = tnHexColor(0x333333FF);
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            self.titleLabel.font = [UIFont boldSystemFontOfSize:titleFontSize];
            self.titleLabel.numberOfLines = 0;
            self.titleLabel.backgroundColor = self.backgroundColor;
            self.titleLabel.text = title;
            
            lastAttribute = self.titleLabel.mas_bottom;
        }
        
        if ( detail.length > 0 )
        {
            self.detailLabel = [UILabel new];
            [self addSubview:self.detailLabel];
            [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lastAttribute).offset(5);
                make.left.right.equalTo(self).insets(UIEdgeInsetsMake(0, innerMargin, 0, innerMargin));
            }];
            self.detailLabel.textColor = tnHexColor(0x333333FF);
            self.detailLabel.textAlignment = NSTextAlignmentCenter;
            self.detailLabel.font = [UIFont systemFontOfSize:detailFontSize];
            self.detailLabel.numberOfLines = 0;
            self.detailLabel.backgroundColor = self.backgroundColor;
            self.detailLabel.text = detail;
            
            lastAttribute = self.detailLabel.mas_bottom;
        }
        
        if ( self.inputHandler )
        {
            self.inputView = [UITextField new];
            [self addSubview:self.inputView];
            [self.inputView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lastAttribute).offset(10);
                make.left.right.equalTo(self).insets(UIEdgeInsetsMake(0, innerMargin, 0, innerMargin));
                make.height.mas_equalTo(40);
            }];
            self.inputView.backgroundColor = self.backgroundColor;
            self.inputView.layer.borderWidth = borderWidth;
            self.inputView.layer.borderColor = borderColor.CGColor;
            self.inputView.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
            self.inputView.leftViewMode = UITextFieldViewModeAlways;
            self.inputView.clearButtonMode = UITextFieldViewModeWhileEditing;
            self.inputView.placeholder = inputPlaceholder;
            
            lastAttribute = self.inputView.mas_bottom;
        }
        
        self.buttonView = [UIView new];
        [self addSubview:self.buttonView];
        [self.buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lastAttribute).offset(innerMargin);
            make.left.right.equalTo(self);
        }];
        
        __block UIButton *firstButton = nil;
        __block UIButton *lastButton = nil;
        for ( NSInteger i = 0 ; i < items.count; ++i )
        {
            TNAlertViewItem *item = items[i];
            UIButton *btn = [[UIButton alloc]tn_buttonWithTarget:self action:@selector(actionButton:)];
            [self.buttonView addSubview:btn];
            btn.tag = i;
            

            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                
                if ( items.count <= 2 )
                {
                    make.top.bottom.equalTo(self.buttonView);
                    make.height.mas_equalTo(buttonHeight);
                    
                    if (!firstButton)
                    {
                        firstButton = btn;
                        make.left.equalTo(self.buttonView.mas_left).offset(-tnSplitWidth);
                    }
                    else
                    {
                        make.left.equalTo(lastButton.mas_right).offset(-tnSplitWidth);
                        make.width.equalTo(firstButton);
                    }
                }
                else
                {
                    make.left.right.equalTo(self.buttonView);
                    make.height.mas_equalTo(buttonHeight);
                    
                    if ( !firstButton )
                    {
                        firstButton = btn;
                        make.top.equalTo(self.buttonView.mas_top).offset(-tnSplitWidth);
                    }
                    else
                    {
                        make.top.equalTo(lastButton.mas_bottom).offset(-tnSplitWidth);
                        make.width.equalTo(firstButton);
                    }
                }
                lastButton = btn;
            }];
            
            
            [btn setBackgroundImage:[UIImage tn_creatImageWithColor:self.backgroundColor] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage tn_creatImageWithColor:itemPressedColor] forState:UIControlStateHighlighted];
            [btn setTitle:item.title forState:UIControlStateNormal];
            
            switch (item.style) {
                case TNAlertViewItemStyleNormal:
                case TNAlertViewItemStyleCancel:
                    [btn setTitleColor:itemNormalColor forState:UIControlStateNormal];
                    break;
                case TNAlertViewItemStyleDestructive:
                    [btn setTitleColor:itemHighlightColor forState:UIControlStateNormal];
                    break;
                    
                default:
                    break;
            }
            btn.layer.borderWidth = tnSplitWidth;
            btn.layer.borderColor = borderColor.CGColor;
            btn.titleLabel.font = tnSystemFont(buttonFontSize);
            
            
        }
        
        [lastButton mas_updateConstraints:^(MASConstraintMaker *make) {
            
            if ( items.count <= 2 )
            {
                make.right.equalTo(self.buttonView.mas_right).offset(tnSplitWidth);
            }
            else
            {
                make.bottom.equalTo(self.buttonView.mas_bottom).offset(tnSplitWidth);
            }
            
        }];
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.equalTo(self.buttonView.mas_bottom);
            
        }];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifyTextChange:) name:UITextFieldTextDidChangeNotification object:nil];
    }
    return self;
};


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}


- (void)actionButton:(UIButton*)btn
{
    TNAlertViewItem *item = self.actionItems[btn.tag];
    
    
    if ( self.withKeyboard && (btn.tag==1) )
    {
        if ( self.inputView.text.length > 0 )
        {
            [self hide];
        }
    }
    else
    {
        [self hide];
    }
    
    if (self.inputHandler && (btn.tag>0) && item.style!= TNAlertViewItemStyleCancel)
    {
        self.inputHandler(self.inputView.text);
    }
    else
    {
        if (item.handler)
        {
            item.handler();
        }
    }
}

- (void)notifyTextChange:(NSNotification *)n
{
    if ( self.maxInputLength == 0 )
    {
        return;
    }
    
    if ( n.object != self.inputView )
    {
        return;
    }
    
    UITextField *textField = self.inputView;
    
    NSString *toBeString = textField.text;
    
    UITextRange *selectedRange = [textField markedTextRange];
    //获取高亮部分
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if (!position) {
        if (toBeString.length > self.maxInputLength) {
            textField.text = [toBeString tn_truncateByCharLength:self.maxInputLength];
        }
    }
}

- (void)showKeyboard
{
    [self.inputView becomeFirstResponder];
}

- (void)hideKeyboard
{
    [self.inputView resignFirstResponder];
}

- (void)hide{
    [self.popView dismiss];
    if (self.withKeyboard) {
        [self hideKeyboard];
    }
}

- (void)show{
    self.popView = [TNPopView showPopViewWithContentView:self];
    self.popView.clickDismiss = NO;
    if (self.withKeyboard) {
        [self showKeyboard];
    }
}

@end





@interface TNAlertViewItem ()

@property (copy, nonatomic) NSString *title;
@property (nonatomic, assign) TNAlertViewItemStyle style;


@end

@implementation TNAlertViewItem

+ (instancetype)itemWithTitle:(NSString *)title style:(TNAlertViewItemStyle)style handler:(TNAlertViewItemHandler)handler{
    TNAlertViewItem *item = [[TNAlertViewItem alloc]init];
    item.title = title;
    item.style = style;
    item.handler = handler;
    return item;
}


@end
