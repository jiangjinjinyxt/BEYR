% 返回指定数据在参照数据集所处的分位点
% 第一个参数Data是给定的某个数据,是一个值
% 第二个参数DataList是参照的数据集,是一个行列式
% 将DataList按照linspace(0, 1, QuantileNums + 1)划分为QuantileNums个区间
% 返回值为Data所处的区间
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
