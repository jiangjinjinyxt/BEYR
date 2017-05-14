% 将价格序列转换为收益率序列的函数
% 输入的参数是价格序列
% 返回的是收益率序列(行列数与价格序列相同,第一行的数据用0填充)
function Data = Value2Return(Data)
Data = Data(2:end,:) ./ Data(1:end-1, :) - 1;
Data = [zeros(1, size(Data, 2)); Data];
end