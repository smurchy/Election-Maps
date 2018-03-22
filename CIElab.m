%% This script finds intervals for 20% and 30% values in NYT's counties map.

%These are the initial low and high colours from the Counties map. 
%We'll keep them the same.
BlueLo = [206 234 253]./255;
RedLo = [251 208 208]./255;

BlueHi = [1 106 171]./255;
RedHi = [176 32 41]./255;

%Convert to LAB
BlueLoLab = rgb2lab(BlueLo);
RedLoLab = rgb2lab(RedLo);
BlueHiLab = rgb2lab(BlueHi);
RedHiLab = rgb2lab(RedHi);

%Find difference scores
BlueDiff = BlueHiLab - BlueLoLab;
RedDiff = RedHiLab - RedLoLab;

%Calculate intervals
BlueMid1Lab = BlueLoLab + (BlueDiff./3);
BlueMid2Lab = BlueLoLab + (BlueDiff./3) + (BlueDiff./3);
RedMid1Lab = RedLoLab + (RedDiff./3);
RedMid2Lab = RedLoLab + (RedDiff./3) + (RedDiff./3);

%Convert back to RGB
BlueMid1 = lab2rgb(BlueMid1Lab).*255; %NYT estimates [156 192 227]
BlueMid2 = lab2rgb(BlueMid2Lab).*255; %NYT estimates [97 147 199]
RedMid1 = lab2rgb(RedMid1Lab).*255; %NYT estimates [233 157 152]
RedMid2 = lab2rgb(RedMid2Lab).*255; %NYT estimates [207 99 93]