-- Generated from ChapterGaussCoreQuadBounds.lean — solution of BookProof.GaussCoreQuadBounds.eval_cpoly_self_re
import Mathlib
import Definitions.Def_ChapterGaussCoreQuadBounds
open BookProof.GaussCoreQuadBounds









open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.FarisLavine

noncomputable section

variable {D : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (q : MvPolynomial (Fin D) ℂ) (x : Vd D) :
    (MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) (cpoly q * q)).re
      = ‖MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) q‖ ^ 2 := by

  rw [map_mul, ← conj_polyEval]
  set z := MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) q with hz
  rw [Complex.mul_re]
  simp [Complex.norm_eq_sqrt_sq_add_sq]
  nlinarith [Real.sq_sqrt (show (0:ℝ) ≤ z.re ^ 2 + z.im ^ 2 by positivity)]
