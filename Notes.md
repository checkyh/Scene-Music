##To do&&Solution Notes:

2 types of Notification in need

MPMuiscPlayerControllerPlayStateDidChangeNotification

MPMuiscPlayerControllerNowPlayingItemDidChangeNotification

    NSNotification *center=[NSNotificationCenter defaultCenter];
    [center addObserver:self 
    selector:@(function:)
    name:MPMuiscPlayerControllerPlayStateDidChangeNotification
    object:self.
    ]
    -(void) function:(NSNotification *)paramNotification{
    NSNumber *stateAsObject=[paramNotification.userInfo
    objectForKey:@"MPMusicPlayerControllerPlaybackStateKey"
    }


MPMediaQuery
MPPredicate 
