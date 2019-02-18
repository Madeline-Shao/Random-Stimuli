%@author: Madeline Shao
try
    Screen('Preference','SkipSyncTests',1);
    rng('shuffle'); %reseeds random number generator
    [window,rect]=Screen('OpenWindow',0) %window: name of window, %rect, coords of window %after 0 the arguments are: color of screen, size of screen
    Screen('BlendFunction', window, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA); %give the possibility of transparency
    HideCursor(); 
    
    window_w = rect(3);
    window_h = rect(4);
    center_x = window_w/2; %x center of screen
    center_y = window_h/2; %y center of screen
    
     %cd .. 
    cd('Stimuli');
    
    mask = imread('mask.png');
    mask = mask(:,:,1);
    
    for i = 1:49
        %image=imread(sprintf('./Stimuli/%d.png',i));
        image = imread ([num2str(i) '.png']); 
        image(:,:,4)  = mask;
        texture(i) = Screen('MakeTexture', window, image); 
    end 
    
    image_size =  size(image);
    image_height = image_size(1);
    image_width = image_size(2);
    
    gridLocX = linspace(image_width, window_w - image_width, 3)
    gridLocY = linspace(image_height, window_h - image_height, 2)
    [x, y] = meshgrid(gridLocX, gridLocY) %grid of display points
    
    xy_rect = [x(:)'-image_width/2; y(:)'-image_height/2; x(:)'+image_width/2; y(:)'+image_height/2];
    
    num_oranges = 6; % total number of display points for the grid
    rand_oranges = randsample(1:49, num_oranges); % selecting random oranges

    Screen('DrawTextures', window, texture(rand_oranges), [], xy_rect);

    Screen('Flip', window); 
    WaitSecs(1)
    
    KbWait %make the program wait for a keyboard response.
    Screen('CloseAll');
    cd ..
    %cd('Matlab Scripts')
catch
    Screen( 'CloseAll');
    rethrow(lasterror)
end;

