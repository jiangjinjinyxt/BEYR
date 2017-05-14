% 将收益率序列转换为净值序列的函数
% 输入的参数是收益率序列
% 返回的是净值序列(行列数与价格序列相同)
function Data = Return2Value(Data)
Data = Data + 1;
for i=2:size(Data, 1)
    Data(i,:) = Data(i,:) .* Data(i - 1,:);
end
end
