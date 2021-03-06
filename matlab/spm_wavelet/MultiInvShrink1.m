function ws = MultiInvShrink1(wc,L)
%
% This file is part of the software described in
%
% Alle Meije Wink and Jos B. T. M. Roerdink (2004)
% ``Denoising functional MR images:
%   a comparison of wavelet denoising and Gaussian smoothing''
% IEEE Trans. Med. Im. 23 (3), pp. 374-387
%
% please refer to that paper if you use this software
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% InvShrink -- Shrinkage with Exponential Factor applied
%  Usage
%    s = InvShrink(wc,L)
%  Inputs
%    wc      Wavelet Transform of noisy sequence with N(0,1) noise
%    L       low-frequency cutoff for Wavelet Transform
%    sa      noise level at highest resolution level
%    alpha   decay rate of noise level with resolution level
%  Outputs
%    ws      result of applying FixShrink to each wavelet level,
%            with appropriate weighting 
%
ws=wc;
alpha=1;
[n,J] = dyadlength(ws);

for j=J-1:-1:L 
  l=length(dyad(j));
  thr=sqrt(2*log(l));

  tws=ws(dyad(j));
  scale = std(tws) * 2.^((j-J)*alpha);
  if (~scale)
    scale=2.^((j-J)*alpha);
  end
  ws(dyad(j)) = scale*SoftThreshAbs(tws/scale,thr);
  
end

%
% Copyright (c) 1993-5.  Jonathan Buckheit, David Donoho and Iain Johnstone
%
    
    
%   
% Part of WaveLab Version 802
% Built Sunday, October 3, 1999 8:52:27 AM
% This is Copyrighted Material
% For Copying permissions see COPYING.m
% Comments? e-mail wavelab@stat.stanford.edu
%   
    
