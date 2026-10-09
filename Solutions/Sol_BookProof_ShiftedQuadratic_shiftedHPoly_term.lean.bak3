-- Generated from ChapterShiftedQuadraticEsa.lean — solution of BookProof.ShiftedQuadratic.shiftedHPoly_term
import Mathlib
import Definitions.Def_ChapterShiftedQuadraticEsa
import Theorems.Thm_BookProof_ShiftedQuadratic_oscTPoly_apply
import Theorems.Thm_BookProof_ShiftedHermiteCore_momTPoly_apply
import Theorems.Thm_BookProof_ShiftedHermiteCore_mulXTPoly_apply
import Theorems.Thm_BookProof_ShiftedQuadratic_boostVec_apply
import Theorems.Thm_BookProof_ShiftedQuadratic_shiftVec_apply
open BookProof.ShiftedQuadratic




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic
open BookProof.ShiftedHermiteCore
open BookProof.FarisLavine
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (c b b' : Fin d → ℝ) (i : Fin d) (hc : c i ≠ 0)
    (p : MvPolynomial (Fin d) ℂ) :
    ((c i : ℝ) : ℂ) • oscTPoly (shiftVec c b) (boostVec c b') i p
        + ((b i : ℝ) : ℂ) • mulXTPoly (shiftVec c b) i p
        + ((b' i : ℝ) : ℂ) • momTPoly (boostVec c b') i p
      = ((c i : ℝ) : ℂ) • oscPoly i p
        + (((-(b' i ^ 2) / (4 * c i) - b i ^ 2 / c i : ℝ)) : ℂ) • p := by

  have hcC : ((c i : ℝ) : ℂ) ≠ 0 := by exact_mod_cast hc
  rw [oscTPoly_apply, mulXTPoly_apply, momTPoly_apply, shiftVec_apply, boostVec_apply]
  push_cast
  match_scalars <;> field_simp <;> ring
