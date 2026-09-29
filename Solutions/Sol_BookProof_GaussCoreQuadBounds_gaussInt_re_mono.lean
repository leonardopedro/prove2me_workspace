-- Generated from ChapterGaussCoreQuadBounds.lean — solution of BookProof.GaussCoreQuadBounds.gaussInt_re_mono
import Mathlib
import Definitions.Def_ChapterGaussCoreQuadBounds
import Theorems.Thm_BookProof_GaussCoreQuadBounds_gaussInt_re
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterFarisLavine
open BookProof.GaussCoreQuadBounds









open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.FarisLavine

noncomputable section

variable {D : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {r s : MvPolynomial (Fin D) ℂ}
    (h : ∀ x : Vd D, (MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) r).re
      ≤ (MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) s).re) :
    (gaussInt r).re ≤ (gaussInt s).re := by

  have hint : ∀ t : MvPolynomial (Fin D) ℂ, MeasureTheory.Integrable
      (fun x : Vd D => (MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) t).re * gaussWD x) := by
    intro t
    refine ((integrable_gwFun t).re).congr (Filter.Eventually.of_forall fun x => ?_)
    simp
  rw [gaussInt_re, gaussInt_re]
  refine MeasureTheory.integral_mono (hint r) (hint s) fun x => ?_
  have hw : (0 : ℝ) ≤ gaussWD x := le_of_lt (Real.exp_pos _)
  exact mul_le_mul_of_nonneg_right (h x) hw
