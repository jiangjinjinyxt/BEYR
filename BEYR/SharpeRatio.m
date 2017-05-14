% ����SharpeRatio�ĺ���
% ����ĵ�һ�������Ǽ۸������������,�ڶ����������������е�����(1:����������, ����:�۸�����)
% ����ֵ���껯���ձ���(rf = 0)
function SR = SharpeRatio(Data, type)
% type == 1 ����������
if type ~= 1
    Data = Data(2:end) ./ Data(1:end-1) - 1;
end
SR = mean(Data)*(252^0.5) / std(Data);
end