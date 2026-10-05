-- Generated from ChapterShiftedQuadraticEsa.lean — solution of BookProof.ShiftedQuadratic.momTPoly_eq_smul
import Mathlib
import Definitions.Def_ChapterShiftedQuadraticEsa
import Theorems.Thm_BookProof_HyperbolicQuadratic_dPoly_apply
import Theorems.Thm_BookProof_HyperbolicQuadratic_momPoly_apply
import Theorems.Thm_BookProof_ShiftedHermiteCore_momTPoly_apply
import Theorems.Thm_BookProof_ShiftedQuadratic_dPolyT_apply
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
theorem solution (k : Vd d) (i : Fin d) (p : MvPolynomial (Fin d) ℂ) :
    momTPoly k i p = (-Complex.I) • dPolyT k i p := by

  rw [momTPoly_apply, dPolyT_apply, momPoly_apply' i p, ← dPoly_apply]
  match_scalars <;> (ring_nf; all_goals (rw [Complex.I_sq]; ring))
