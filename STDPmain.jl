#STDP学習則を作る
#letってどういう意味？
using Random, ParameterizedFunctions, DifferentialEquations, Plots, CPUTime, ProgressMeter, LinearAlgebra, Statistics, DataFrames, CSV, Interact, PyCall
@pyimport numpy as np

module STDP
using Random, ParameterizedFunctions, DifferentialEquations, Plots, CPUTime, ProgressMeter, LinearAlgebra, Statistics, DataFrames, CSV, Interact, PyCall
@pyimport numpy as np
gr()
using Base: @kwdef
using Parameters: @unpack # or using UnPack
rng = MersenneTwister(1234)



function stdp_ltp(dt, a=1.0, tc=20)
  """ Long-term Potentiation """
  return a * np.exp(-dt / tc)
end

function stdp_ltd(dt, a=-1.0, tc=20)
  """ Long-term Depression """
  return a * exp(dt / tc)
end


function stdp(DT, pre=-1.0, post=1.0, tc_pre=20, tc_post=20)
  """ STDP rule """
  A = 0
  B = 0
  if DT <= 0
    A = stdp_ltd(DT, pre, tc_pre)
    B = 0
  elseif DT > 0
    A = 0
    B = stdp_ltp(DT, post, tc_post)
  end
  return A, B
end
end
#if contains(@__FILE__, PROGRAM_FILE)
# 発火時刻差集合
#dt = np.arange(-50, 50, 0.5)
#ltd = zeros(size(dt)[1])
#ltp = zeros(size(dt)[1])
# LTD, LTP
#for i = 1:Int(size(dt)[1])
#  ltd[i] = STDP.stdp(dt[i])[1]
#  ltp[i] = STDP.stdp(dt[i])[2]
#end

#Plots.plot(dt, ltd)
#Plots.plot(dt, ltp)

#end
