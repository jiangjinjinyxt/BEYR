% �������س��ĺ���
% ����ĵ�һ�������������ʻ�۸�����,�ڶ����������������е�����(1:����������, ����:�۸�����)
% ����ֵ�����س�(����)
function Dat = MaxDraw(Data, type)
% typ2 == 1 ����������
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