-- Generated from ChapterQgDerivativeRealization.lean — solution of BookProof.QgDerivativeRealization.configPoint_eq_jetPoint_of_fixed
import Mathlib
import Definitions.Def_ChapterQgDerivativeRealization
import Theorems.Thm_BookProof_QgDerivativeRealization_jetPoint_idxDE
import Theorems.Thm_BookProof_QgDerivativeRealization_idx_cases
import Theorems.Thm_BookProof_QgDerivativeRealization_fixed_iff
open BookProof.QgDerivativeRealization




open MvPolynomial
open BookProof.GaugeFixing
open BookProof.QuantumGravity3DGauge
open BookProof.QgPhysicalSectorIdentity

set_option maxHeartbeats 1000000 in
theorem solution (T : TetradConfig) (E : DerivFields)
    (hE : Fixed T E) (x : Fin 4 → ℝ) : configPoint T E x = jetPoint T x := by

  funext j
  rcases idx_cases j with ⟨mu, rfl⟩ | ⟨mu, a, rfl⟩ | ⟨mu, nu, a, rfl⟩
  · simp [jetPoint]
  · simp [jetPoint]
  · rw [configPoint_idxDE, jetPoint_idxDE, (fixed_iff T E).1 hE mu nu a]
