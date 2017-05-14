% ��ծȯָ��һ��ʱ�����������ʷ�ϵķ�λ����Ϊ�ο�, �껯�ĳ��������������1.50%����; �Ϻõ�Window Size = 5��10��; 
% PeriodReturn = Period Return of Bond; Use All Historical Data Before Today To Compute Quantile

%% ####################################### Algorithm #######################################
% Step1: ����PeriodReturn����PeriodReturnIndex, ���췽��:�����PeriodReturnIndex = �����PeriodReturn���ڹ�ȥ���е�PeriodReturn���ݹ��ɵ������ķ�λ��
% Step2: ��ѵ�����ݼ����ع�, �Ա��� = PeriodReturnIndex; ����� = �ͺ�һ�׵�MBD, �õ�����Quantile��MBD�ĺ���;
% Step3: ����ѵ�����Ļع麯�������Լ��е�PeriodReturnIndex������, �õ�Fitted-MBD����,��ʾ��һ�����յľ���
% Setp4: ����Ԥ���MBD����,���лز�.   
%         �ز������ÿ�����棺
%         if FittedMBD > 4
%            return = �����ʲ���return * FittedMBD - (FittedMBD - 4) * �������� / 4
%         else
%            return = �����ʲ���return * FittedMBD + (4 - FittedMBD) * ������� / 4
% ####################################### Algorithm #######################################

%% ##################################### Applications ######################################
% Application #1
% ����ѡȡ������: PeriodReturn = 037.CS���Period���������;   
% Step1: ����PeriodReturnIndex, Period = 5/10/22/44, �����PeriodReturnIndex = �����PeriodReturn�������е�PeriodReturn���ݹ��ɵ������ķ�λ��
% Step2: ѵ���������� = [2006-01-01, 2015-12-31], �Ա��� = PeriodReturnIndex; ����� = �ͺ�һ�׵�MBD, �õ�����Quantile��MBD�ĺ���;
% Step3: ���Լ������� = [2016-01-01, 2016-12-31], ����ѵ�����Ļع麯��, ���Լ��е�PeriodReturnIndex������, �õ�Ԥ���MBD����
% Setp4: ����Ԥ���MBD����, ���лز�, ���ڻز�Ļ����ʲ���037.CS, ������ʺʹ������ʶ���DR007.IB
% ******************** �ز��� *****************************
% *** Period   �껯����  �껯��������  ���ձ���  ���س�   ***
% ***   5        3.00%      2.14%       1.75    2.95%    ***
% ***   10       2.67%      1.81%       1.60    2.65%    ***
% ***   22       2.43%      1.57%       1.47    2.37%    ***
% ***   44       1.94%      1.07%       1.08    2.61%    ***
% **********************************************************
% Application #2
% ����ѡȡ������: PeriodReturn = 037.CS���Period���������;           
% Step1: Period = 5/10/22/44
% Step2: ѵ���������� = [2006-01-01, 2010-12-31]
% Step3: ���Լ������� = [2011-01-01, 2016-12-31]
% Setp4: �����ʲ���037.CS, ������ʺʹ������ʶ���DR007.IB
% ******************** �ز��� *****************************
% *** Period   �껯����  �껯��������  ���ձ���  ���س�   ***
% ***   5        5.86%      1.80%       3.29    3.25%    ***
% ***   10       5.58%      1.52%       3.10    3.44%    ***
% ***   22       5.57%      1.51%       2.95    2.87%    ***
% ***   44       5.34%      1.28%       2.76    3.33%    ***
% **********************************************************
% Application #3
% ����ѡȡ������: PeriodReturn = 037.CS���Period���������;          
% Step1: Period = 5/10/22/44
% Step2: ѵ���������� = [2011-01-01, 2016-12-31]
% Step3: ���Լ������� = [2006-01-01, 2010-01-01]
% Setp4: �����ʲ���037.CS, ������ʺʹ������ʶ���DR007.IB
% ******************** �ز��� *****************************
% *** Period   �껯����  �껯��������  ���ձ���  ���س�   ***
% ***   5        4.75%      1.69%       2.09    2.89%    ***
% ***   10       4.93%      1.88%       2.16    2.44%    ***
% ***   22       5.12%      2.06%       2.14    2.94%    ***
% ***   44       5.25%      2.19%       2.18    3.68%    ***
% **********************************************************
% ##################################### Applications ######################################

