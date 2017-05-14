% 用债券指数一段时间的收益在历史上的分位点作为参考, 年化的超额收益基本都在1.50%以上; 较好的Window Size = 5至10天; 
% PeriodReturn = Period Return of Bond; Use All Historical Data Before Today To Compute Quantile

%% ####################################### Algorithm #######################################
% Step1: 根据PeriodReturn构造PeriodReturnIndex, 构造方法:当天的PeriodReturnIndex = 当天的PeriodReturn处于过去所有的PeriodReturn数据构成的样本的分位点
% Step2: 用训练数据集进回归, 自变量 = PeriodReturnIndex; 因变量 = 滞后一阶的MBD, 得到关于Quantile和MBD的函数;
% Step3: 根据训练集的回归函数、测试集中的PeriodReturnIndex的数据, 得到Fitted-MBD数据,表示下一交易日的久期
% Setp4: 根据预测的MBD数据,进行回测.   
%         回测区间的每日收益：
%         if FittedMBD > 4
%            return = 基础资产的return * FittedMBD - (FittedMBD - 4) * 贷款利率 / 4
%         else
%            return = 基础资产的return * FittedMBD + (4 - FittedMBD) * 存款利率 / 4
% ####################################### Algorithm #######################################

%% ##################################### Applications ######################################
% Application #1
% 本例选取的数据: PeriodReturn = 037.CS最近Period天的收益率;   
% Step1: 构造PeriodReturnIndex, Period = 5/10/22/44, 当天的PeriodReturnIndex = 当天的PeriodReturn处于所有的PeriodReturn数据构成的样本的分位点
% Step2: 训练集的区间 = [2006-01-01, 2015-12-31], 自变量 = PeriodReturnIndex; 因变量 = 滞后一阶的MBD, 得到关于Quantile和MBD的函数;
% Step3: 测试集的区间 = [2016-01-01, 2016-12-31], 根据训练集的回归函数, 测试集中的PeriodReturnIndex的数据, 得到预测的MBD数据
% Setp4: 根据预测的MBD数据, 进行回测, 用于回测的基础资产是037.CS, 存款利率和贷款利率都是DR007.IB
% ******************** 回测结果 *****************************
% *** Period   年化收益  年化超额收益  夏普比率  最大回撤   ***
% ***   5        3.00%      2.14%       1.75    2.95%    ***
% ***   10       2.67%      1.81%       1.60    2.65%    ***
% ***   22       2.43%      1.57%       1.47    2.37%    ***
% ***   44       1.94%      1.07%       1.08    2.61%    ***
% **********************************************************
% Application #2
% 本例选取的数据: PeriodReturn = 037.CS最近Period天的收益率;           
% Step1: Period = 5/10/22/44
% Step2: 训练集的区间 = [2006-01-01, 2010-12-31]
% Step3: 测试集的区间 = [2011-01-01, 2016-12-31]
% Setp4: 基础资产是037.CS, 存款利率和贷款利率都是DR007.IB
% ******************** 回测结果 *****************************
% *** Period   年化收益  年化超额收益  夏普比率  最大回撤   ***
% ***   5        5.86%      1.80%       3.29    3.25%    ***
% ***   10       5.58%      1.52%       3.10    3.44%    ***
% ***   22       5.57%      1.51%       2.95    2.87%    ***
% ***   44       5.34%      1.28%       2.76    3.33%    ***
% **********************************************************
% Application #3
% 本例选取的数据: PeriodReturn = 037.CS最近Period天的收益率;          
% Step1: Period = 5/10/22/44
% Step2: 训练集的区间 = [2011-01-01, 2016-12-31]
% Step3: 测试集的区间 = [2006-01-01, 2010-01-01]
% Setp4: 基础资产是037.CS, 存款利率和贷款利率都是DR007.IB
% ******************** 回测结果 *****************************
% *** Period   年化收益  年化超额收益  夏普比率  最大回撤   ***
% ***   5        4.75%      1.69%       2.09    2.89%    ***
% ***   10       4.93%      1.88%       2.16    2.44%    ***
% ***   22       5.12%      2.06%       2.14    2.94%    ***
% ***   44       5.25%      2.19%       2.18    3.68%    ***
% **********************************************************
% ##################################### Applications ######################################

