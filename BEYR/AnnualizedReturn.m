% �����껯�����ʵĺ���
% ����ĵ�һ�������Ǽ۸������������(n*2������,��һ��������),�ڶ����������������е�����(1:����������, ����:�۸�����)
% ����ֵ���껯������
function AR = AnnualizedReturn(Data, type)
% type == 1, ��ʾ�����Data������������
if type == 1
    Data(:,2) = Return2Value(Data(:,2));
    Data = [ones(1, 2); Data];
    Data(1,1) = 2 * Data(2, 1) - Data(3, 1);
end
AR = (Data(end, 2) / Data(1, 2)) ^ (365 / (Data(end, 1) - Data(1, 1))) - 1;
end