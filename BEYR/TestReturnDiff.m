% ��ծȯָ��һ��ʱ�������͹�Ʊָ��һ��ʱ������������ʷ�������ķ�λ����Ϊ�ο�, �������Ľ��������,�껯�ĳ��������������0.50%����;
% RDiff = Period Return of Bond - Period Return of Equity; Use All Historical Data Before Today To Compute Quantile

%% ####################################### Algorithm #######################################
% Step1: ����RDiff����RDiffIndex, ���췽��:�����RDiffIndex = �����RDiff���ڹ�ȥ���е�RDiff���ݹ��ɵ������ķ�λ��
% Step2: ��ѵ�����ݼ����ع�, �Ա��� = RDiffIndex; ����� = �ͺ�һ�׵�MBD, �õ�����Quantile��MBD�ĺ���;
% Step3: ����ѵ�����Ļع麯�������Լ��е�RDiffIndex������, �õ�Fitted-MBD����,��ʾ��һ�����յľ���
% Setp4: ����Ԥ���MBD����,���лز�.   
%         �ز������ÿ�����棺
%         if FittedMBD > 4
%            return = �����ʲ���return * FittedMBD - (FittedMBD - 4) * �������� / 4
%         else
%            return = �����ʲ���return * FittedMBD + (4 - FittedMBD) * ������� / 4
% ####################################### Algorithm #######################################

%% ##################################### Applications ######################################
% Application #1
% ����ѡȡ������: RDiff = 037.CS���Period��������� - �������ָ�����Period���������;            
% Step1: ����RDiffIndex, Period = 5/10/22/44/66, �����RDiffIndex = �����RDiff�������е�RDiff���ݹ��ɵ������ķ�λ��
% Step2: ѵ���������� = [2006-01-01, 2015-12-31], �Ա��� = RDiffIndex; ����� = �ͺ�һ�׵�MBD, �õ�����Quantile��MBD�ĺ���;
% Step3: ���Լ������� = [2016-01-01, 2016-12-31], ����ѵ�����Ļع麯��, ���Լ��е�RDiffIndex������, �õ�Ԥ���MBD����
% Setp4: ����Ԥ���MBD����, ���лز�, ���ڻز�Ļ����ʲ���037.CS, ������ʺʹ������ʶ���DR007.IB
% ******************** �ز��� *****************************
% *** Period   �껯����  �껯��������  ���ձ���  ���س�   ***
% ***   5        1.07%      0.20%       0.50    3.90%    ***
% ***   10       1.20%      0.33%       0.56    3.92%    ***
% ***   22       1.37%      0.50%       0.71    3.49%    ***
% ***   44       1.44%      0.58%       0.75    3.55%    ***
% ***   66       1.04%      0.17%       0.50    3.79%    ***
% **********************************************************
% Application #2
% ����ѡȡ������: RDiff = 037.CS���Period��������� - �������ָ�����Period���������;                      
% Step1: Period = 5/10/22/44/66
% Step2: ѵ���������� = [2006-01-01, 2010-12-31]
% Step3: ���Լ������� = [2011-01-01, 2016-12-31]
% Setp4: �����ʲ���037.CS, ������ʺʹ������ʶ���DR007.IB
% ******************** �ز��� *****************************
% *** Period   �껯����  �껯��������  ���ձ���  ���س�   *** 
% ***   5        3.92%     -0.14%       2.42    4.50%    ***
% ***   10       4.11%      0.05%       2.49    4.60%    ***
% ***   22       4.02%     -0.05%       2.53    4.67%    ***
% ***   44       3.97%     -0.10%       2.53    4.08%    ***
% ***   66       3.81%     -0.25%       2.37    4.55%    ***
% **********************************************************
% Application #3
% ����ѡȡ������: RDiff = 037.CS���Period��������� - �������ָ�����Period���������;          
% Step1: Period = 5/10/22/44/66
% Step2: ѵ���������� = [2011-01-01, 2016-12-31]
% Step3: ���Լ������� = [2006-01-01, 2010-01-01]
% Setp4: �����ʲ���037.CS, ������ʺʹ������ʶ���DR007.IB
% ******************** �ز��� *****************************
% *** Period   �껯����  �껯��������  ���ձ���  ���س�   *** 
% ***   5        3.14%      0.09%       1.49    3.55%    ***
% ***   10       3.06%      0.00%       1.48    3.58%    ***
% ***   22       3.17%      0.12%       1.55    3.51%    ***
% ***   44       3.33%      0.27%       1.55    3.65%    ***
% ***   66       4.32%      1.26%       1.56    3.74%    ***
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
Period = 66; % ����Period Return��ʱ�䳤��
%% ################################## Module One: ��ȡ���� ##################################
% (1) StartDate:���ݵ���ʼʱ��     EndDate:���ݵĽ�ֹʱ��           
% ������ȡ���ݵ���ʼ�ͽ�ֹʱ��,һ���Դ�Wind���ݿ���ȡ�����п�����Ҫ������,������淴����ȡ
% (2) TrainStartDate:ѵ�����ݵ���ʼʱ��  TrainEndDate:ѵ�����ݵĽ�ֹʱ��
% (3) TestStartDate:�������ݵ���ʼʱ��   TestEndDate:�������ݵĽ�ֹʱ��
[StartDate, EndDate, TrainStartDate, TrainEndDate, TestStartDate, TestEndDate] = deal('2005-01-01', '2017-01-09', '2006-01-01', '2010-12-31', '2011-01-01', '2016-12-31');
[DataBenchmark, ~, ~, BenchmarkTimes] = w.wsd(AssetBenchmark, 'PCT_CHG', StartDate, EndDate);
[DataDeposit, ~, ~, DepositTimes] = w.wsd(DepositRate, 'close', StartDate, EndDate);
[DataLending, ~, ~, LendingTimes] = w.wsd(LendingRate, 'close', StartDate, EndDate);
[DataBond, ~, ~, BondTimes] = w.wsd(AssetBond, 'close', StartDate, EndDate, 'PriceAdj=F');
DataBond = DataBond(Period + 1:end) ./  DataBond(1:end-Period) - 1; BondTimes = BondTimes(Period + 1:end);
[DataEquity, ~, ~, EquityTimes] = w.wsd(AssetEquity, 'close', StartDate, EndDate, 'PriceAdj=F');
DataEquity = DataEquity(Period + 1:end) ./ DataEquity(1:end-Period) - 1; EquityTimes = EquityTimes(Period + 1:end);
[StartDate, EndDate, TrainStartDate, TrainEndDate, TestStartDate, TestEndDate] = deal(datenum(StartDate),datenum(EndDate), datenum(TrainStartDate), datenum(TrainEndDate), datenum(TestStartDate), datenum(TestEndDate));
% ################################## Module One: ��ȡ���� ##################################

