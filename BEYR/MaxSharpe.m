function swgt = MaxSharpe(varargin)
OutData = varargin{1};
for i = 2:nargin
    OutData = IndexMatch(OutData, varargin{i}, 'outer');
end
OutData = FillNaN(FillNaN(OutData, 'ffill'), 'bfill');
Rets = OutData(2:end, 2:end) ./ OutData(1:end-1, 2:end) - 1;
p = Portfolio;
p = p.estimateAssetMoments(Rets);
p = p.setDefaultConstraints;
p = setInitPort(p,0);
swgt = estimateMaxSharpeRatio(p);
[srsk,sret] = estimatePortMoments(p,swgt)
sharperatio = sret * (252^0.5)/ srsk
end