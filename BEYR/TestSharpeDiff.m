% ��ծȯָ��һ��ʱ���SharpeRatio�͹�Ʊָ��һ��ʱ���SharpeRatio������ʷ�������ķ�λ����Ϊ�ο�,
% �껯�ĳ�����������ѵ�����Ͳ��Լ���ѡȡ,�Ƚϲ��ȶ�; �ۺ�����,��10�����������м����SharpeRatio�Ĳ���Ϊ�ο��ĳ�����������ձ��ʽϸ�;
% SRDiff = Period SharpeRatio of Bond - Period SharpeRatio of Equity; Use All Historical Data Before Today To Compute Quantile

%% ####################################### Algorithm #######################################
% Step1: ����SRDiff����SRDiffIndex, ���췽��:�����SRDiffIndex = �����SRDiff���ڹ�ȥ���е�SRDiff���ݹ��ɵ������ķ�λ��
% Step2: ��ѵ�����ݼ����ع�, �Ա��� = SRDiffIndex; ����� = �ͺ�һ�׵�MBD, �õ�����Quantile��MBD�ĺ���;
% Step3: ����ѵ�����Ļع麯�������Լ��е�SRDiffIndex������, �õ�Fitted-MBD����,��ʾ��һ�����յľ���
% Setp4: ����Ԥ���MBD����,���лز�.   
%         �ز������ÿ�����棺
%         if FittedMBD > 4
%            return = �����ʲ���return * FittedMBD - (FittedMBD - 4) * �������� / 4
%         else
%            return = �����ʲ���return * FittedMBD + (4 - FittedMBD) * ������� / 4
% ####################################### Algorithm #######################################

%% ##################################### Applications ######################################
% Application #1
% ����ѡȡ������: SRDiff = 037.CS���Period������ձ��� - �������ָ�����Period������ձ���;            
% Step1: ����SRDiffIndex, Period = 5/10/22/44/66, �����SRDiffIndex = �����SRDiff�������е�SRDiff���ݹ��ɵ������ķ�λ��
% Step2: ѵ���������� = [2006-01-01, 2015-12-31], �Ա��� = SRDiffIndex; ����� = �ͺ�һ�׵�MBD, �õ�����Quantile��MBD�ĺ���;
% Step3: ���Լ������� = [2016-01-01, 2016-12-31], ����ѵ�����Ļع麯��, ���Լ��е�SRDiffIndex������, �õ�Ԥ���MBD����
% Setp4: ����Ԥ���MBD����, ���лز�, ���ڻز�Ļ����ʲ���037.CS, ������ʺʹ������ʶ���DR007.IB
% ******************** �ز��� *****************************
% *** Period   �껯����  �껯��������  ���ձ���  ���س�   ***
% ***   5        2.48%      1.61%       1.39    3.06%    ***
% ***   10       3.04%      2.17%       1.86    2.45%    ***
% ***   22       2.48%      1.61%       1.56    2.23%    ***
% ***   44       2.41%      1.55%       1.57    2.03%    ***
% ***   66       1.98%      1.11%       1.18    2.60%    ***
% **********************************************************
% Application #2
% ����ѡȡ������: SRDiff = 037.CS���Period������ձ��� - �������ָ�����Period������ձ���;                      
% Step1: Period = 5/10/22/44/66
% Step2: ѵ���������� = [2006-01-01, 2010-12-31]
% Step3: ���Լ������� = [2011-01-01, 2016-12-31]
% Setp4: �����ʲ���037.CS, ������ʺʹ������ʶ���DR007.IB
% ******************** �ز��� *****************************
% *** Period   �껯����  �껯��������  ���ձ���  ���س�   *** 
% ***   5        4.83%      0.77%       2.99    3.58%    ***
% ***   10       4.96%      0.90%       3.07    3.49%    ***
% ***   22       4.71%      0.65%       2.80    3.38%    ***
% ***   44       4.66%      0.60%       2.75    2.93%    ***
% ***   66       4.46%      0.40%       2.64    3.39%    ***
% **********************************************************
% Application #3
% ����ѡȡ������: SRDiff = 037.CS���Period������ձ��� - �������ָ�����Period������ձ���;          
% Step1: Period = 5/10/22/44/66
% Step2: ѵ���������� = [2011-01-01, 2016-12-31]
% Step3: ���Լ������� = [2006-01-01, 2010-01-01]
% Setp4: �����ʲ���037.CS, ������ʺʹ������ʶ���DR007.IB
% ******************** �ز��� *****************************
% *** Period   �껯����  �껯��������  ���ձ���  ���س�   *** 
% ***   5        3.98%      0.93%       1.87    3.17%    ***
% ***   10       4.36%      1.31%       2.05    2.65%    ***
% ***   22       4.63%      1.57%       2.12    3.00%    ***
% ***   44       4.67%      1.62%       2.09    3.49%    ***
% ***   66       4.30%      1.25%       2.09    3.92%    ***
% **********************************************************
% ##################################### Applications ######################################

%% ######################################## �ο�ָ�� ########################################
% #(1) AssetBenchmark  ���ڲ��Բ���Ч���Ļ����ʲ�                    
% #       ��ծ�ܲƸ�:037.CS    038.CS:��ծ��ծ     039.CS:��ծ���м��ծ             
% #       ��ծ��ҵծ:054.CS    060.CS:��ծ����ծ   066.CS:��ծ����ծ                 
% #(2) AssetBond  ����ѵ����ծȯ���ݴ���                       
% #       ��ծ�ܲƸ�:037.CS    038.CS:��ծ��ծ     039.CS:��ծ���м��ծ             
% #       ��ծ��ҵծ:054.CS    060.CS:��ծ����ծ   066.CS:��ծ����ծ 
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
[AssetBenchmark, DepositRate, LendingRate, AssetBond, AssetEquity] = deal('037.CS', 'DR007.IB', 'DR007.IB', '037.CS', '882115.WI');
Period = 66; % ����Period SharpeRatio��ʱ�䳤��

