% ������������ת��Ϊ��ֵ���еĺ���
% ����Ĳ���������������
% ���ص��Ǿ�ֵ����(��������۸�������ͬ)
function Data = Return2Value(Data)
Data = Data + 1;
for i=2:size(Data, 1)
    Data(i,:) = Data(i,:) .* Data(i - 1,:);
end
end
