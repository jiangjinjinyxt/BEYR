% ���ںϲ�����ĺ���(�ú����ı�д��ʽ�ο�Pandas DataFrame��join����)
% varargin���ٰ�����������,��һ��������Ҫ�ϲ��ĵ�һ������,�ڶ���������Ҫ�ϲ��ĵڶ�������;
% varargin�ĵ�������������ϲ��ķ�ʽ,��ѡ����{'inner','outer','left','outer'},Ĭ�Ϻϲ���ʽ'inner'
% �ϲ���ʽ: ��ÿ������ĵ�һ����Ϊ����,
%           �����������һ��[N1 * M1]��һ��[N2 * M2]�ľ��� 
%   inner:  �������������������������������Ľ���,����������2��M1������һ������ĵ�2��M1�е�����,
%           ��M1+1����M1+M2-1�����ڶ�������ĵ�2����M2�е�����,���������������Ľ����Ĵ�СΪN3,
%           �������һ��[N3 * (M1 + M2 -1)]�ľ���
%    left:  �����������������һ�������������ͬ,����������2��M1������һ������ĵ�2��M1�е�����,
%           ��M1+1����M1+M2-1�����ڶ�������ĵ�2����M2�е�����,���㲿����NaNֵ���,�������һ��
%           [N1 * (M1 + M2 -1)]�ľ���
%   right:  ����������������ڶ��������������ͬ,����������2��M1������һ������ĵ�2��M1�е�����,
%           ���㲿����NaNֵ���,��M1+1����M1+M2-1�����ڶ�������ĵ�2����M2�е�����,�������һ��
%           [N1 * (M1 + M2 -1)]�ľ���
%   outer:  ���������������������������������Ĳ���,����������2��M1������һ������ĵ�2��M1�е�����,
%           ���㲿����NaNֵ���,��M1+1����M1+M2-1�����ڶ�������ĵ�2����M2�е�����,���㲿����NaNֵ��䣬
%           ���������������Ľ����Ĵ�СΪN4,���������һ��[N4 * (M1 + M2 -1)]�ľ���
function Data = IndexMatch(varargin)
% varargin{1}  varargin{2} varargin{3}
%    Data1        Data2    how��ѡ����

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