%% ################################## Module One: ��ȡ���� ##################################
% (1) StartDate:���ݵ���ʼʱ��     EndDate:���ݵĽ�ֹʱ��           
% ������ȡ���ݵ���ʼ�ͽ�ֹʱ��,һ���Դ�Wind���ݿ���ȡ�����п�����Ҫ������,������淴����ȡ
% (2) TrainStartDate:ѵ�����ݵ���ʼʱ��  TrainEndDate:ѵ�����ݵĽ�ֹʱ��
% (3) TestStartDate:�������ݵ���ʼʱ��   TestEndDate:�������ݵĽ�ֹʱ��
[StartDate, EndDate, TrainStartDate, TrainEndDate, TestStartDate, TestEndDate] = deal('2005-01-01', '2017-01-09', '2006-01-01', '2010-12-31', '2011-01-01', '2016-12-31');
[DataBenchmark, ~, ~, BenchmarkTimes] = w.wsd(AssetBenchmark, 'PCT_CHG', StartDate, EndDate);
[DataDeposit, ~, ~, DepositTimes] = w.wsd(DepositRate, 'close', StartDate, EndDate);
[DataLending, ~, ~, LendingTimes] = w.wsd(LendingRate, 'close', StartDate, EndDate);
[DataBond, ~, ~, BondTimes] = w.wsd(AssetBond, 'PCT_CHG', StartDate, EndDate);
[DataEquity, ~, ~, EquityTimes] = w.wsd(AssetEquity, 'PCT_CHG', StartDate, EndDate);
[StartDate, EndDate, TrainStartDate, TrainEndDate, TestStartDate, TestEndDate] = deal(datenum(StartDate),datenum(EndDate), datenum(TrainStartDate), datenum(TrainEndDate), datenum(TestStartDate), datenum(TestEndDate));
% ################################## Module One: ��ȡ���� ##################################

%% ################################# Module Two: ͳһ���ݸ�ʽ ###############################
% �������ݸ�ʽ����Ϊ: ��һ�б�ʾʱ��,�ڶ��б�ʾ��Ӧ������
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
% ################################ Module Two: ͳһ���ݸ�ʽ ################################

%% ############################## Module Three: ����Quantile ###############################
% ����SRDiff����ʷ�����ķ�λ��
QuantileNums = 10;
for i = QuantileNums+1:size(DataSRDiff, 1)
    %DataSRDiff��һ������������,�ڶ����Ƕ�Ӧ��SRDiff������,�������Ƕ�Ӧ��Quantile������
    DataSRDiff(i,3) = GetQuantileIndex(DataSRDiff(i,2),  DataSRDiff(1:i-1,2), QuantileNums);
end
DataSRDiffIndex = DataSRDiff(:,[1,3]);
% ############################## Module Three: ����Quantile ###############################

%% ################################ Module Four: �ع���� ##################################
% �Ա���: Quantile, �����: MBD
% Data�ĵ�һ��������,�ڶ�����Quantile,��������MBD
Data = IndexMatch(DataSRDiffIndex, DataMBD, 'inner');
TrainData = Data(Data(:,1) >= TrainStartDate & Data(:,1) <= TrainEndDate, [2, 3]);
% ��Quantile���ݺ��ͺ�һ���MBD�������ع�(����: ���ݵ�������ʱSRDiff��Quantile, �����ڶ����Duration)
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
% ################################ Module Four: �ع���� ##################################

%% ################################## Module Five: �ز� ####################################
DataSRDiffIndex(:, 3) = feval(Curve, DataSRDiffIndex(:, 2));
FittedAll = IndexMatch(Data(:,[1,3]), DataSRDiffIndex, 'right');
FittedAll(2:end,4) = FittedAll(1:end-1,4);
FittedMBD = FittedAll(FittedAll(:,1) >= TestStartDate & FittedAll(:,1) <= TestEndDate,:);
% FittedMBD��FittedAll�ĵ�һ��Ϊ����,�ڶ���Ϊʵ�ʵ�MBD,������Ϊ��Ӧ��QuantileIndex,������Ϊ��ϵ�MBD
[DailyReturns, DailyValues] = NetValues(FittedMBD(:,[1,4]), AverageMBD, DataBenchmark, DataDeposit, DataLending);
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
plot(FittedMBD(:, 1), FittedMBD(:,[2,4]));
legend('Actual-MBD', 'Fitted-MBD', 'Location','NorthWest');
title('��ϵĶ�̬����');
Xaxis = linspace(FittedMBD(1,1), FittedMBD(end,1), 8);
set(gca, 'xtick', Xaxis);
set(gca,'xticklabel',datestr(Xaxis,'yyyy/mm/dd'));
% ************ Smoothed-Fitted-MBD VS Actual-MBD ************
subplot(2, 2, 4);
[Curve, ~] = fit(FittedMBD(:,1), FittedMBD(:,4), 'smoothingspline', 'SmoothingPara', 0.01);
plot(FittedMBD(:, 1), [FittedMBD(:,2), feval(Curve, FittedMBD(:, 1))]);
legend('Actual-MBD', 'Smoothed-Fitted-MBD', 'Location','NorthWest');
title('��ϵĶ�̬����');
Xaxis = linspace(FittedMBD(1,1), FittedMBD(end,1), 8);
set(gca, 'xtick', Xaxis);
set(gca,'xticklabel',datestr(Xaxis,'yyyy/mm/dd'));
% ################################## Module Five: �ز� ####################################
w.close();