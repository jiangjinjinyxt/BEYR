% ���۸�����ת��Ϊ���������еĺ���
% ����Ĳ����Ǽ۸�����
% ���ص�������������(��������۸�������ͬ,��һ�е�������0���)
function Data = Value2Return(Data)
Data = Data(2:end,:) ./ Data(1:end-1, :) - 1;
Data = [zeros(1, size(Data, 2)); Data];
end