%% ################################# Module Two: ͳһ���ݸ�ʽ ###############################
% �������ݸ�ʽ����Ϊ: ��һ�б�ʾʱ��,�ڶ��б�ʾ��Ӧ������
DataBenchmark = [BenchmarkTimes, DataBenchmark/100];
DataDeposit = [DepositTimes, DataDeposit/365/100];
DataLending = [LendingTimes, DataLending/365/100];
DataBond = [BondTimes, DataBond];
DataEquity = [EquityTimes, DataEquity];
DataReference = IndexMatch(DataBond, DataEquity, 'inner');
DataRDiff = [DataReference(:,1), DataReference(:,2) - DataReference(:,3)];
% ################################ Module Two: ͳһ���ݸ�ʽ ################################

%% ############################## Module Three: ����Quantile ###############################
% ����RDiff����ʷ�������ķ�λ��
QuantileNums = 10;
for i = 11:size(DataRDiff, 1)
    %DataRDiff��һ������������,�ڶ����Ƕ�Ӧ��RDiff������,�������Ƕ�Ӧ��Quantile������
    DataRDiff(i,3) = GetQuantileIndex(DataRDiff(i,2),  DataRDiff(1:i-1,2), QuantileNums);
end
DataRDiffIndex = DataRDiff(:,[1,3]);
% ############################## Module Three: ����Quantile ###############################

%% ################################ Module Four: �ع���� ##################################
% �Ա���: Quantile, �����: MBD
% Data�ĵ�һ��������,�ڶ�����Quantile,��������MBD
Data = IndexMatch(DataRDiffIndex, DataMBD, 'inner');
TrainData = Data(Data(:,1) >= TrainStartDate & Data(:,1) <= TrainEndDate, [2, 3]);
% ��Quantile���ݺ��ͺ�һ���MBD�������ع�(����: ���ݵ�������ʱRDiff��Quantile, �����ڶ����Duration)
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
DataRDiffIndex(:, 3) = feval(Curve, DataRDiffIndex(:, 2));
FittedAll = IndexMatch(Data(:,[1,3]), DataRDiffIndex, 'right');
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