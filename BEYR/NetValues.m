% 计算用拟合的MBD进行投资的策略收益和净值
%
% 输入参数有5个,第一个是参数是一个二维数组(拟合的MBD),数组的第一列是日期,第二列是对应的MBD
%              第二个是参数是一个数值,代表每天平均的MBD
%              第三个参数是一个二维数组(策略所投资的基础资产),数组的第一列是日期,第二列是基础资产每天的收益率
%              第四个参数是一个二维数组(存款利率),数组的第一列是日期,第二列是每天对应的存款利率
%              第五个参数是一个二维数组(贷款利率),数组的第一列是日期,第二列是每天对应的贷款利率

% 日期匹配: 所有数据按照第一个参数的索引匹配,对于基础资产收益率序列,用0填充对应的索引为空的值;对于存款、贷款利率,用前面的数据填充
%          (关于匹配方式的说明,可参考m文件 "IndexMatch.m")
% 策略每天的收益率的计算:(非通用函数)
% (1)若当天的 FittedMBD > AverageMBD, 则需要借款以满足高久期,借款成本为当天的贷款利率
%    策略当天的收益率 = (FittedMBD * 基础资产当天的收益率 - (FittedMBD - AverageMBD) * 贷款利率)/AverageMBD
% (2)若当天的 FittedMBD < AverageMBD, 则需要将多余的钱存出去,存款利率为当天的存款利率
%    策略当天的收益率 = (FittedMBD * 基础资产当天的收益率 + (AverageMBD - FittedMBD) * 存款利率)/AverageMBD
%
% 返回的参数有两个,第一个参数DailyReturns代表持有基础资产和动态调整MBD策略的日收益率序列
%                 DailyReturns的第一列为日期,第二列为持有基础资产的日收益率序列,第三列为策略的日收益率序列
%                 第二个参数DailyNetValues代表持有基础资产和动态调整MBD策略的累计净值序列
%                 DailyNetValues的第一列为日期,第二列为持有基础资产的累计净值,第三列为策略的累计净值
function [DailyReturns, DailyNetValues] = NetValues(FittedMBD, AverageMBD, DataBenchmark, DataDeposit, DataLending)
Data = FillNaN(FillNaN(IndexMatch(FittedMBD, IndexMatch(DataDeposit, DataLending, 'outer'), 'left'), 'ffill'), 'bfill');
Data = FillNaN(IndexMatch(Data, DataBenchmark, 'left'), 0);
% 第一列: 日期
% 第二列: MBD
% 第三列: 存款利率
% 第四列: 贷款利率
% 第五列: 基础资产日收益率序列
MoreIndex = Data(:, 2) > 4;
LessIndex = Data(:, 2) <= 4;
Data(MoreIndex, 6) = (Data(MoreIndex, 2) .* Data(MoreIndex, 5) - (Data(MoreIndex, 2) - AverageMBD) .* Data(MoreIndex, 4)) / 4;
Data(LessIndex, 6) = (Data(LessIndex, 2) .* Data(LessIndex, 5) - (Data(LessIndex, 2) - AverageMBD) .* Data(LessIndex, 3)) / 4;
DailyReturns = Data(:, [1, 5, 6]);
DailyNetValues = DailyReturns(:,[2,3]) + 1;
for i = 2:size(DailyNetValues, 1)
    DailyNetValues(i, :) = DailyNetValues(i, :) .* DailyNetValues(i - 1, :);
end
DailyNetValues = [DailyReturns(:,1), DailyNetValues];
end
