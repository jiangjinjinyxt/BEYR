% 用债券指数一段时间的SharpeRatio和股票指数一段时间的SharpeRatio差在历史上所处的分位点作为参考,
% 年化的超额收益依赖训练集和测试集的选取,比较不稳定; 综合来看,用10天日收益序列计算的SharpeRatio的差作为参考的超额收益和夏普比率较高;
% SRDiff = Period SharpeRatio of Bond - Period SharpeRatio of Equity; Use All Historical Data Before Today To Compute Quantile

%% ####################################### Algorithm #######################################
% Step1: 根据SRDiff构造SRDiffIndex, 构造方法:当天的SRDiffIndex = 当天的SRDiff处于过去所有的SRDiff数据构成的样本的分位点
% Step2: 用训练数据集进回归, 自变量 = SRDiffIndex; 因变量 = 滞后一阶的MBD, 得到关于Quantile和MBD的函数;
% Step3: 根据训练集的回归函数、测试集中的SRDiffIndex的数据, 得到Fitted-MBD数据,表示下一交易日的久期
% Setp4: 根据预测的MBD数据,进行回测.   
%         回测区间的每日收益：
%         if FittedMBD > 4
%            return = 基础资产的return * FittedMBD - (FittedMBD - 4) * 贷款利率 / 4
%         else
%            return = 基础资产的return * FittedMBD + (4 - FittedMBD) * 存款利率 / 4
% ####################################### Algorithm #######################################

%% ##################################### Applications ######################################
% Application #1
% 本例选取的数据: SRDiff = 037.CS最近Period天的夏普比率 - 万得银行指数最近Period天的夏普比率;            
% Step1: 构造SRDiffIndex, Period = 5/10/22/44/66, 当天的SRDiffIndex = 当天的SRDiff处于所有的SRDiff数据构成的样本的分位点
% Step2: 训练集的区间 = [2006-01-01, 2015-12-31], 自变量 = SRDiffIndex; 因变量 = 滞后一阶的MBD, 得到关于Quantile和MBD的函数;
% Step3: 测试集的区间 = [2016-01-01, 2016-12-31], 根据训练集的回归函数, 测试集中的SRDiffIndex的数据, 得到预测的MBD数据
% Setp4: 根据预测的MBD数据, 进行回测, 用于回测的基础资产是037.CS, 存款利率和贷款利率都是DR007.IB
% ******************** 回测结果 *****************************
% *** Period   年化收益  年化超额收益  夏普比率  最大回撤   ***
% ***   5        2.48%      1.61%       1.39    3.06%    ***
% ***   10       3.04%      2.17%       1.86    2.45%    ***
% ***   22       2.48%      1.61%       1.56    2.23%    ***
% ***   44       2.41%      1.55%       1.57    2.03%    ***
% ***   66       1.98%      1.11%       1.18    2.60%    ***
% **********************************************************
% Application #2
% 本例选取的数据: SRDiff = 037.CS最近Period天的夏普比率 - 万得银行指数最近Period天的夏普比率;                      
% Step1: Period = 5/10/22/44/66
% Step2: 训练集的区间 = [2006-01-01, 2010-12-31]
% Step3: 测试集的区间 = [2011-01-01, 2016-12-31]
% Setp4: 基础资产是037.CS, 存款利率和贷款利率都是DR007.IB
% ******************** 回测结果 *****************************
% *** Period   年化收益  年化超额收益  夏普比率  最大回撤   *** 
% ***   5        4.83%      0.77%       2.99    3.58%    ***
% ***   10       4.96%      0.90%       3.07    3.49%    ***
% ***   22       4.71%      0.65%       2.80    3.38%    ***
% ***   44       4.66%      0.60%       2.75    2.93%    ***
% ***   66       4.46%      0.40%       2.64    3.39%    ***
% **********************************************************
% Application #3
% 本例选取的数据: SRDiff = 037.CS最近Period天的夏普比率 - 万得银行指数最近Period天的夏普比率;          
% Step1: Period = 5/10/22/44/66
% Step2: 训练集的区间 = [2011-01-01, 2016-12-31]
% Step3: 测试集的区间 = [2006-01-01, 2010-01-01]
% Setp4: 基础资产是037.CS, 存款利率和贷款利率都是DR007.IB
% ******************** 回测结果 *****************************
% *** Period   年化收益  年化超额收益  夏普比率  最大回撤   *** 
% ***   5        3.98%      0.93%       1.87    3.17%    ***
% ***   10       4.36%      1.31%       2.05    2.65%    ***
% ***   22       4.63%      1.57%       2.12    3.00%    ***
% ***   44       4.67%      1.62%       2.09    3.49%    ***
% ***   66       4.30%      1.25%       2.09    3.92%    ***
% **********************************************************
% ##################################### Applications ######################################

