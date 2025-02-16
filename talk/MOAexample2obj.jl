using JuMP, GLPK
import MultiObjectiveAlgorithms as MOA

model = Model( )
@variable(model, x1≥0, Int)
@variable(model, x2≥0, Int)
@expression(model, fct1, x1 + x2)
@expression(model, fct2, x1 + 3 * x2)
@objective(model, Max, [fct1, (-1) * fct2])
@constraint(model, 2*x1 + 3*x2 ≤ 30)
@constraint(model, 3*x1 + 2*x2 ≤ 30)
@constraint(model, x1 - x2 ≤ 5.5)

set_optimizer(model,()->MOA.Optimizer(GLPK.Optimizer))
set_attribute(model, MOA.Algorithm(), MOA.EpsilonConstraint())

optimize!(model)

for i in 1:result_count(model)
       z1_opt = objective_value(model; result = i)[1]
       z2_opt = -1 * objective_value(model; result = i)[2]
       x1_opt = value(x1; result = i)
       x2_opt = value(x2; result = i)
       println("$i: x=($x1_opt, $x2_opt) || y=f(x)=( $z1_opt , $z2_opt)")
end

#=
1: x=(0.0, 0.0) || y=f(x)=( 0.0 , 0.0)
2: x=(1.0, 0.0) || y=f(x)=( 1.0 , 1.0)
3: x=(2.0, 0.0) || y=f(x)=( 2.0 , 2.0)
4: x=(3.0, 0.0) || y=f(x)=( 3.0 , 3.0)
5: x=(4.0, 0.0) || y=f(x)=( 4.0 , 4.0)
6: x=(5.0, 0.0) || y=f(x)=( 5.0 , 5.0)
7: x=(5.0, 1.0) || y=f(x)=( 6.0 , 8.0)
8: x=(6.0, 1.0) || y=f(x)=( 7.0 , 9.0)
9: x=(6.0, 2.0) || y=f(x)=( 8.0 , 12.0)
10: x=(7.0, 2.0) || y=f(x)=( 9.0 , 13.0)
11: x=(7.0, 3.0) || y=f(x)=( 10.0 , 16.0)
12: x=(8.0, 3.0) || y=f(x)=( 11.0 , 17.0)
13: x=(6.0, 6.0) || y=f(x)=( 12.0 , 24.0)
=#