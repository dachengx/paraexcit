Clear["Global`*"]
nbeta=$ScriptCommandLine[[2]];
n=ToExpression[StringTake[nbeta,3]];
beta=ToExpression[StringTake[nbeta,-6]];
path=$ScriptCommandLine[[3]];
L=3;
theta=0.001;
thetadot=0.1;
m=0.1;
g=9.8;
x=0;
a=0.3;
wd=n*Sqrt[g/L];
alpha=beta/m;
dt=0.01;
t=0;
tlist={};
xlist={};
thetalist={};

For[i=1,i<20000,i++,
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

Export[path,{xlist,tlist,thetalist,n,beta},{"Datasets", {"xlist","tlist","thetalist","n","beta"}}]