-- Generated from ChapterHermiteProductCore.lean — theorem BookProof.HermiteProductCore.gaussMoment_succ
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore
open BookProof.HermiteProductCore

variable {d : ℕ}



open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section

 | empty => simp [gaussInt]
  | insert v s hv ih =>
      rw [Finset.sum_insert hv, Finset.sum_insert hv, gaussInt_add, ih]

/-- The one-dimensional Gaussian moments `M k = ∫ tᵏ e^{-t²/2} dt`. -/
def gaussMoment (k : ℕ) : ℝ := gint ((Polynomial.X : Polynomial ℝ) ^ k) := by sorry
