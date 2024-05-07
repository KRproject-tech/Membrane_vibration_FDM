
![図1](https://github.com/KRproject-tech/Membrane_vibration_FDM/assets/114337358/32e49619-3b1f-4fd0-89d7-80b433c0129b)

# Membrane_vibration_FDM
Finite difference method (FDM) to solve the membrane vibration problem

**Communication**

<a style="text-decoration: none" href="https://twitter.com/hogelungfish_" target="_blank">
    <img src="https://img.shields.io/badge/twitter-%40hogelungfish_-1da1f2.svg" alt="Twitter">
</a>
<p>


**Language**
<p>
<img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/matlab/matlab-original.svg" width="60"/>
<p>


## Directory    
<pre>
└─membrane_PDE
    ├─save
    │  └─fig
    └─ToolBoxes
</pre>


## Preparation before analysis
__[Step 1] Install the ToolBoxes__

The following ToolBoxes in “./cores/ToolBoxes/” are required,

__For plotting results:__

*	__“mmwrite”__ by Micah Richert:

https://jp.mathworks.com/matlabcentral/fileexchange/15881-mmwrite

## Governing equation

$$
\begin{aligned}
&\mathrm{PDE}: \partial^2_t u(x,y,t) - t_x \partial^2_x u(x,y,t) - t_y \partial^2_y u(x,y,t) = 0, \ (x,y) \in [0, L_x] \times [0, L_y], \\
&\mathrm{BC} : u(x,y,t) = 0, \ (x,y) \in ([0, L_x] \times \\{0, L_y \\}) \cup (\\{0, L_x \\} \times [0, L_y]), \\
&\mathrm{IC} : u(x,y,0) = \left( \sin{\pi \frac{x}{L_x}}\sin{\pi \frac{y}{L_y}} \right)^3. 
\end{aligned}
$$


## Demonstration movie

[![](https://img.youtube.com/vi/_kEdkMvdkE4/0.jpg)](https://www.youtube.com/watch?v=_kEdkMvdkE4)