%% ######################################## 参考指标 ########################################
% #(1) AssetBenchmark  用于测试策略效果的基础资产                    
% #       中债总财富:037.CS    038.CS:中债国债     039.CS:中债银行间国债             
% #       中债企业债:054.CS    060.CS:中债国开债   066.CS:中债信用债                 
% #(2) AssetBond  用于训练的债券数据代码                       
% #       中债总财富:037.CS    038.CS:中债国债     039.CS:中债银行间国债             
% #       中债企业债:054.CS    060.CS:中债国开债   066.CS:中债信用债 
% #(3) AssetEquity  用于训练的股票数据代码                     
% #       万得银行指数:882115.WI   上证50:000016.SH        沪深300:000300.SH 
% #       中证500:000905.SH
% #(4) DepositRate  存款利率
% #       银存间7天质押式回购利率: DR007.IB
% #(5) LendingRate  贷款利率
% #       银存间7天质押式回购利率: DR007.IB
% ######################################## 参考指标 ########################################

%%
clc; clear; format compact;
w = windmatlab;
load('MBD.mat'); DataMBD = MBD; AverageMBD = 4;
[AssetBenchmark, DepositRate, LendingRate, AssetBond, AssetEquity] = deal('037.CS', 'DR007.IB', 'DR007.IB', '037.CS', '882115.WI');
Period = 66; % 计算Period SharpeRatio的时间长度

%% ################################## Module One: 提取数据 ##################################
% (1) StartDate:数据的起始时点     EndDate:数据的截止时点           
% 设置提取数据的起始和截止时点,一次性从Wind数据库提取出所有可能需要的数据,避免后面反复提取
% (2) TrainStartDate:训练数据的起始时点  TrainEndDate:训练数据的截止时点
% (3) TestStartDate:测试数据的起始时点   TestEndDate:测试数据的截止时点
[StartDate, EndDate, TrainStartDate, TrainEndDate, TestStartDate, TestEndDate] = deal('2005-01-01', '2017-01-09', '2006-01-01', '2010-12-31', '2011-01-01', '2016-12-31');
[DataBenchmark, ~, ~, BenchmarkTimes] = w.wsd(AssetBenchmark, 'PCT_CHG', StartDate, EndDate);
[DataDeposit, ~, ~, DepositTimes] = w.wsd(DepositRate, 'close', StartDate, EndDate);
[DataLending, ~, ~, LendingTimes] = w.wsd(LendingRate, 'close', StartDate, EndDate);
[DataBond, ~, ~, BondTimes] = w.wsd(AssetBond, 'PCT_CHG', StartDate, EndDate);
[DataEquity, ~, ~, EquityTimes] = w.wsd(AssetEquity, 'PCT_CHG', StartDate, EndDate);
[StartDate, EndDate, TrainStartDate, TrainEndDate, TestStartDate, TestEndDate] = deal(datenum(StartDate),datenum(EndDate), datenum(TrainStartDate), datenum(TrainEndDate), datenum(TestStartDate), datenum(TestEndDate));
% ################################## Module One: 提取数据 ##################################

%% ################################# Module Two: 统一数据格式 ###############################
% 所有数据格式调整为: 第一列表示时间,第二列表示对应的数据
DataBenchmark = [BenchmarkTimes, DataBenchmark/100];
DataDeposit = [DepositTimes, DataDeposit/365/100];
DataLending = [LendingTimes, DataLending/365/100];
DataBond = [BondTimes, DataBond];
for i=Period+1:size(DataBond,1)
    DataBond(i, 3) = SharpeRatio(DataBond(i-Period:i-1,2), 1);
end
DataBond = DataBond(Period+1:end, [1,3]);
DataEquity = [EquityTimes, DataEquity];
for i=Period+1:size(DataEquity,1)
    DataEquity(i, 3) = SharpeRatio(DataEquity(i-Period:i-1,2), 1);
end
DataEquity = DataEquity(Period+1:end, [1,3]);
DataReference = IndexMatch(DataBond, DataEquity, 'inner');
DataSRDiff = [DataReference(:,1), DataReference(:,2) - DataReference(:,3)];
% ################################ Module Two: 统一数据格式 ################################

%% ############################## Module Three: 计算Quantile ###############################
% 计算SRDiff在历史所处的分位点
QuantileNums = 10;
for i = QuantileNums+1:size(DataSRDiff, 1)
    %DataSRDiff的一列是日期序列,第二列是对应的SRDiff的数据,第三列是对应的Quantile的数据
    DataSRDiff(i,3) = GetQuantileIndex(DataSRDiff(i,2),  DataSRDiff(1:i-1,2), QuantileNums);
end
DataSRDiffIndex = DataSRDiff(:,[1,3]);
% ############################## Module Three: 计算Quantile ###############################

