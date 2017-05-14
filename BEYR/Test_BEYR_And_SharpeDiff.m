% ��ծȯ��YTM�͹�Ʊָ����PE�ĳ˻��ڹ�ȥһ��ʱ��(Window = 22)�ķ�λ��, �Լ�SharpeRatio�Ĳ�ֵ����ʷ�ϵķ�λ����Ϊ�ο�, �껯�ĳ��������������1.20%����; �Ϻõ�Window Size = 44; 
% BEYR = ծȯ��YTM * Ȩ���PE; Rolling Window;
% SRDiff = Period SharpeRatio of Bond - Period SharpeRatio of Equity; Use All Historical Data Before Today To Compute Quantile

%% ####################################### Algorithm #######################################
% Step1: ����BEYR����BEYRIndex, ���췽��:�����BEYRIndex = �����BEYR���ڹ�ȥĳһ��ʱ��(Rolling Window)��BEYR���ݹ��ɵ������ķ�λ��
%        ����SRDiff����SRDiffIndex, ���췽��:�����SRDiffIndex = �����SRDiff���ڹ�ȥ���е�SRDiff���ݹ��ɵ������ķ�λ��
% Step2: ��ѵ�����ݼ����ع�, �Ա��� = [BEYRIndex, SRDiffIndex]; ����� = �ͺ�һ�׵�MBD, �õ���������Quantile��MBD�ĺ���;
% Step3: ����ѵ�����Ļع麯�������Լ��е�[BEYRIndex, SRDiffIndex]������, �õ�Fitted-MBD����,��ʾ��һ�����յľ���
% Setp4: ����Ԥ���MBD����,���лز�.   
%         �ز������ÿ�����棺
%         if FittedMBD > 4
%            return = �����ʲ���return * FittedMBD - (FittedMBD - 4) * �������� / 4
%         else
%            return = �����ʲ���return * FittedMBD + (4 - FittedMBD) * ������� / 4
% ####################################### Algorithm #######################################

%% ##################################### Applications ######################################
% *** Window = 22 ***
% Application #1
% ����ѡȡ������: BEYR = 10���ծÿ�յ�YTM * �������ָ��ÿ�յ�PE;
%                SRDiff = 037.CS���Period������ձ��� - �������ָ�����Period������ձ���;
% Step1: ����BEYRIndex, Period = 5/10/22/44/66, �����BEYRIndex = �����BEYR���ڹ�ȥWindow�������յ�BEYR���ݹ��ɵ������ķ�λ��
%                                               �����SRDiffIndex = �����SRDiff�������е�SRDiff���ݹ��ɵ������ķ�λ��
% Step2: ѵ���������� = [2006-01-01, 2015-12-31], �Ա��� = [BEYRIndex, SRDiffIndex]; ����� = �ͺ�һ�׵�MBD, �õ�����Quantile��MBD�ĺ���;
% Step3: ���Լ������� = [2016-01-01, 2016-12-31], ����ѵ�����Ļع麯��, ���Լ��е�[BEYRIndex, SRDiffIndex]������, �õ�Ԥ���MBD����
% Setp4: ����Ԥ���MBD����, ���лز�, ���ڻز�Ļ����ʲ���037.CS, ������ʺʹ������ʶ���DR007.IB
% ******************** �ز��� *****************************
% *** Period   �껯����  �껯��������  ���ձ���  ���س�   ***
% ***   5        2.81%      1.95%       1.67    2.68%    ***
% ***   10       2.94%      2.08%       1.80    2.48%    ***
% ***   22       2.50%      1.63%       1.52    2.45%    ***
% ***   44       2.53%      1.66%       1.57    2.31%    ***
% ***   66       2.59%      1.72%       1.64    2.27%    ***
% **********************************************************
% Application #2
% ����ѡȡ������: BEYR = 10���ծÿ�յ�YTM * �������ָ��ÿ�յ�PE; 
%                SRDiff = 037.CS���Period������ձ��� - �������ָ�����Period������ձ���;
% Step1: Period = 5/10/22/44/66
% Step2: ѵ���������� = [2006-01-01, 2010-12-31]
% Step3: ���Լ������� = [2011-01-01, 2016-12-31]
% Setp4: �����ʲ���037.CS, ������ʺʹ������ʶ���DR007.IB
% ******************** �ز��� *****************************
% *** Period   �껯����  �껯��������  ���ձ���  ���س�   ***
% ***   5        5.33%      1.27%       3.29    3.11%    ***
% ***   10       5.31%      1.25%       3.29    3.08%    ***
% ***   22       5.19%      1.13%       3.13    2.91%    ***
% ***   44       5.12%      1.06%       2.97    2.97%    ***
% ***   66       5.10%      1.04%       2.93    3.22%    ***
% **********************************************************
% Application #3
% ����ѡȡ������: BEYR = 10���ծÿ�յ�YTM * �������ָ��ÿ�յ�PE;
%                SRDiff = 037.CS���Period������ձ��� - �������ָ�����Period������ձ���;
% Step1: Period = 5/10/22/44/66
% Step2: ѵ���������� = [2011-01-01, 2016-12-31]
% Step3: ���Լ������� = [2006-01-01, 2010-01-01]
% Setp4: �����ʲ���037.CS, ������ʺʹ������ʶ���DR007.IB
% ******************** �ز��� *****************************
% *** Period   �껯����  �껯��������  ���ձ���  ���س�   ***
% ***   5        4.37%      1.37%       1.91    3.05%    ***
% ***   10       4.54%      1.54%       2.00    2.88%    ***
% ***   22       4.63%      1.64%       1.99    3.09%    ***
% ***   44       4.84%      1.85%       2.01    3.18%    ***
% ***   66       5.19%      2.20%       2.08    3.49%    ***
% **********************************************************
% **********************************************************
% ##################################### Applications ######################################

