-- Generated from ChapterQuantumGravity3DGauge.lean — solution of BookProof.QuantumGravity3DGauge.idxE_injective
import Mathlib
import Definitions.Def_ChapterQuantumGravity3DGauge
open BookProof.QuantumGravity3DGauge




open MeasureTheory Complex MvPolynomial Filter Topology
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.HermiteGalerkin
open BookProof.HashimotoShiftInvert BookProof.QuantumGravityDensitized

noncomputable section

set_option maxHeartbeats 1000000 in
def idxDE (mu nu a : Fin 4) : Fin 84 :=
   `∂_μ e_ν^a`. -/
  def idxDE (mu nu a : Fin 4) : Fin 84 := ⟨20 + 16 * mu.val + 4 * nu.val + a.val, by omega⟩
  
  theorem idxX_injective : Function.Injective idxX := by
    intro mu mu' h
    have := congrArg Fin.val h
    simp only [idxX] at this
    exact Fin.ext this
  
  theorem idxE_in
