-- Generated from ChapterGaussCoreQuadBounds.lean — theorem BookProof.GaussCoreQuadBounds.norm_mul_le_of_pointwise
import Mathlib
import Definitions.Def_ChapterGaussCoreQuadBounds
open BookProof.GaussCoreQuadBounds








open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.FarisLavine

noncomputable section

variable {D : ℕ}

theorem BookProof.GaussCoreQuadBounds.norm_mul_le_of_pointwise {f g : MvPolynomial (Fin D) ℂ} {lam : ℝ} (hlam : 0 ≤ lam)
    (h : ∀ x : Vd D, ‖MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) f‖
      ≤ lam * ‖MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) g‖)
    (p : MvPolynomial (Fin D) ℂ) :
    ‖pgLp (f * p)‖ ≤ lam * ‖pgLp (g * p)‖ := by sorry
