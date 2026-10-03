-- Generated from ChapterHermiteQuadraticEsa.lean — solution of BookProof.HermiteQuadraticEsa.cpoly_harmPoly
import Mathlib
import Definitions.Def_ChapterHermiteQuadraticEsa
import Theorems.Thm_BookProof_QgHermiteFriedrichs_cpoly_C
import Theorems.Thm_BookProof_QgHermiteFriedrichs_cpoly_X
import Theorems.Thm_BookProof_QgHermiteFriedrichs_cpoly_mul
import Theorems.Thm_BookProof_QgHermiteFriedrichs_cpoly_sum
open BookProof.HermiteQuadraticEsa




open MeasureTheory Complex MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.FarisLavine BookProof.Starobinsky
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution : cpoly (harmPoly (d := by

  have hq : (starRingEnd ℂ) (1 / 4 : ℂ) = 1 / 4 := by norm_num [Complex.ext_iff]
  unfold harmPoly
  rw [cpoly_sum]
  refine Finset.sum_congr rfl fun k _ => ?_
  rw [pow_two, cpoly_mul, cpoly_mul, cpoly_C, cpoly_X, hq]
