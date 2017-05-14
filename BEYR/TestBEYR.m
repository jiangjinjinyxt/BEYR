% 用债券的YTM和股票指数的PE的乘积在过去一段时间的分位点作为参考, 年化的超额收益基本都在1.20%以上; 较好的Window Size = 44; 
% BEYR = 债券的YTM * 权益的PE; Rolling Window;

%% ####################################### Algorithm #######################################
% Step1: 根据BEYR构造BEYRIndex, 构造方法:当天的BEYRIndex = 当天的BEYR处于过去某一段时间(Rolling Window)的BEYR数据构成的样本的分位点
% Step2: 用训练数据集进回归, 自变量 = BEYRIndex; 因变量 = 滞后一阶的MBD, 得到关于Quantile和MBD的函数;
% Step3: 根据训练集的回归函数、测试集中的BEYRIndex的数据, 得到Fitted-MBD数据,表示下一交易日的久期
% Setp4: 根据预测的MBD数据,进行回测.   
%         回测区间的每日收益：
%         if FittedMBD > 4
%            return = 基础资产的return * FittedMBD - (FittedMBD - 4) * 贷款利率 / 4
%         else
%            return = 基础资产的return * FittedMBD + (4 - FittedMBD) * 存款利率 / 4
% ####################################### Algorithm #######################################

%% ##################################### Applications ######################################
% Application #1
% 本例选取的数据: BEYR = 10年国债每日的YTM * 万得银行指数每日的PE;            
% Step1: 构造BEYRIndex, Window = 22/44/66, 当天的BEYRIndex = 当天的BEYR处于过去Window个交易日的BEYR数据构成的样本的分位点
% Step2: 训练集的区间 = [2006-01-01, 2015-12-31], 自变量 = BEYRIndex; 因变量 = 滞后一阶的MBD, 得到关于Quantile和MBD的函数;
% Step3: 测试集的区间 = [2016-01-01, 2016-12-31], 根据训练集的回归函数, 测试集中的BEYRIndex的数据, 得到预测的MBD数据
% Setp4: 根据预测的MBD数据, 进行回测, 用于回测的基础资产是037.CS, 存款利率和贷款利率都是DR007.IB
% ******************** 回测结果 *****************************
% *** Window   年化收益  年化超额收益  夏普比率  最大回撤   *** 
% ***   22       2.68%      1.81%       1.58    2.71%    ***
% ***   44       2.49%      1.62%       1.44    2.81%    ***
% ***   66       2.26%      1.39%       1.27    2.82%    ***
% **********************************************************
% Application #2
% 本例选取的数据: BEYR = 10年国债每日的YTM * 万得银行指数每日的PE;            
% Step1: Window = 22/44/66
% Step2: 训练集的区间 = [2006-01-01, 2010-12-31]
% Step3: 测试集的区间 = [2011-01-01, 2016-12-31]
% Setp4: 基础资产是037.CS, 存款利率和贷款利率都是DR007.IB
% ******************** 回测结果 *****************************
% *** Window   年化收益  年化超额收益  夏普比率  最大回撤   *** 
% ***   22       5.16%      1.10%       3.15    3.31%    ***
% ***   44       5.35%      1.29%       3.11    3.21%    ***
% ***   66       5.13%      1.07%       2.97    3.43%    ***
% **********************************************************
% Application #3
% 本例选取的数据: BEYR = 10年国债每日的YTM * 万得银行指数每日的PE;            
% Step1: Window = 22/44/66
% Step2: 训练集的区间 = [2011-01-01, 2016-12-31]
% Step3: 测试集的区间 = [2006-01-01, 2010-01-01]
% Setp4: 基础资产是037.CS, 存款利率和贷款利率都是DR007.IB
% ******************** 回测结果 *****************************
% *** Window   年化收益  年化超额收益  夏普比率  最大回撤   *** 
% ***   22       4.26%      1.27%       1.88    3.09%    ***
% ***   44       4.32%      1.32%       1.88    3.32%    ***
% ***   66       4.48%      1.48%       1.89    3.42%    ***
% **********************************************************
% ##################################### Applications ######################################

