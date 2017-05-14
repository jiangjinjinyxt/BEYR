% 计算SharpeRatio的函数
% 输入的第一个参数是价格或收益率序列,第二个参数是输入序列的类型(1:收益率序列, 其他:价格序列)
% 返回值是年化夏普比率(rf = 0)
function SR = SharpeRatio(Data, type)
% type == 1 收益率序列
if type ~= 1
    Data = Data(2:end) ./ Data(1:end-1) - 1;
end
SR = mean(Data)*(252^0.5) / std(Data);
end