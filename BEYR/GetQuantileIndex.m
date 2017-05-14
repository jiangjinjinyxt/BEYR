% ����ָ�������ڲ������ݼ������ķ�λ��
% ��һ������Data�Ǹ�����ĳ������,��һ��ֵ
% �ڶ�������DataList�ǲ��յ����ݼ�,��һ������ʽ
% ��DataList����linspace(0, 1, QuantileNums + 1)����ΪQuantileNums������
% ����ֵΪData����������
function QuantileData = GetQuantileIndex(Data, DataList, QuantileNums)
Quantiles = quantile(DataList, linspace(0, 1, QuantileNums + 1));
for i = 2:QuantileNums
    if Data <= Quantiles(i)
        QuantileData = i - 1;
        break;
    end
end
if Data > Quantiles(QuantileNums)
    QuantileData = QuantileNums;
end
end
