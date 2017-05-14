clear;clc;format compact;
[Data, Dates] = xlsread('BEYRIndex.xlsx');
Dates = datenum(Dates(2:end,1));
Data = [Dates, Data(:,2:end)];

% ÍòµÃÈ«A
md1 = MaxDraw(Data(:,2), 1);
ar1 = AnnualizedReturn(Data(:,[1,2]), 1);
sr1 = SharpeRatio(Data(:,2), 1);

% 065.CS
md2 = MaxDraw(Data(:,8), 1);
ar2 = AnnualizedReturn(Data(:,[1,8]), 1);
sr2 = SharpeRatio(Data(:,8), 1);

% 093.CS
md3 = MaxDraw(Data(:,5), 1);
ar3 = AnnualizedReturn(Data(:,[1,5]), 1);
sr3 = SharpeRatio(Data(:,5), 1);

% Strategy
md4 = MaxDraw(Data(:,7), 1);
ar4 = AnnualizedReturn(Data(:,[1,7]), 1);
sr4 = SharpeRatio(Data(:,7), 1);