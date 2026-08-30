import numpy as np
r=8;d=int(np.log2(r));n=r-1;k=1;s=n-k;N=2**n;M=2**r;p=r-n
e=N+2**d+p;t=(s+d)/(M-s);a=e+t
b=(N-n)/N;x=M-n;h=(s+d)/2**d;dl=b**(x+np.log(h))
ad=a-dl;print(f"α⁻¹={ad:.12f} Δ/σ={abs(ad-137.035999177)/2.1e-8:.4f}")
G=(n*(n+d+k))/(2**d*(n-2*k)**2)*np.sqrt(d)*1e-10*(1+t)**(1/(2**d*(n-2*k)))
print(f"G={G:.10e} Δ/σ={abs(G-6.67430e-11)/1.5e-15:.4f}")