% 计算年化超额收益率的函数
% 输入的第一个参数是参考的基准序列(n*2的序列,第一列是日期),第二个参数是对应资产的序列(n*2的序列,第一列是日期),第一个序列和第二个序列的类型要相同,第三个参数是输入序列的类型(1:收益率序列, 其他:价格序列)
% 返回值是年化超额收益率
function AER = AnnualizedExcessReturn(DataBenchmark, Data, type)
% type == 1, 表示输入的Data是收益率序列
AR1 = AnnualizedReturn(DataBenchmark, type);
AR2 = AnnualizedReturn(Data, type);
AER = AR2 - AR1;
end