//
//  OpenSubjectView.m
//  PsychologistIOS
//
//  Created by Viktor on 05.04.16.
//  Copyright © 2016 KiviLab. All rights reserved.
//

#import "OpenSubjectView.h"
#import "UIColor+HexColor.h"
#import "Macros.h"

@implementation OpenSubjectView
{
    UIScrollView * mainScrollView;
    CGFloat selfHeight;
    UITextView * textViewText;
    UIButton * buttonHeight;
    BOOL mainAnim;
    
    CGFloat countFor;  
}

- (instancetype)initWithView: (UIView*) view andArray: (NSMutableArray*) array
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height - 64);
        mainAnim = YES;
        selfHeight = view.frame.size.height - 64;

#pragma mark - Chat View
        
        //Вью чата--------------------------------------------------------------------
        UIView * viewChat = [[UIView alloc] initWithFrame:CGRectMake(0, 368, self.frame.size.width, self.frame.size.height - 368)];
        
        for (NSInteger i = array.count; i > (array.count - 3); i--) {
            NSDictionary * dictChat = [array objectAtIndex:i - 1];
            if ([[dictChat objectForKey:@"Users"] isEqualToString:@"Пользователь 1"]) {
                // Имя пользователя---------------
                UILabel * labelUser = [[UILabel alloc] initWithFrame:CGRectMake(viewChat.frame.size.width - 32 - 73, 8 + countFor, 88, 12)];
                labelUser.textColor = [UIColor colorWithHexString:@"8e8e93"];
                labelUser.font = [UIFont fontWithName:FONTLITE size:12];
                labelUser.text = [dictChat objectForKey:@"Users"];
                [viewChat addSubview:labelUser];
                
                //Текст сообщения------------------
                UILabel * labelText = [[UILabel alloc] initWithFrame:CGRectMake(viewChat.frame.size.width - 24, 32 + countFor, 300, 12)];
                labelText.numberOfLines = 0;
                labelText.textColor = [UIColor whiteColor];
                labelText.text = [dictChat objectForKey:@"Message"];
                labelText.font = [UIFont fontWithName:FONTLITE size:18];
                [labelText sizeToFit];
                labelText.frame = CGRectMake((viewChat.frame.size.width - labelText.frame.size.width) - 32, labelText.frame.origin.y, labelText.frame.size.width, labelText.frame.size.height);
                
                //Вью сообщения----------------------
                UIView * viewMessage = [[UIView alloc] initWithFrame:CGRectMake(labelText.frame.origin.x - 10, labelText.frame.origin.y - 5, labelText.frame.size.width + 20, labelText.frame.size.height + 10)];
                viewMessage.backgroundColor = [UIColor colorWithHexString:@"f69679"];
                viewMessage.layer.cornerRadius = 7.f;
                [viewChat addSubview:viewMessage];
                [viewChat addSubview:labelText];
                
                //Создаем хвостик--------------------
                UIImageView * bubbleView = [[UIImageView alloc] initWithFrame:CGRectMake(viewMessage.frame.origin.x + viewMessage.frame.size.width - 9, viewMessage.frame.origin.y + viewMessage.frame.size.height - 7, 16, 8)];
                bubbleView.image = [UIImage imageNamed:@"bubble.png"];
                [viewChat addSubview:bubbleView];
                
                //Лейбл даты-----------------------
                UILabel * labelData = [[UILabel alloc] initWithFrame:CGRectMake(viewChat.frame.size.width - 32 - 40, viewMessage.frame.origin.y + viewMessage.frame.size.height + 5, 40, 12)];
                labelData.textColor = [UIColor colorWithHexString:@"8e8e93"];
                labelData.font = [UIFont fontWithName:FONTLITE size:12];
                labelData.text = [dictChat objectForKey:@"Data"];
                [labelData sizeToFit];
                labelData.frame = CGRectMake(viewChat.frame.size.width - 24 - labelData.frame.size.width, labelData.frame.origin.y, labelData.frame.size.width, labelData.frame.size.height);
                [viewChat addSubview:labelData];
                
                countFor += viewMessage.frame.size.height + 30;

            } else {
                // Имя пользователя---------------
                UILabel * labelUser = [[UILabel alloc] initWithFrame:CGRectMake(32, 8 + countFor, 88, 12)];
                labelUser.textColor = [UIColor colorWithHexString:@"8e8e93"];
                labelUser.font = [UIFont fontWithName:FONTLITE size:12];
                labelUser.text = [dictChat objectForKey:@"Users"];
                [viewChat addSubview:labelUser];
                
                UILabel * labelText = [[UILabel alloc] initWithFrame:CGRectMake(42, 32 + countFor, 40, 12)];
                labelText.text = [dictChat objectForKey:@"Message"];
                labelText.font = [UIFont fontWithName:FONTLITE size:18];
                [labelText sizeToFit];
                
                //Вью Сообщения---------------------
                UIView * viewMessage = [[UIView alloc] initWithFrame:CGRectMake(labelText.frame.origin.x - 10, labelText.frame.origin.y - 5, labelText.frame.size.width + 20, labelText.frame.size.height + 10)];
                viewMessage.backgroundColor = [UIColor colorWithHexString:@"e5e5ea"];
                viewMessage.layer.cornerRadius = 7.f;
                [viewChat addSubview:viewMessage];
                [viewChat addSubview:labelText];
                
                //Создаем хвостик------------------
                UIImageView * bubbleView = [[UIImageView alloc] initWithFrame:CGRectMake(32 - 7, viewMessage.frame.origin.y + viewMessage.frame.size.height - 7, 16, 8)];
                bubbleView.image = [UIImage imageNamed:@"bubble - gray.png"];
                [viewChat addSubview:bubbleView];
                
                //Лейбл даты-----------------------
                UILabel * labelData = [[UILabel alloc] initWithFrame:CGRectMake(32, viewMessage.frame.origin.y + viewMessage.frame.size.height + 5, 40, 12)];
                labelData.textColor = [UIColor colorWithHexString:@"8e8e93"];
                labelData.font = [UIFont fontWithName:FONTLITE size:12];
                labelData.text = [dictChat objectForKey:@"Data"];
                [viewChat addSubview:labelData];
                
                countFor += viewMessage.frame.size.height + 30;
                
            }
        }
        
        //Кнопка обсудить---------------------------
        UIButton * buttonPush = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonPush.frame = CGRectMake(viewChat.frame.size.width / 2 - 168, 250, 336, 48);
        buttonPush.backgroundColor = [UIColor colorWithHexString:@"e54444"];
        buttonPush.layer.cornerRadius = 24;
        [buttonPush setTitle:@"ОБСУДИТЬ" forState:UIControlStateNormal];
        [buttonPush setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        buttonPush.titleLabel.font = [UIFont fontWithName:FONTLITE size:16];
        [buttonPush addTarget:self action:@selector(buttonPushAction) forControlEvents:UIControlEventTouchUpInside];
        [viewChat addSubview:buttonPush];

        [self addSubview:viewChat];
        
#pragma mark - MainView
        
        NSString * stringText = @"Король Вариан Ринн внезапно пробудился от глубокого сна. Он неподвижно стоял в сумраке комнаты, прислушиваясь к негромкой капели, эхо которой отражалось от стен Крепости Штормграда. Вариана охватил ужас, потому что этот звук был ему знаком. \nОн осторожно подошел к двери и прижал ухо к полированным дубовым доскам. Ничего. Ни движения. Ни звука. Словно издалека донесся приглушенный шум толпы, выкрикивающей приветствия за стенами замка. Неужели я проспал церемонию?\nИ снова послышался странный звук капающей воды, на этот раз отражающийся от ледяного пола. Звук был четким и хорошо различимым. Вариан медленно открыл дверь и начал вглядываться в коридор. Там было темно и тихо. Даже факелы мерцали холодным огнем, который гас, едва вспыхнув. Вариан всегда отличался сдержанностью, но тут он почувствовал, как у него засосало под ложечкой: чувство старое или новое? Или просто давно забытое? Больше всего оно походило на детский... страх?\nКороль немедленно отбросил эту мысль. Его звали Ло'Гош, Призрачный Волк. Он был гладиатором, который вселял страх в сердца врагов и даже друзей. И все же Вариан не мог избавиться от первобытного чувства тревоги и опасности, овладевшего его разумом.\nВыйдя в коридор, Вариан обратил внимание, что на обычных местах не было стражей. Неужели все заняты подготовкой ко Дню памяти? Или случилось что-то страшное?\nВариан осторожно пробрался в неосвещенный коридор и вошел в просторный тронный зал Крепости Штормграда. Король знал тут все до последнего камня, но сейчас помещение с высокими стенами казалось иным — больше, темнее и совсем пустым. С потолка свешивались знамена. На каждом из ярких полотнищ была вышита золотом львиная голова — герб, выражавший гордость и силу великой нации Штормграда.\nЗагрузить в высоком разрешении Из темноты до Вариана донесся приглушенный крик, а затем звуки ударов. Он опустил взгляд и увидел кровавый след, тянущийся к центру зала. Там он едва мог различить две фигуры, яростно бившихся друг с другом. Глаза Вариана привыкли к темноте, и он разглядел израненного, окровавленного мужчину на коленях, над которым возвышался массивный женский силуэт.Из темноты до Вариана донесся приглушенный крик, а затем звуки ударов. Он опустил взгляд и увидел кровавый след, тянущийся к центру зала. Там он едва мог различить две фигуры, яростно бившихся друг с другом. Глаза Вариана привыкли к темноте, и он разглядел израненного, окровавленного мужчину на коленях, над которым возвышался массивный женский силуэт.\nВариан отлично его знал. Даже в темноте он выдавал жестокость и изощренность натуры его обладательницы. Это была Гарона Полуорчиха, наполовину дреней, наполовину орк, — убийца, воспитанница Гул'дана, который славился извращенностью своего ума.\nВариан застыл, не веря своим глазам. Свежая кровь тем временем стекала к острию кинжала Гароны и капала на пол, где на холодном мраморе расцветал кровавый цветок. Король внезапно все понял. Броня. Королевские одеяния. Лежащий на полу мужчина был его отцом, королем Ллейном!\nГарона сквозь слезы посмотрела на Вариана, и ее лицо исказила странная, самодовольная ухмылка. Затем она быстро нанесла удар своим кинжалом. Сталь сверкнула в темноте и погрузилась в плоть коленопреклоненного короля.\n— Нет! — закричал Вариан и бросился к отцу, проскальзывая на окровавленном полу. Он прижал к себе безжизненное тело, а Гарона тем временем растворилась во тьме.\n— Отец, \n— звал Вариан, укачивая Ллейна.\nЛицо короля исказила гримаса боли, и из приоткрытых губ потекла кровь. Сделав предсмертный вздох, король успел произнести несколько слов: — Такова судьба всех королей нашей династии...\nГлаза Ллейна закатились, а рот открылся, придавая лицу жуткое выражение. В глубине его горла послышался шорох хитина. Вариан хотел закрыть отцу глаза, но не смог. В разверзнутом рту мертвого короля что-то закопошилось, мерцая и извиваясь в неверном свете сумерек.\nВнезапно из нутра короля изверглось целое полчище личинок — тысячи и тысячи извивающихся червей облепили пепельно-бледное лицо Ллейна. Вариан попытался стряхнуть их, но личинки полностью облепили тело Ллейна и начали пожирать его с отвратительным чавканьем. Он в ужасе закричал.";
        
        //Картинка---------------------------------------------
        UIImageView * mainImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 160)];
        mainImage.image = [UIImage imageNamed:@"imageSubject.png"];
        [self addSubview:mainImage];
        
        mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 170, view.frame.size.width, 200)];
        mainScrollView.backgroundColor = [UIColor whiteColor];
        [self addSubview:mainScrollView];
        
        //Текст------------------------------------------------
        textViewText = [[UITextView alloc] initWithFrame:CGRectMake(16, 22, self.frame.size.width - 32, 152)];
        textViewText.text = stringText;
        textViewText.backgroundColor = nil;
        textViewText.textColor = [UIColor colorWithHexString:@"838484"];
        textViewText.font = [UIFont fontWithName:FONTLITE size:13];
        textViewText.userInteractionEnabled = NO;
        textViewText.editable = NO;
        textViewText.showsVerticalScrollIndicator = NO;
        [mainScrollView addSubview:textViewText];
        
        //Кнопка изменения высоты первого скрола
        buttonHeight = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonHeight.frame = CGRectMake(16, 180, 45.5, 8);
        UIImage * imageButtonHeight = [UIImage imageNamed:@"buttonHight.png"];
        [buttonHeight setImage:imageButtonHeight forState:UIControlStateNormal];
        [buttonHeight addTarget:self action:@selector(buttonHeightAction) forControlEvents:UIControlEventTouchUpInside];
        [mainScrollView addSubview:buttonHeight];
        
    }
    return self;
}