%% ######################################## �ο�ָ�� ########################################
% #(1) AssetBenchmark  ���ڲ��Բ���Ч���Ļ����ʲ�                    
% #       ��ծ�ܲƸ�:037.CS    038.CS:��ծ��ծ     039.CS:��ծ���м��ծ             
% #       ��ծ��ҵծ:054.CS    060.CS:��ծ����ծ   066.CS:��ծ����ծ                 
% #(2) AssetBond  ����ѵ����ծȯ���ݴ���                       
% #       һ���ծ:M1000158       �����ծ:M1000162       ʮ���ծ:M1000166            
% #       һ�����:M1004263       �������:M1004267       ʮ�����:M1004271             
% #       1Y3A��ҵ:M1000368       3Y3A��ҵ:M1000370       5Y3A��ҵ:M1000372
% #       1Y2A+��ҵ:M1000394      3Y2A+��ҵ:M1000396      5Y2A+��ҵ:M1000398
% #(3) AssetEquity  ����ѵ���Ĺ�Ʊ���ݴ���                     
% #       �������ָ��:882115.WI   ��֤50:000016.SH        ����300:000300.SH 
% #       ��֤500:000905.SH
% #(4) DepositRate  �������
% #       �����7����Ѻʽ�ع�����: DR007.IB
% #(5) LendingRate  ��������
% #       �����7����Ѻʽ�ع�����: DR007.IB
% ######################################## �ο�ָ�� ########################################
%%
clc; clear; format compact;
w = windmatlab;
load('MBD.mat'); DataMBD = MBD; AverageMBD = 4;
[AssetBenchmark, DepositRate, LendingRate, AssetBond1, AssetEquity1, AssetBond2, AssetEquity2] = deal('037.CS', 'DR007.IB', 'DR007.IB', 'M1004267', '882115.WI', '037.CS', '882115.WI');
Period = 10;
%% ################################## Module One: ��ȡ���� ##################################
% (1) StartDate:���ݵ���ʼʱ��     EndDate:���ݵĽ�ֹʱ��           
% ������ȡ���ݵ���ʼ�ͽ�ֹʱ��,һ���Դ�Wind���ݿ���ȡ�����п�����Ҫ������,������淴����ȡ
% (2) TrainStartDate:ѵ�����ݵ���ʼʱ��  TrainEndDate:ѵ�����ݵĽ�ֹʱ��
% (3) TestStartDate:�������ݵ���ʼʱ��   TestEndDate:�������ݵĽ�ֹʱ��
[StartDate, EndDate, TrainStartDate, TrainEndDate, TestStartDate, TestEndDate] = deal('2005-01-01', '2017-01-09', '2006-01-01', '2010-12-31', '2011-01-01', '2016-12-31');
[DataBenchmark, ~, ~, BenchmarkTimes] = w.wsd(AssetBenchmark, 'PCT_CHG', StartDate, EndDate);
[DataDeposit, ~, ~, DepositTimes] = w.wsd(DepositRate, 'close', StartDate, EndDate);
[DataLending, ~, ~, LendingTimes] = w.wsd(LendingRate, 'close', StartDate, EndDate);
[DataBond1, ~, ~, BondTimes1] = w.edb(AssetBond1, StartDate, EndDate, 'Fill=Previous');
[DataEquity1, ~, ~, EquityTimes1] = w.wsd(AssetEquity1, 'pe', StartDate, EndDate, 'ruleType=10');
[DataBond2, ~, ~, BondTimes2] = w.wsd(AssetBond2, 'PCT_CHG', StartDate, EndDate);
[DataEquity2, ~, ~, EquityTimes2] = w.wsd(AssetEquity2, 'PCT_CHG', StartDate, EndDate);
[StartDate, EndDate, TrainStartDate, TrainEndDate, TestStartDate, TestEndDate] = deal(datenum(StartDate),datenum(EndDate), datenum(TrainStartDate), datenum(TrainEndDate), datenum(TestStartDate), datenum(TestEndDate));
% ################################## Module One: ��ȡ���� ##################################

