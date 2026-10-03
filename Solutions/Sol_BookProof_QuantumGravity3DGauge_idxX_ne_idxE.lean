-- Generated from ChapterQuantumGravity3DGauge.lean — solution of BookProof.QuantumGravity3DGauge.idxX_ne_idxE
import Mathlib
import Definitions.Def_ChapterQuantumGravity3DGauge
open BookProof.QuantumGravity3DGauge




open MeasureTheory Complex MvPolynomial Filter Topology
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.HermiteGalerkin
open BookProof.HashimotoShiftInvert BookProof.QuantumGravityDensitized

noncomputable section

set_option maxHeartbeats 1000000 in
only [idxE] at h'
  have hmu : mu.val = mu'.val := by omega
  have ha : a.val = a'.val := by omega
  simp [Prod.ext_iff, Fin.ext_iff, hmu, ha]

theorem solution :
    Function.Injective (fun q : Fin 4 × Fin 4 × Fin 4 => idxDE q.1 q.2.1 q.2.2) :=
  .val = a'.val := by omega
    simp [Prod.ext_iff, Fin.ext_iff, hmu, ha]
  
  theorem idxDE_i