#pragma mark - Action Methods
//Дествие кнопки удлинения скрол вью
- (void) buttonHeightAction
{
    if (mainAnim) {
        [UIView animateWithDuration:0.5 animations:^{
            //Скролл
            CGRect newRectScroll = mainScrollView.frame;
            newRectScroll.size.height += 300;
            mainScrollView.frame = newRectScroll;
            //Кнопка
            CGRect newRectButton = buttonHeight.frame;
            newRectButton.origin.y += 300;
            buttonHeight.frame = newRectButton;
            //Лейбл
            CGRect newRectLabel = textViewText.frame;
            newRectLabel.size.height += 300;
            textViewText.frame = newRectLabel;
        } completion:^(BOOL finished) {
            textViewText.userInteractionEnabled = YES;
        }];
        mainAnim = NO;
    } else {
        [UIView animateWithDuration:0.5 animations:^{
            //Скрол
            CGRect newRectScroll = mainScrollView.frame;
            newRectScroll.size.height -= 300;
            mainScrollView.frame = newRectScroll;
            //Кнопка
            CGRect newRectButton = buttonHeight.frame;
            newRectButton.origin.y -= 300;
            buttonHeight.frame = newRectButton;
            //Лейбл
            CGRect newRectLabel = textViewText.frame;
            newRectLabel.size.height -= 300;
            textViewText.frame = newRectLabel;
        } completion:^(BOOL finished) {
            textViewText.userInteractionEnabled = NO;
        }];
        mainAnim = YES;
    }
}

- (void) buttonPushAction
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_OPEN_SUBJECT_PUSH_TU_DISCUSSIONS object:nil];
}

@end
