-- Generated from ChapterHermiteProductCore.lean — theorem BookProof.HermiteProductCore.polyGaussCore_eq_hermiteSpan
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore

variable {d : ℕ}



open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section

in d →₀ ℕ) := by
      rw [hermiteMv_zero, MvPolynomial.smul_eq_C_mul, mul_one]
    rw [h]
    exact Submodule.smul_mem _ _ (Submodule.subset_span ⟨0, rfl⟩)
  | add p q hp hq => exact add_mem hp hq
  | mul_X p i hp => rw [mul_comm]; exact mul_X_mem_span_hermiteMv i hp

/-- **The Gauss–polynomial core is exactly the := by sorry