%% ################################ Module Four: 回归分析 ##################################
% 自变量: Quantile, 因变量: MBD
% Data的第一列是日期,第二列是Quantile,第三列是MBD
Data = IndexMatch(DataSRDiffIndex, DataMBD, 'inner');
TrainData = Data(Data(:,1) >= TrainStartDate & Data(:,1) <= TrainEndDate, [2, 3]);
% 用Quantile数据和滞后一天的MBD数据做回归(策略: 根据当天收盘时SRDiff的Quantile, 决定第二天的Duration)
[Curve, Goodness] = fit(TrainData(1:end-1,1), TrainData(2:end,2), 'smoothingspline', 'SmoothingPara', 0.6);
% ******** Scatter actual points, Plot fitted curve ************
figure();
scatter(TrainData(:,1), TrainData(:,2), 2, 'ro');
hold on;
plot(Curve, 'b');
xlabel('Quantile');
ylabel('Duration');
title(['R2 = ', num2str(Goodness.rsquare)]);
hold off;
% ################################ Module Four: 回归分析 ##################################

%% ################################## Module Five: 回测 ####################################
DataSRDiffIndex(:, 3) = feval(Curve, DataSRDiffIndex(:, 2));
FittedAll = IndexMatch(Data(:,[1,3]), DataSRDiffIndex, 'right');
FittedAll(2:end,4) = FittedAll(1:end-1,4);
FittedMBD = FittedAll(FittedAll(:,1) >= TestStartDate & FittedAll(:,1) <= TestEndDate,:);
% FittedMBD和FittedAll的第一列为日期,第二列为实际的MBD,第三列为对应的QuantileIndex,第四列为拟合的MBD
[DailyReturns, DailyValues] = NetValues(FittedMBD(:,[1,4]), AverageMBD, DataBenchmark, DataDeposit, DataLending);
% DailyReturns的第一列为日期,第二列为持有基础资产的日收益率序列,第三列为策略的日收益率序列
% DailyValues的第一列为日期,第二列为持有基础资产的累计净值,第三列为策略的累计净值

%% ********************* 回测结果-数据 ************************
AR = AnnualizedReturn(DailyValues(:,[1,3]),2);  % 年化收益率
AAR = AnnualizedExcessReturn(DailyValues(:,[1,2]), DailyValues(:,[1,3]),2); %年化超额收益率
SR = SharpeRatio(DailyReturns(:,3), 1); % 夏普比率
MD = MaxDraw(DailyValues(:,3),2); % 区间最大回撤
fprintf('*-------------------*\n');
fprintf('|%-10s%.2f%%|\n',  '年化收益',AR*100);
fprintf('|%-10s%.2f%%|\n',  '年化超额', AAR*100);
fprintf('|%-10s%.2f |\n', '夏普比率', SR);
fprintf('|%-10s%.2f%%|\n', '最大回撤', -MD*100);
fprintf('*-------------------*\n');
%% ********************* 回测结果-图表 ************************
figure();
% ********************** 回测收益图 **************************
subplot(2, 2, 1);
plot(DailyValues(:,1), DailyValues(:, [3, 2]));
legend('DurationMangement', ['Benchmark ', AssetBenchmark], 'Location','NorthWest');
title('模拟结果');
Xaxis = linspace(DailyValues(1,1), DailyValues(end,1), 8);
set(gca, 'xtick', Xaxis);
set(gca,'xticklabel',datestr(Xaxis,'yyyy/mm/dd'));
% ************************ 收益比 ***************************
subplot(2, 2, 3);
plot(DailyValues(:, 1), DailyValues(:,3) ./ DailyValues(:, 2));
title('收益比');
Xaxis = linspace(DailyValues(1,1), DailyValues(end,1), 8);
set(gca, 'xtick', Xaxis);
set(gca,'xticklabel',datestr(Xaxis,'yyyy/mm/dd'));
% **************** Fitted-MBD VS Actual-MBD *****************
subplot(2, 2, 2);
plot(FittedMBD(:, 1), FittedMBD(:,[2,4]));
legend('Actual-MBD', 'Fitted-MBD', 'Location','NorthWest');
title('拟合的动态久期');
Xaxis = linspace(FittedMBD(1,1), FittedMBD(end,1), 8);
set(gca, 'xtick', Xaxis);
set(gca,'xticklabel',datestr(Xaxis,'yyyy/mm/dd'));
% ************ Smoothed-Fitted-MBD VS Actual-MBD ************
subplot(2, 2, 4);
[Curve, ~] = fit(FittedMBD(:,1), FittedMBD(:,4), 'smoothingspline', 'SmoothingPara', 0.01);
plot(FittedMBD(:, 1), [FittedMBD(:,2), feval(Curve, FittedMBD(:, 1))]);
legend('Actual-MBD', 'Smoothed-Fitted-MBD', 'Location','NorthWest');
title('拟合的动态久期');
Xaxis = linspace(FittedMBD(1,1), FittedMBD(end,1), 8);
set(gca, 'xtick', Xaxis);
set(gca,'xticklabel',datestr(Xaxis,'yyyy/mm/dd'));
% ################################## Module Five: 回测 ####################################
w.close();