-- Generated from ChapterHermiteQuadraticEsa.lean — solution of BookProof.HermiteQuadraticEsa.expBounded_sectorQuadW
import Mathlib
import Definitions.Def_ChapterHermiteQuadraticEsa
import Theorems.Thm_BookProof_HermiteQuadraticEsa_expBounded_of_growth_bound
import Theorems.Thm_BookProof_HermiteQuadraticEsa_abs_sectorQuadW_sub_harmW_le
open BookProof.HermiteQuadraticEsa















open MeasureTheory Complex MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.FarisLavine BookProof.Starobinsky
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (M alpha mu : ℝ) : ExpBounded (sectorQuadW M alpha mu) :=
  expBounded_of_growth_bound (le_trans (abs_nonneg _) (le_max_left _ _)) (by positivity) le_rfl
      (abs_sectorQuadW_sub_harmW_le M alpha mu)
