-- Generated from ChapterQuantumGravity3DGauge.lean — solution of BookProof.QuantumGravity3DGauge.realCoeff_torsionPoly
import Mathlib
import Definitions.Def_ChapterQuantumGravity3DGauge
import Theorems.Thm_BookProof_YangMillsHermite_starP_X
import Theorems.Thm_BookProof_YangMillsHermite_starP_sub
open BookProof.QuantumGravity3DGauge




open MeasureTheory Complex MvPolynomial Filter Topology
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.HermiteGalerkin
open BookProof.HashimotoShiftInvert BookProof.QuantumGravityDensitized

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (mu nu a : Fin 4) : RealCoeff (torsionPoly mu nu a) := by

  have h : starP (X (idxDE mu nu a) - X (idxDE nu mu a) : MvPolynomial (Fin 84) ℂ)
      = X (idxDE mu nu a) - X (idxDE nu mu a) := by
    rw [starP_sub, starP_X, starP_X]
  exact h
