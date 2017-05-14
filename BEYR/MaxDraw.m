% 计算最大回撤的函数
% 输入的第一个参数是收益率或价格序列,第二个参数是输入序列的类型(1:收益率序列, 其他:价格序列)
% 返回值是最大回撤(负数)
function Dat = MaxDraw(Data, type)
% typ2 == 1 收益率序列
if type == 1
    Data = Return2Value(Data);
end
MaxD = Data(1);
Dat = 0;
for i = 2:length(Data)
    if Data(i) < Data(i - 1)
        Draw = Data(i)/MaxD - 1;
        if Draw < Dat
            Dat = Draw;
        end
    elseif Data(i) > MaxD
        MaxD = Data(i);
    end
end
end