%% ################################# Module Two: ͳһ���ݸ�ʽ ###############################
% �������ݸ�ʽ����Ϊ: ��һ�б�ʾʱ��,�ڶ��б�ʾ��Ӧ������
DataBenchmark = [BenchmarkTimes,DataBenchmark/100];
DataDeposit = [DepositTimes, DataDeposit/365/100];
DataLending = [LendingTimes, DataLending/365/100];
DataBond1 = [BondTimes1, DataBond1];
DataEquity1 = [EquityTimes1, DataEquity1];
DataReference = IndexMatch(DataBond1, DataEquity1, 'inner');
DataBEYR = [DataReference(:,1), DataReference(:,2) .* DataReference(:,3)];
DataBond1 = [BondTimes1, DataBond1];
DataEquity1 = [EquityTimes1, DataEquity1];
DataBond2 = [BondTimes2, DataBond2];
DataEquity2 = [EquityTimes2, DataEquity2];
for i=Period+1:size(DataBond2,1)
    DataBond2(i, 3) = SharpeRatio(DataBond2(i-Period:i-1,2), 1);
end
DataBond2 = DataBond2(Period+1:end, [1,3]);
for i=Period+1:size(DataEquity2,1)
    DataEquity2(i, 3) = SharpeRatio(DataEquity2(i-Period:i-1,2), 1);
end
DataEquity2 = DataEquity2(Period+1:end, [1,3]);
DataReference = IndexMatch(DataBond2, DataEquity2, 'inner');
DataSRDiff = [DataReference(:,1), DataReference(:,2) - DataReference(:,3)];
% ################################ Module Two: ͳһ���ݸ�ʽ ################################

%% ############################## Module Three: ����Quantile ###############################
% ����ÿ���BEYR�ڹ�ȥһ��ʱ�������ķ�λ��,��ȥһ��ʱ��ĳ�����Window��ʾ
QuantileNums = 10;
Window = 44;
for i = Window+1:size(DataBEYR, 1)
    %DataBEYR��һ������������,�ڶ����Ƕ�Ӧ��BEYR������,�������Ƕ�Ӧ��Quantile������
    DataBEYR(i,3) = GetQuantileIndex(DataBEYR(i,2), DataBEYR(i-Window:i-1,2), QuantileNums);
end
DataBEYRIndex = DataBEYR(:,[1,3]);
% ����SRDiff����ʷ�������ķ�λ��
for i = QuantileNums+1:size(DataSRDiff, 1)
    %DataSRDiff��һ������������,�ڶ����Ƕ�Ӧ��SRDiff������,�������Ƕ�Ӧ��Quantile������
    DataSRDiff(i,3) = GetQuantileIndex(DataSRDiff(i,2),  DataSRDiff(1:i-1,2), QuantileNums);
end
DataSRDiffIndex = DataSRDiff(:,[1,3]);
% ############################## Module Three: ����Quantile ###############################

%% ################################ Module Four: �ع���� ##################################
% �Ա���: Quantile, �����: MBD
% Data�ĵ�һ��������,�ڶ���������Quantile,��������MBD
DataIndex = IndexMatch(DataBEYRIndex, DataSRDiffIndex, 'inner');
Data = IndexMatch(DataIndex, DataMBD, 'inner');
TrainData = Data(Data(:,1) >= TrainStartDate & Data(:,1) <= TrainEndDate, [2, 3, 4]);
% ��Quantile���ݺ��ͺ�һ���MBD�������ع�(����: ���ݵ�������ʱBEYR��Quantile, �����ڶ����Duration)
[Curve, Goodness] = fit(TrainData(1:end-1,[1, 2]), TrainData(2:end,3), 'poly11');
% ################################ Module Four: �ع���� ##################################

