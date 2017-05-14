% �������е�NaN��ָ����ֵ��ʽ���ĺ���
% ����Ĳ���������һ��,����������
% ��һ����������Ҫ����ľ���,�ڶ���������ѡ,������ֵ����䷽��(����:������NaN�滻Ϊ����ֵ,�ַ���('ffill':��ǰ���ֵ���,'bfill':�ú����ֵ���),Ĭ�ϲ�����0)
% ���ص�������ľ���
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