-- Generated from ChapterGaussCoreQuadBounds.lean — theorem BookProof.GaussCoreQuadBounds.sum_norm_sq_mul_le_of_pointwise
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteQuadraticEsa
import Definitions.Def_ChapterQgOuterFockEsa
import Mathlib
import Definitions.Def_ChapterGaussCoreQuadBounds
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteFriedrichs
open BookProof.HermiteProductCore
open BookProof.QgHermiteFriedrichs
open BookProof.GaussCoreQuadBounds

variable {D : ℕ}



open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.FarisLavine
open BookProof.HermiteQuadraticEsa
open BookProof.QgOuterFock

noncomputable section


theorem BookProof.GaussCoreQuadBounds.sum_norm_sq_mul_le_of_pointwise {R : Type*} [Fintype R]
    {f : R → MvPolynomial (Fin D) ℂ} {g : R → MvPolynomial (Fin D) ℂ} {lam : ℝ}
    (h : ∀ x : Vd D, ∑ r : R, ‖MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) (f r)‖ ^ 2
      ≤ lam * ∑ r : R, ‖MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) (g r)‖ ^ 2)
    (p : MvPolynomial (Fin D) ℂ) :
    ∑ r : R, ‖pgLp (f r * p)‖ ^ 2 ≤ lam * ∑ r : R, ‖pgLp (g r * p)‖ ^ 2 := by sorry