%% ######################################## 参考指标 ########################################
% #(1) AssetBenchmark  用于测试策略效果的基础资产                    
% #       中债总财富:037.CS    038.CS:中债国债     039.CS:中债银行间国债             
% #       中债企业债:054.CS    060.CS:中债国开债   066.CS:中债信用债                 
% #(2) AssetBond  用于训练的债券数据代码                       
% #       中债总财富:037.CS    038.CS:中债国债     039.CS:中债银行间国债             
% #       中债企业债:054.CS    060.CS:中债国开债   066.CS:中债信用债 
% #(3) DepositRate  存款利率
% #       银存间7天质押式回购利率: DR007.IB
% #(4) LendingRate  贷款利率
% #       银存间7天质押式回购利率: DR007.IB
% ######################################## 参考指标 ########################################
%%
clc; clear; format compact;
w = windmatlab;
load('MBD.mat'); DataMBD = MBD; AverageMBD = 4;
[AssetBenchmark, DepositRate, LendingRate, AssetBond] = deal('037.CS', 'DR007.IB', 'DR007.IB', '037.CS');
Period = 5; % 计算Period Return的时间长度
%% ################################## Module One: 提取数据 ##################################
% (1) StartDate:数据的起始时点     EndDate:数据的截止时点           
% 设置提取数据的起始和截止时点,一次性从Wind数据库提取出所有可能需要的数据,避免后面反复提取
% (2) TrainStartDate:训练数据的起始时点  TrainEndDate:训练数据的截止时点
% (3) TestStartDate:测试数据的起始时点   TestEndDate:测试数据的截止时点
[StartDate, EndDate, TrainStartDate, TrainEndDate, TestStartDate, TestEndDate] = deal('2005-01-01', '2017-01-09', '2006-01-01', '2010-12-31', '2011-01-01', '2016-12-31');
[DataBenchmark, ~, ~, BenchmarkTimes] = w.wsd(AssetBenchmark, 'PCT_CHG', StartDate, EndDate);
[DataDeposit, ~, ~, DepositTimes] = w.wsd(DepositRate, 'close', StartDate, EndDate);
[DataLending, ~, ~, LendingTimes] = w.wsd(LendingRate, 'close', StartDate, EndDate);
[DataBond, ~, ~, BondTimes] = w.wsd(AssetBond, 'close', StartDate, EndDate, 'PriceAdj=F');
DataBond = DataBond(Period + 1:end) ./  DataBond(1:end-Period) - 1; BondTimes = BondTimes(Period + 1:end);
[StartDate, EndDate, TrainStartDate, TrainEndDate, TestStartDate, TestEndDate] = deal(datenum(StartDate),datenum(EndDate), datenum(TrainStartDate), datenum(TrainEndDate), datenum(TestStartDate), datenum(TestEndDate));
% ################################## Module One: 提取数据 ##################################

%% ################################# Module Two: 统一数据格式 ###############################
% 所有数据格式调整为: 第一列表示时间,第二列表示对应的数据
DataBenchmark = [BenchmarkTimes, DataBenchmark/100];
DataDeposit = [DepositTimes, DataDeposit/365/100];
DataLending = [LendingTimes, DataLending/365/100];
DataBond = [BondTimes, DataBond];
DataPeriodReturn = DataBond;
% ################################ Module Two: 统一数据格式 ################################

%% ############################## Module Three: 计算Quantile ###############################
% 计算PeriodReturn在历史上所处的分位点
QuantileNums = 10;
for i = QuantileNums+1:size(DataPeriodReturn, 1)
    %DataPeriodReturn的一列是日期序列,第二列是对应的PeriodReturn的数据,第三列是对应的Quantile的数据
    DataPeriodReturn(i,3) = GetQuantileIndex(DataPeriodReturn(i,2),  DataPeriodReturn(1:i-1,2), QuantileNums);
end
DataPeriodReturnIndex = DataPeriodReturn(:,[1,3]);
% ############################## Module Three: 计算Quantile ###############################

%% ################################ Module Four: 回归分析 ##################################
% 自变量: Quantile, 因变量: MBD
% Data的第一列是日期,第二列是Quantile,第三列是MBD
Data = IndexMatch(DataPeriodReturnIndex, DataMBD, 'inner');
TrainData = Data(Data(:,1) >= TrainStartDate & Data(:,1) <= TrainEndDate, [2, 3]);
% 用Quantile数据和滞后一天的MBD数据做回归(策略: 根据当天收盘时PeriodReturn的Quantile, 决定第二天的Duration)
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
DataPeriodReturnIndex(:, 3) = feval(Curve, DataPeriodReturnIndex(:, 2));
FittedAll = IndexMatch(Data(:,[1,3]), DataPeriodReturnIndex, 'right');
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