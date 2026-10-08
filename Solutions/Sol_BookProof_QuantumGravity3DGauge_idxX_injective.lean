-- Generated from ChapterQuantumGravity3DGauge.lean — solution of BookProof.QuantumGravity3DGauge.idxX_injective
import Mathlib
import Definitions.Def_ChapterQuantumGravity3DGauge
open BookProof.QuantumGravity3DGauge




open MeasureTheory Complex MvPolynomial Filter Topology
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.HermiteGalerkin
open BookProof.HashimotoShiftInvert BookProof.QuantumGravityDensitized

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution : Function.Injective (fun q : Fin 4 × Fin 4 => idxE q.1 q.2) :=
  ℝ⁸⁴` -/
  
  /-- The coordinate index of the spacetime coordinate `x^μ`. -/
  def idxX (mu : Fin 4) : Fin 84 := ⟨mu.val, by omega⟩
  
  /-- The coordinate index of the tetrad field `e_μ^a`. -/
  def idxE (mu a : Fin 4) : Fin 8
