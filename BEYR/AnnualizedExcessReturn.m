% �����껯���������ʵĺ���
% ����ĵ�һ�������ǲο��Ļ�׼����(n*2������,��һ��������),�ڶ��������Ƕ�Ӧ�ʲ�������(n*2������,��һ��������),��һ�����к͵ڶ������е�����Ҫ��ͬ,�������������������е�����(1:����������, ����:�۸�����)
% ����ֵ���껯����������
function AER = AnnualizedExcessReturn(DataBenchmark, Data, type)
% type == 1, ��ʾ�����Data������������
AR1 = AnnualizedReturn(DataBenchmark, type);
AR2 = AnnualizedReturn(Data, type);
AER = AR2 - AR1;
end