%% ######################################## �ο�ָ�� ########################################
% #(1) AssetBenchmark  ���ڲ��Բ���Ч���Ļ����ʲ�                    
% #       ��ծ�ܲƸ�:037.CS    038.CS:��ծ��ծ     039.CS:��ծ���м��ծ             
% #       ��ծ��ҵծ:054.CS    060.CS:��ծ����ծ   066.CS:��ծ����ծ                 
% #(2) AssetBond  ����ѵ����ծȯ���ݴ���                       
% #       ��ծ�ܲƸ�:037.CS    038.CS:��ծ��ծ     039.CS:��ծ���м��ծ             
% #       ��ծ��ҵծ:054.CS    060.CS:��ծ����ծ   066.CS:��ծ����ծ 
% #(3) DepositRate  �������
% #       �����7����Ѻʽ�ع�����: DR007.IB
% #(4) LendingRate  ��������
% #       �����7����Ѻʽ�ع�����: DR007.IB
% ######################################## �ο�ָ�� ########################################
%%
clc; clear; format compact;
w = windmatlab;
load('MBD.mat'); DataMBD = MBD; AverageMBD = 4;
[AssetBenchmark, DepositRate, LendingRate, AssetBond] = deal('037.CS', 'DR007.IB', 'DR007.IB', '037.CS');
Period = 5; % ����Period Return��ʱ�䳤��
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
[StartDate, EndDate, TrainStartDate, TrainEndDate, TestStartDate, TestEndDate] = deal(datenum(StartDate),datenum(EndDate), datenum(TrainStartDate), datenum(TrainEndDate), datenum(TestStartDate), datenum(TestEndDate));
% ################################## Module One: ��ȡ���� ##################################

%% ################################# Module Two: ͳһ���ݸ�ʽ ###############################
% �������ݸ�ʽ����Ϊ: ��һ�б�ʾʱ��,�ڶ��б�ʾ��Ӧ������
DataBenchmark = [BenchmarkTimes, DataBenchmark/100];
DataDeposit = [DepositTimes, DataDeposit/365/100];
DataLending = [LendingTimes, DataLending/365/100];
DataBond = [BondTimes, DataBond];
DataPeriodReturn = DataBond;
% ################################ Module Two: ͳһ���ݸ�ʽ ################################

%% ############################## Module Three: ����Quantile ###############################
% ����PeriodReturn����ʷ�������ķ�λ��
QuantileNums = 10;
for i = QuantileNums+1:size(DataPeriodReturn, 1)
    %DataPeriodReturn��һ������������,�ڶ����Ƕ�Ӧ��PeriodReturn������,�������Ƕ�Ӧ��Quantile������
    DataPeriodReturn(i,3) = GetQuantileIndex(DataPeriodReturn(i,2),  DataPeriodReturn(1:i-1,2), QuantileNums);
end
DataPeriodReturnIndex = DataPeriodReturn(:,[1,3]);
% ############################## Module Three: ����Quantile ###############################

%% ################################ Module Four: �ع���� ##################################
% �Ա���: Quantile, �����: MBD
% Data�ĵ�һ��������,�ڶ�����Quantile,��������MBD
Data = IndexMatch(DataPeriodReturnIndex, DataMBD, 'inner');
TrainData = Data(Data(:,1) >= TrainStartDate & Data(:,1) <= TrainEndDate, [2, 3]);
% ��Quantile���ݺ��ͺ�һ���MBD�������ع�(����: ���ݵ�������ʱPeriodReturn��Quantile, �����ڶ����Duration)
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
DataPeriodReturnIndex(:, 3) = feval(Curve, DataPeriodReturnIndex(:, 2));
FittedAll = IndexMatch(Data(:,[1,3]), DataPeriodReturnIndex, 'right');
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