module Iz
using Random, ParameterizedFunctions, DifferentialEquations, Plots, CPUTime, ProgressMeter, LinearAlgebra, Statistics, DataFrames, CSV, Interact, PyCall
@pyimport numpy as np
gr()
using Base: @kwdef
using Parameters: @unpack # or using UnPack
rng = MersenneTwister(1234)

function Izhikevich(dt, makudeni, recoveryvariable, a, b, c, d, insertelec)
  newmakudeni = 0
  newrecoveryvariable = 0
  if makudeni < 30
    newmakudeni = makudeni + dt * (0.04 * makudeni^2 + 5makudeni + 140 - recoveryvariable + insertelec)
    newrecoveryvariable = recoveryvariable + dt * a * (b * makudeni - recoveryvariable)
  elseif makudeni >= 30
    newmakudeni = c
    newrecoveryvariable = recoveryvariable + d
  else
    return "Izhikevichの変数、なんか間違ってるよ〜"
  end
  return newmakudeni, newrecoveryvariable
end
end
