% 用于合并矩阵的函数(该函数的编写方式参考Pandas DataFrame的join方法)
% varargin至少包含两个参数,第一个参数是要合并的第一个矩阵,第二个参数是要合并的第二个矩阵;
% varargin的第三个参数代表合并的方式,可选参数{'inner','outer','left','outer'},默认合并方式'inner'
% 合并方式: 将每个矩阵的第一列视为索引,
%           假设输入的是一个[N1 * M1]和一个[N2 * M2]的矩阵 
%   inner:  输出矩阵的索引是两个输入矩阵的索引的交集,按照索引第2至M1列填充第一个矩阵的第2至M1列的数据,
%           第M1+1至第M1+M2-1列填充第二个矩阵的第2至第M2列的数据,若两个矩阵索引的交集的大小为N3,
%           输出的是一个[N3 * (M1 + M2 -1)]的矩阵
%    left:  输出矩阵的索引是与第一个矩阵的索引相同,按照索引第2至M1列填充第一个矩阵的第2至M1列的数据,
%           第M1+1至第M1+M2-1列填充第二个矩阵的第2至第M2列的数据,不足部分用NaN值填充,输出的是一个
%           [N1 * (M1 + M2 -1)]的矩阵
%   right:  输出矩阵的索引是与第二个矩阵的索引相同,按照索引第2至M1列填充第一个矩阵的第2至M1列的数据,
%           不足部分用NaN值填充,第M1+1至第M1+M2-1列填充第二个矩阵的第2至第M2列的数据,输出的是一个
%           [N1 * (M1 + M2 -1)]的矩阵
%   outer:  输出矩阵的索引是是两个输入矩阵的索引的并集,按照索引第2至M1列填充第一个矩阵的第2至M1列的数据,
%           不足部分用NaN值填充,第M1+1至第M1+M2-1列填充第二个矩阵的第2至第M2列的数据,不足部分用NaN值填充，
%           若两个矩阵索引的交集的大小为N4,则输出的是一个[N4 * (M1 + M2 -1)]的矩阵
function Data = IndexMatch(varargin)
% varargin{1}  varargin{2} varargin{3}
%    Data1        Data2    how可选参数

Data1 = varargin{1};
Data2 = varargin{2};
if nargin == 2
    how = 'inner';
else
    how = varargin{3};
end

if strcmp(how, 'inner') == 1
    [~, Index1, Index2] = intersect(Data1(:,1), Data2(:,1));
    Data = [Data1(Index1,:),Data2(Index2,2:end)];
elseif strcmp(how, 'left') == 1
    Data = [Data1, NaN([size(Data1,1),size(Data2,2)-1])];
    [~, Index1, Index2] = intersect(Data1(:,1), Data2(:,1));
    Data(Index1, size(Data1,2)+1:end) = Data2(Index2,2:end);
elseif strcmp(how, 'right') == 1
    [Data1, Data2] = deal(Data2, Data1);
    Data = [Data1, NaN([size(Data1,1),size(Data2,2)-1])];
    [~, Index1, Index2] = intersect(Data1(:,1), Data2(:,1));
    Data(Index1, size(Data1,2)+1:end) = Data2(Index2,2:end);
    Data = [Data(:,1), Data(:,size(Data1,2)+1:end), Data(:,2:size(Data1,2))];
elseif strcmp(how, 'outer') == 1
    [Index, ~, ~] = union(Data1(:,1), Data2(:,1));
    Data = [Index,NaN([length(Index), size(Data1,2) + size(Data2,2) - 2])];
    [~, Ind1, Ind2] = intersect(Data(:,1), Data1(:,1));
    Data(Ind1, 2:size(Data1,2)) = Data1(Ind2,2:end);
    [~, Ind1, Ind2] = intersect(Data(:,1), Data2(:,1));
    Data(Ind1, size(Data1,2)+1:end) = Data2(Ind2,2:end);    
end          
Data = sortrows(Data, 1);
end