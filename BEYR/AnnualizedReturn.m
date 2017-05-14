% 计算年化收益率的函数
% 输入的第一个参数是价格或收益率序列(n*2的序列,第一列是日期),第二个参数是输入序列的类型(1:收益率序列, 其他:价格序列)
% 返回值是年化收益率
function AR = AnnualizedReturn(Data, type)
% type == 1, 表示输入的Data是收益率序列
if type == 1
    Data(:,2) = Return2Value(Data(:,2));
    Data = [ones(1, 2); Data];
    Data(1,1) = 2 * Data(2, 1) - Data(3, 1);
end
AR = (Data(end, 2) / Data(1, 2)) ^ (365 / (Data(end, 1) - Data(1, 1))) - 1;
end