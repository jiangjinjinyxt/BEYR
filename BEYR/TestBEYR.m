% ��ծȯ��YTM�͹�Ʊָ����PE�ĳ˻��ڹ�ȥһ��ʱ��ķ�λ����Ϊ�ο�, �껯�ĳ��������������1.20%����; �Ϻõ�Window Size = 44; 
% BEYR = ծȯ��YTM * Ȩ���PE; Rolling Window;

%% ####################################### Algorithm #######################################
% Step1: ����BEYR����BEYRIndex, ���췽��:�����BEYRIndex = �����BEYR���ڹ�ȥĳһ��ʱ��(Rolling Window)��BEYR���ݹ��ɵ������ķ�λ��
% Step2: ��ѵ�����ݼ����ع�, �Ա��� = BEYRIndex; ����� = �ͺ�һ�׵�MBD, �õ�����Quantile��MBD�ĺ���;
% Step3: ����ѵ�����Ļع麯�������Լ��е�BEYRIndex������, �õ�Fitted-MBD����,��ʾ��һ�����յľ���
% Setp4: ����Ԥ���MBD����,���лز�.   
%         �ز������ÿ�����棺
%         if FittedMBD > 4
%            return = �����ʲ���return * FittedMBD - (FittedMBD - 4) * �������� / 4
%         else
%            return = �����ʲ���return * FittedMBD + (4 - FittedMBD) * ������� / 4
% ####################################### Algorithm #######################################

%% ##################################### Applications ######################################
% Application #1
% ����ѡȡ������: BEYR = 10���ծÿ�յ�YTM * �������ָ��ÿ�յ�PE;            
% Step1: ����BEYRIndex, Window = 22/44/66, �����BEYRIndex = �����BEYR���ڹ�ȥWindow�������յ�BEYR���ݹ��ɵ������ķ�λ��
% Step2: ѵ���������� = [2006-01-01, 2015-12-31], �Ա��� = BEYRIndex; ����� = �ͺ�һ�׵�MBD, �õ�����Quantile��MBD�ĺ���;
% Step3: ���Լ������� = [2016-01-01, 2016-12-31], ����ѵ�����Ļع麯��, ���Լ��е�BEYRIndex������, �õ�Ԥ���MBD����
% Setp4: ����Ԥ���MBD����, ���лز�, ���ڻز�Ļ����ʲ���037.CS, ������ʺʹ������ʶ���DR007.IB
% ******************** �ز��� *****************************
% *** Window   �껯����  �껯��������  ���ձ���  ���س�   *** 
% ***   22       2.68%      1.81%       1.58    2.71%    ***
% ***   44       2.49%      1.62%       1.44    2.81%    ***
% ***   66       2.26%      1.39%       1.27    2.82%    ***
% **********************************************************
% Application #2
% ����ѡȡ������: BEYR = 10���ծÿ�յ�YTM * �������ָ��ÿ�յ�PE;            
% Step1: Window = 22/44/66
% Step2: ѵ���������� = [2006-01-01, 2010-12-31]
% Step3: ���Լ������� = [2011-01-01, 2016-12-31]
% Setp4: �����ʲ���037.CS, ������ʺʹ������ʶ���DR007.IB
% ******************** �ز��� *****************************
% *** Window   �껯����  �껯��������  ���ձ���  ���س�   *** 
% ***   22       5.16%      1.10%       3.15    3.31%    ***
% ***   44       5.35%      1.29%       3.11    3.21%    ***
% ***   66       5.13%      1.07%       2.97    3.43%    ***
% **********************************************************
% Application #3
% ����ѡȡ������: BEYR = 10���ծÿ�յ�YTM * �������ָ��ÿ�յ�PE;            
% Step1: Window = 22/44/66
% Step2: ѵ���������� = [2011-01-01, 2016-12-31]
% Step3: ���Լ������� = [2006-01-01, 2010-01-01]
% Setp4: �����ʲ���037.CS, ������ʺʹ������ʶ���DR007.IB
% ******************** �ز��� *****************************
% *** Window   �껯����  �껯��������  ���ձ���  ���س�   *** 
% ***   22       4.26%      1.27%       1.88    3.09%    ***
% ***   44       4.32%      1.32%       1.88    3.32%    ***
% ***   66       4.48%      1.48%       1.89    3.42%    ***
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
% #       �������ָ��:882115.WI         ��֤50 :000016.SH    ��֤500:000905.SH      
% #       ���ȫAָ�� :881001.WI         ����300:000300.SH
% #(4) DepositRate  �������
% #       �����7����Ѻʽ�ع�����: DR007.IB
% #(5) LendingRate  ��������
% #       �����7����Ѻʽ�ع�����: DR007.IB
% ######################################## �ο�ָ�� ########################################
%%
clc; clear; format compact;
w = windmatlab;
load('MBD.mat'); DataMBD = MBD; AverageMBD = 4;
[AssetBenchmark, DepositRate, LendingRate, AssetBond, AssetEquity] = deal('037.CS', 'DR007.IB', 'DR007.IB', 'M1004267', '882115.WI');

