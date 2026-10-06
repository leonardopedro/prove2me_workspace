-- Generated from ChapterGaussCoordCombo.lean — solution of BookProof.GaussCoordCombo.pderiv_coordCombo_of_ne
import Mathlib
import Definitions.Def_ChapterGaussCoordCombo
import Theorems.Thm_BookProof_GaussCoordCombo_pderiv_hermiteFactor_of_ne
open BookProof.GaussCoordCombo




open MvPolynomial BookProof.HermiteProductCore

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {i j : Fin d} (h : j ≠ i) (c : ℕ → ℝ) (p K : ℕ) :
    pderiv j (coordCombo i c p K) = 0 := by

  rw [coordCombo, map_sum]
  refine Finset.sum_eq_zero fun k _ => ?_
  rw [Derivation.map_smul, pderiv_hermiteFactor_of_ne h, smul_zero]
