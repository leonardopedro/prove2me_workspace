-- Generated from ChapterHermiteProductCore.lean — solution of BookProof.HermiteProductCore.gaussMoment_succ
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
import Theorems.Thm_BookProof_HermiteCore_gint_ibp
open BookProof.HermiteProductCore




open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section

set_option maxHeartbeats 1000000 in
 | empty => simp [gaussInt]
  | insert v s hv ih =>
      rw [Finset.sum_insert hv, Finset.sum_insert hv, gaussInt_add, ih]

/-- The one-dimensional Gaussian moments `M k = ∫ tᵏ e^{-t²/2} dt`. -/
def gaussMoment (k : ℕ) : ℝ := gint ((Polynomial.X : Polynomial ℝ) ^ k) :=
  
  
  /-- **The moment recurrence** `M_{k+1} = k · M_{k-1}`, one-dimensional integration
  by parts against the Gaussian (`BookProof.HermiteCore.gint_ibp`).  For `k = 0` it
  reads `M₁ = 0`. -/
  theorem gaussMoment_succ (k : ℕ) : gau
