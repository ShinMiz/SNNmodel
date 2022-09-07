fire = 0
using Random, ParameterizedFunctions, DifferentialEquations, Plots, CPUTime, ProgressMeter, LinearAlgebra, Statistics, DataFrames, CSV, Interact, PyCall
@pyimport numpy as np

module TRACE
using Random, ParameterizedFunctions, DifferentialEquations, Plots, CPUTime, ProgressMeter, LinearAlgebra, Statistics, DataFrames, CSV, Interact, PyCall
@pyimport numpy as np
gr()
using Base: @kwdef
using Parameters: @unpack # or using UnPack
rng = MersenneTwister(1234)
#include("/Users/mizuno_shin/SNN_models/STDPmain.jl")
#import Main.STDP as STDP

#STDP.stdp_ltp(0.01)

#if contains(@__FILE__, PROGRAM_FILE)

function firingTrace(spikeTrace)
  tim = 300
  dt = 0.5

  # Spike Traceを適当に作る
  #spikes = np.zeros(Int(tim / dt))
  # 5本適当にスパイクを立てる
  #for _ = 1:5
  #  spikes[np.random.randint(0, Int(tim / dt))] = 1
  #end

  # Firing Traceを作成
  firing = []
  FIRE = 0
  tc = 20  # 時定数

  for t = 1:Int(tim / dt)
    if spikeTrace[t] != 0  # 発火していれば1を立てる
      FIRE = 1
    else  # 発火していなければ時間的減衰
      FIRE = FIRE - FIRE / tc
    end
    append!(firing, FIRE)
  end
  return firing
end
end


#t = np.arange(0, tim, dt)
#Plots.plot(2, 1, 1)
#Plots.plot(t, spikes)

#Plots.plot(2, 1, 2)
#Plots.plot(t, firing)

#end