%% ################################## Module One: ��ȡ���� ##################################
% (1) StartDate:���ݵ���ʼʱ��     EndDate:���ݵĽ�ֹʱ��           
% ������ȡ���ݵ���ʼ�ͽ�ֹʱ��,һ���Դ�Wind���ݿ���ȡ�����п�����Ҫ������,������淴����ȡ
% (2) TrainStartDate:ѵ�����ݵ���ʼʱ��  TrainEndDate:ѵ�����ݵĽ�ֹʱ��
% (3) TestStartDate:�������ݵ���ʼʱ��   TestEndDate:�������ݵĽ�ֹʱ��
[StartDate, EndDate, TrainStartDate, TrainEndDate, TestStartDate, TestEndDate] = deal('2005-01-01', '2017-01-09', '2006-01-01', '2010-12-31', '2011-01-01', '2016-12-31');
[DataBenchmark, ~, ~, BenchmarkTimes] = w.wsd(AssetBenchmark, 'PCT_CHG', StartDate, EndDate);
[DataDeposit, ~, ~, DepositTimes] = w.wsd(DepositRate, 'close', StartDate, EndDate);
[DataLending, ~, ~, LendingTimes] = w.wsd(LendingRate, 'close', StartDate, EndDate);
[DataBond, ~, ~, BondTimes] = w.edb(AssetBond, StartDate, EndDate, 'Fill=Previous');
[DataEquity, ~, ~, EquityTimes] = w.wsd(AssetEquity, 'pe', StartDate, EndDate, 'ruleType=10');
[StartDate, EndDate, TrainStartDate, TrainEndDate, TestStartDate, TestEndDate] = deal(datenum(StartDate),datenum(EndDate), datenum(TrainStartDate), datenum(TrainEndDate), datenum(TestStartDate), datenum(TestEndDate));
% ################################## Module One: ��ȡ���� ##################################

%% ################################# Module Two: ͳһ���ݸ�ʽ ###############################
% �������ݸ�ʽ����Ϊ: ��һ�б�ʾʱ��,�ڶ��б�ʾ��Ӧ������
DataBenchmark = [BenchmarkTimes,DataBenchmark/100];
DataDeposit = [DepositTimes, DataDeposit/365/100];
DataLending = [LendingTimes, DataLending/365/100];
DataBond = [BondTimes, DataBond];
DataEquity = [EquityTimes, DataEquity];
DataReference = IndexMatch(DataBond, DataEquity, 'inner');
DataBEYR = [DataReference(:,1), DataReference(:,2) .* DataReference(:,3)];
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
% ############################## Module Three: ����Quantile ###############################

%% ################################ Module Four: �ع���� ##################################
% �Ա���: Quantile, �����: MBD
% Data�ĵ�һ��������,�ڶ�����Quantile,��������MBD
Data = IndexMatch(DataBEYRIndex, DataMBD, 'inner');
TrainData = Data(Data(:,1) >= TrainStartDate & Data(:,1) <= TrainEndDate, [2, 3]);
% ��Quantile���ݺ��ͺ�һ���MBD�������ع�(����: ���ݵ�������ʱBEYR��Quantile, �����ڶ����Duration)
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
DataBEYRIndex(:, 3) = feval(Curve, DataBEYRIndex(:, 2));
FittedAll = IndexMatch(Data(:,[1,3]), DataBEYRIndex, 'right');
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