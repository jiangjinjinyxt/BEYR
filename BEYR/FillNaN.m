% 将矩阵中的NaN用指定的值或方式填充的函数
% 输入的参数至少有一个,至多有两个
% 第一个参数是需要处理的矩阵,第二个参数可选,是填充的值或填充方法(数字:则将所有NaN替换为该数值,字符串('ffill':用前面的值填充,'bfill':用后面的值填充),默认参数是0)
% 返回的是填充后的矩阵
function Data =  FillNaN(varargin)
% 1: Data
% 2: method, double or char type
Data = varargin{1};
if nargin == 1
    method = 0;
else
    method = varargin{2};
end

if isa(method, 'char')
    if strcmp(method, 'ffill') == 1
        for Col = 1:size(Data, 2)
            for Row = 2:size(Data, 1)
                if isnan(Data(Row, Col))
                    Data(Row, Col) = Data(Row - 1, Col);
                end
            end
        end
    elseif strcmp(method, 'bfill') == 1
        for Col = 1:size(Data,2)
            for Row = size(Data,1)-1:-1:1
                if isnan(Data(Row, Col))
                    Data(Row, Col) = Data(Row + 1, Col);
                end
            end
        end
    end            
elseif isa(method, 'double')
    Data(isnan(Data)) = method;
end

end