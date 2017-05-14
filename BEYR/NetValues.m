% ��������ϵ�MBD����Ͷ�ʵĲ�������;�ֵ
%
% ���������5��,��һ���ǲ�����һ����ά����(��ϵ�MBD),����ĵ�һ��������,�ڶ����Ƕ�Ӧ��MBD
%              �ڶ����ǲ�����һ����ֵ,����ÿ��ƽ����MBD
%              ������������һ����ά����(������Ͷ�ʵĻ����ʲ�),����ĵ�һ��������,�ڶ����ǻ����ʲ�ÿ���������
%              ���ĸ�������һ����ά����(�������),����ĵ�һ��������,�ڶ�����ÿ���Ӧ�Ĵ������
%              �����������һ����ά����(��������),����ĵ�һ��������,�ڶ�����ÿ���Ӧ�Ĵ�������

% ����ƥ��: �������ݰ��յ�һ������������ƥ��,���ڻ����ʲ�����������,��0����Ӧ������Ϊ�յ�ֵ;���ڴ���������,��ǰ����������
%          (����ƥ�䷽ʽ��˵��,�ɲο�m�ļ� "IndexMatch.m")
% ����ÿ��������ʵļ���:(��ͨ�ú���)
% (1)������� FittedMBD > AverageMBD, ����Ҫ���������߾���,���ɱ�Ϊ����Ĵ�������
%    ���Ե���������� = (FittedMBD * �����ʲ������������ - (FittedMBD - AverageMBD) * ��������)/AverageMBD
% (2)������� FittedMBD < AverageMBD, ����Ҫ�������Ǯ���ȥ,�������Ϊ����Ĵ������
%    ���Ե���������� = (FittedMBD * �����ʲ������������ + (AverageMBD - FittedMBD) * �������)/AverageMBD
%
% ���صĲ���������,��һ������DailyReturns������л����ʲ��Ͷ�̬����MBD���Ե�������������
%                 DailyReturns�ĵ�һ��Ϊ����,�ڶ���Ϊ���л����ʲ���������������,������Ϊ���Ե�������������
%                 �ڶ�������DailyNetValues������л����ʲ��Ͷ�̬����MBD���Ե��ۼƾ�ֵ����
%                 DailyNetValues�ĵ�һ��Ϊ����,�ڶ���Ϊ���л����ʲ����ۼƾ�ֵ,������Ϊ���Ե��ۼƾ�ֵ
function [DailyReturns, DailyNetValues] = NetValues(FittedMBD, AverageMBD, DataBenchmark, DataDeposit, DataLending)
Data = FillNaN(FillNaN(IndexMatch(FittedMBD, IndexMatch(DataDeposit, DataLending, 'outer'), 'left'), 'ffill'), 'bfill');
Data = FillNaN(IndexMatch(Data, DataBenchmark, 'left'), 0);
% ��һ��: ����
% �ڶ���: MBD
% ������: �������
% ������: ��������
% ������: �����ʲ�������������
MoreIndex = Data(:, 2) > 4;
LessIndex = Data(:, 2) <= 4;
Data(MoreIndex, 6) = (Data(MoreIndex, 2) .* Data(MoreIndex, 5) - (Data(MoreIndex, 2) - AverageMBD) .* Data(MoreIndex, 4)) / 4;
Data(LessIndex, 6) = (Data(LessIndex, 2) .* Data(LessIndex, 5) - (Data(LessIndex, 2) - AverageMBD) .* Data(LessIndex, 3)) / 4;
DailyReturns = Data(:, [1, 5, 6]);
DailyNetValues = DailyReturns(:,[2,3]) + 1;
for i = 2:size(DailyNetValues, 1)
    DailyNetValues(i, :) = DailyNetValues(i, :) .* DailyNetValues(i - 1, :);
end
DailyNetValues = [DailyReturns(:,1), DailyNetValues];
end
