-- Generated from ChapterQuantumGravity3DGauge.lean — solution of BookProof.QuantumGravity3DGauge.qgCCR_tetrad
import Mathlib
import Definitions.Def_ChapterQuantumGravity3DGauge
import Theorems.Thm_BookProof_QuantumGravity3DGauge_idxE_injective
import Theorems.Thm_BookProof_QuantumGravity3DGauge_qgCCR
open BookProof.QuantumGravity3DGauge




open MeasureTheory Complex MvPolynomial Filter Topology
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.HermiteGalerkin
open BookProof.HashimotoShiftInvert BookProof.QuantumGravityDensitized

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (Φ : CoreRep 84 D) (mu a nu b : Fin 4) (x : D) :
    qgCoord Φ (idxE mu a) (qgMom Φ (idxE nu b) x) - qgMom Φ (idxE nu b) (qgCoord Φ (idxE mu a) x)
      = (if mu = nu ∧ a = b then Complex.I else 0) • x := by

  rw [qgCCR]
  congr 1
  by_cases h : mu = nu ∧ a = b
  · obtain ⟨h1, h2⟩ := h
    subst h1; subst h2; simp
  · rw [if_neg h, if_neg]
    intro hEq
    exact h (by
      have := idxE_injective (a₁ := (mu, a)) (a₂ := (nu, b)) hEq
      exact ⟨congrArg Prod.fst this, congrArg Prod.snd this⟩)