%% ################################## Module Five: �ز� ####################################
DataIndex(:, 4) = feval(Curve, DataIndex(:, [2, 3]));
FittedAll = IndexMatch(Data(:,[1,4]), DataIndex, 'right');
FittedAll(2:end,5) = FittedAll(1:end-1,5);
FittedMBD = FittedAll(FittedAll(:,1) >= TestStartDate & FittedAll(:,1) <= TestEndDate,:);
% FittedMBD��FittedAll�ĵ�һ��Ϊ����,�ڶ���Ϊʵ�ʵ�MBD,����������Ϊ��Ӧ��QuantileIndex,������Ϊ��ϵ�MBD
[DailyReturns, DailyValues] = NetValues(FittedMBD(:,[1,5]), AverageMBD, DataBenchmark, DataDeposit, DataLending);
% DailyReturns�ĵ�һ��Ϊ����,�ڶ���Ϊ���л����ʲ���������������,������Ϊ���Ե�������������
% DailyValues�ĵ�һ��Ϊ����,�ڶ���Ϊ���л����ʲ����ۼƾ�ֵ,������Ϊ���Ե��ۼƾ�ֵ

%% ********************* �ز���-���� ************************
AR = AnnualizedReturn(DailyValues(:,[1,3]),2);  % �껯������
AAR = AnnualizedExcessReturn(DailyValues(:,[1,2]), DailyValues(:,[1,3]),2); %�껯����������
SR = SharpeRatio(DailyReturns(:,3), 1); % ���ձ���
MD = MaxDraw(DailyValues(:,3),2); % �������س�
fprintf('*-------------------*\n');
fprintf('|%-10s%.2f%%|\n',  '�껯����',AR*100);
fprintf('|%-10s%.2f%%|\n',  '�껯����', AAR*100);
fprintf('|%-10s%.2f |\n', '���ձ���', SR);
fprintf('|%-10s%.2f%%|\n', '���س�', -MD*100);
fprintf('*-------------------*\n');
%% ********************* �ز���-ͼ�� ************************
figure();
% ********************** �ز�����ͼ **************************
subplot(2, 2, 1);
plot(DailyValues(:,1), DailyValues(:, [3, 2]));
legend('DurationMangement', ['Benchmark ', AssetBenchmark], 'Location','NorthWest');
title('ģ����');
Xaxis = linspace(DailyValues(1,1), DailyValues(end,1), 8);
set(gca, 'xtick', Xaxis);
set(gca,'xticklabel',datestr(Xaxis,'yyyy/mm/dd'));
% ************************ ����� ***************************
subplot(2, 2, 3);
plot(DailyValues(:, 1), DailyValues(:,3) ./ DailyValues(:, 2));
title('�����');
Xaxis = linspace(DailyValues(1,1), DailyValues(end,1), 8);
set(gca, 'xtick', Xaxis);
set(gca,'xticklabel',datestr(Xaxis,'yyyy/mm/dd'));
% **************** Fitted-MBD VS Actual-MBD *****************
subplot(2, 2, 2);
plot(FittedMBD(:, 1), FittedMBD(:,[2,5]));
legend('Actual-MBD', 'Fitted-MBD', 'Location','NorthWest');
title('��ϵĶ�̬����');
Xaxis = linspace(FittedMBD(1,1), FittedMBD(end,1), 8);
set(gca, 'xtick', Xaxis);
set(gca,'xticklabel',datestr(Xaxis,'yyyy/mm/dd'));
% ************ Smoothed-Fitted-MBD VS Actual-MBD ************
subplot(2, 2, 4);
[Curve, ~] = fit(FittedMBD(:,1), FittedMBD(:,5), 'smoothingspline', 'SmoothingPara', 0.01);
plot(FittedMBD(:, 1), [FittedMBD(:,2), feval(Curve, FittedMBD(:, 1))]);
legend('Actual-MBD', 'Smoothed-Fitted-MBD', 'Location','NorthWest');
title('��ϵĶ�̬����');
Xaxis = linspace(FittedMBD(1,1), FittedMBD(end,1), 8);
set(gca, 'xtick', Xaxis);
set(gca,'xticklabel',datestr(Xaxis,'yyyy/mm/dd'));
% ################################## Module Five: �ز� ####################################
w.close();