%% ######################################## 参考指标 ########################################
% #(1) AssetBenchmark  用于测试策略效果的基础资产                    
% #       中债总财富:037.CS    038.CS:中债国债     039.CS:中债银行间国债             
% #       中债企业债:054.CS    060.CS:中债国开债   066.CS:中债信用债                 
% #(2) AssetBond  用于训练的债券数据代码                       
% #       一年国债:M1000158       五年国债:M1000162       十年国债:M1000166            
% #       一年国开:M1004263       五年国开:M1004267       十年国开:M1004271             
% #       1Y3A企业:M1000368       3Y3A企业:M1000370       5Y3A企业:M1000372
% #       1Y2A+企业:M1000394      3Y2A+企业:M1000396      5Y2A+企业:M1000398
% #(3) AssetEquity  用于训练的股票数据代码                     
% #       万得银行指数:882115.WI         上证50 :000016.SH    中证500:000905.SH      
% #       万得全A指数 :881001.WI         沪深300:000300.SH
% #(4) DepositRate  存款利率
% #       银存间7天质押式回购利率: DR007.IB
% #(5) LendingRate  贷款利率
% #       银存间7天质押式回购利率: DR007.IB
% ######################################## 参考指标 ########################################
%%
clc; clear; format compact;
w = windmatlab;
load('MBD.mat'); DataMBD = MBD; AverageMBD = 4;
[AssetBenchmark, DepositRate, LendingRate, AssetBond, AssetEquity] = deal('037.CS', 'DR007.IB', 'DR007.IB', 'M1004267', '882115.WI');

%% ################################## Module One: 提取数据 ##################################
% (1) StartDate:数据的起始时点     EndDate:数据的截止时点           
% 设置提取数据的起始和截止时点,一次性从Wind数据库提取出所有可能需要的数据,避免后面反复提取
% (2) TrainStartDate:训练数据的起始时点  TrainEndDate:训练数据的截止时点
% (3) TestStartDate:测试数据的起始时点   TestEndDate:测试数据的截止时点
[StartDate, EndDate, TrainStartDate, TrainEndDate, TestStartDate, TestEndDate] = deal('2005-01-01', '2017-01-09', '2006-01-01', '2010-12-31', '2011-01-01', '2016-12-31');
[DataBenchmark, ~, ~, BenchmarkTimes] = w.wsd(AssetBenchmark, 'PCT_CHG', StartDate, EndDate);
[DataDeposit, ~, ~, DepositTimes] = w.wsd(DepositRate, 'close', StartDate, EndDate);
[DataLending, ~, ~, LendingTimes] = w.wsd(LendingRate, 'close', StartDate, EndDate);
[DataBond, ~, ~, BondTimes] = w.edb(AssetBond, StartDate, EndDate, 'Fill=Previous');
[DataEquity, ~, ~, EquityTimes] = w.wsd(AssetEquity, 'pe', StartDate, EndDate, 'ruleType=10');
[StartDate, EndDate, TrainStartDate, TrainEndDate, TestStartDate, TestEndDate] = deal(datenum(StartDate),datenum(EndDate), datenum(TrainStartDate), datenum(TrainEndDate), datenum(TestStartDate), datenum(TestEndDate));
% ################################## Module One: 提取数据 ##################################

%% ################################# Module Two: 统一数据格式 ###############################
% 所有数据格式调整为: 第一列表示时间,第二列表示对应的数据
DataBenchmark = [BenchmarkTimes,DataBenchmark/100];
DataDeposit = [DepositTimes, DataDeposit/365/100];
DataLending = [LendingTimes, DataLending/365/100];
DataBond = [BondTimes, DataBond];
DataEquity = [EquityTimes, DataEquity];
DataReference = IndexMatch(DataBond, DataEquity, 'inner');
DataBEYR = [DataReference(:,1), DataReference(:,2) .* DataReference(:,3)];
% ################################ Module Two: 统一数据格式 ################################

%% ############################## Module Three: 计算Quantile ###############################
% 计算每天的BEYR在过去一段时间所处的分位点,过去一段时间的长度用Window表示
QuantileNums = 10;
Window = 44;
for i = Window+1:size(DataBEYR, 1)
    %DataBEYR的一列是日期序列,第二列是对应的BEYR的数据,第三列是对应的Quantile的数据
    DataBEYR(i,3) = GetQuantileIndex(DataBEYR(i,2), DataBEYR(i-Window:i-1,2), QuantileNums);
end
DataBEYRIndex = DataBEYR(:,[1,3]);
% ############################## Module Three: 计算Quantile ###############################

%% ################################ Module Four: 回归分析 ##################################
% 自变量: Quantile, 因变量: MBD
% Data的第一列是日期,第二列是Quantile,第三列是MBD
Data = IndexMatch(DataBEYRIndex, DataMBD, 'inner');
TrainData = Data(Data(:,1) >= TrainStartDate & Data(:,1) <= TrainEndDate, [2, 3]);
% 用Quantile数据和滞后一天的MBD数据做回归(策略: 根据当天收盘时BEYR的Quantile, 决定第二天的Duration)
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
DataBEYRIndex(:, 3) = feval(Curve, DataBEYRIndex(:, 2));
FittedAll = IndexMatch(Data(:,[1,3]), DataBEYRIndex, 'right');
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