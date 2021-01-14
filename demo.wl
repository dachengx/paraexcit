Clear["Global`*"]
h5fold=$ScriptCommandLine[[2]];
imgpath=$ScriptCommandLine[[3]];
files=FileNames["*.h5",h5fold];

n={};
beta={};
theta={};

For[i=1,i<=Length[files],i++,
AppendTo[n,Import[files[[i]],{"n"}]];
AppendTo[beta,Import[files[[i]],{"beta"}]];
AppendTo[theta,Max[Abs[Import[files[[i]],{"thetalist"}]]]];
]

fig=Show[ListPlot3D[Transpose[{n,beta,theta}],Mesh->None,InterpolationOrder->3,ColorFunction->"SouthwestColors",PlotRange->All,AspectRatio->Automatic,ScalingFunctions->{None,None,None},AxesLabel->{Style[ToExpression["\\frac{\\Omega}{\\Omega_{0}}",TeXForm,HoldForm],Large],Style[\[Beta],Large],Style[\[Theta],Large]},ImageSize->{1000,800}]];
Export[imgpath<>"demo.png",fig];

For[n=1,n<=6,n++,
beta=0.01;
L=3;
theta=0.001;
thetadot=0.1;
m=0.1;
g=9.8;
x=0;
a=0.3;
wd=2*Sqrt[g/L]/n;
alpha=beta/m;
dt=0.01;
t=0;
tlist={};
xlist={};
thetalist={};

For[i=1,i<=10000,i++,
xdot=-a*wd*Sin[wd*t];
x=L+a*Cos[wd*t]+xdot*dt;
thetadoubledot=(-alpha*x*thetadot-2*xdot*thetadot-g*Sin[theta])/x;
thetadot=thetadot+thetadoubledot*dt;
theta=theta+thetadot*dt;
t=t+dt;
xlist=AppendTo[xlist,x];
tlist=AppendTo[tlist,t];
thetalist=AppendTo[thetalist,theta];
];

fig=Show[ListPlot[{{0,0}}],ListLinePlot[Transpose[{xlist*Sin[thetalist],-xlist*Cos[thetalist]}]],PlotRange->{{-4,4},{-4,0.1}},GridLines->Automatic,AspectRatio->Automatic,ImageSize->{1000,600}];
Export[imgpath<>"/"<>ToString[n]<>".png",fig];
];