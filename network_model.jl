"""
https://snn.hirlab.net/?s=6 のliquid state machine モデルの作成を目指している。
https://snn.hirlab.net/?s=5 も
神経細胞の発火はhttps://snn.hirlab.net/?s=3#sub2 のIzhikevichを採用
"""

using Random, ParameterizedFunctions, DifferentialEquations, Plots, CPUTime, ProgressMeter, LinearAlgebra, Statistics, DataFrames, CSV, Interact, PyCall
@pyimport numpy as np
gr()
using Base: @kwdef
using Parameters: @unpack # or using UnPack
rng = MersenneTwister(1234)
include("/Users/mizuno_shin/SNN_models/Trace.jl")
include("/Users/mizuno_shin/SNN_models/STDPmain.jl")
include("/Users/mizuno_shin/SNN_models/Izhikevich.jl")
import Main.STDP as STDP
import Main.TRACE as Trace
import Main.Iz as Iz

module network
"""
考えている状況：　初期に情報（刺激強度、電流、matrix)があって、それがグラフに入っていく。入る場所は未定。
entryinformation→(entry place)→
"""
struct entryparameters
  dt::Float64
  entryinformation::Matrix{Float64}
  entryplace::Array
end

struct graphstructs
  Connection::Matrix{Float64}
  nodenum::Int
end

struct neuroncelltype
  recoveryvariable::Matrix{Float64}
  recoveryvariable_scaling::Matrix{Float64}
  b::Matrix{Float64}
  seisimakudeni::Matrix{Float64}
  d::Matrix{Float64}
end

mutable struct showcurrentstate
  t::Float64 #time
  makudeni::Matrix{Float64}
  SpikeTrace::Matrix{Float64}
  Firingtrace::Matrix{Float64}
  currentweightforedges::Matrix{Float64}
  delweight::Matrix{Float64}
  electronic::Matrix{Float64}
end

mutable struct kousinweight
  newweight::Matrix{Float64}
end

mutable struct kousinmakudeni
  newmakudeni::Matrix{Float64}
end

#mutable struct oneordergraph
#  firerateattime::Matrix{Float64}
#  stdpkousinattime::Matrix{Float64}
#end
end

using .network
dt = 0.02
entryinformation = 2 * ones(10, 10)
entryplace = [1 2 3]

Connection = ones(nodenum, nodenum)
nodenum = 10

recoveryvariable = 0.1 * ones(nodenum, nodenum)
recoveryvariable_scaling = 0.1 * ones(nodenum, nodenum)
b = 0.1 * ones(nodenum, nodenum)
seisimakudeni = 0.1 * ones(nodenum, nodenum)
d = 0.1 * ones(nodenum, nodenum)

t = 100 #time
makudeni = zeros(nodenum, nodenum)
SpikeTrace = zeros(nodenum, nodenum)
Firingtrace = zeros(nodenum, nodenum)
currentweightforedges = ones(nodenum, nodenum)
delweight = zeros(nodenum, nodenum)
electronic = zeros(nodenum, nodenum)

newweight = zeros(nodenum, nodenum)

newmakudeni = zeros(nodenum, nodenum)

entryparameters1 = network.entryparameters(dt, entryinformation, entryplace)
graphstructs2 = network.graphstructs(Connection, nodenum)
neuroncelltype3 = network.neuroncelltype(recoveryvariable, recoveryvariable_scaling, b, seisimakudeni, d)
showcurrentstate4 = network.showcurrentstate(t, makudeni, SpikeTrace, Firingtrace, currentweightforedges, delweight, electronic)
kousinweight5 = network.kousinweight(newweight)
kousinmakudeni6 = network.kousinmakudeni(newmakudeni)

function entrytakeplace(entryparameters1, graphstructs2)

  for iT = 1:param.nT
    var.T = (iT - 1) * dT + param.Tmin
    g = calc_g(param, var)
    println("T = $(var.T), g = $g")
  end
end

function calc_g(param, var)
  g = var.T * param.a
  return g
end
