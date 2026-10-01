-- Generated from ChapterHermiteProductCore.lean — solution of BookProof.HermiteProductCore.polyGaussCore_eq_hermiteSpan
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
import Theorems.Thm_BookProof_HermiteProductCore_span_hermiteMv
open BookProof.HermiteProductCore




open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section

set_option maxHeartbeats 1000000 in
in d →₀ ℕ) := by
      rw [hermiteMv_zero, MvPolynomial.smul_eq_C_mul, mul_one]
    rw [h]
    exact Submodule.smul_mem _ _ (Submodule.subset_span ⟨0, rfl⟩)
  | add p q hp hq => exact add_mem hp hq
  | mul_X p i hp => rw [mul_comm]; exact mul_X_mem_span_hermiteMv i hp

/-- **The Gauss–polynomial core is exactly the :=
   span of the product Hermite
  functions** `∏ᵢ He_{αᵢ}(xᵢ) · e^{-‖x‖²/4}` — the `d`-dimensional Hermite core. -/
  theorem polyGaussCore_eq_hermiteSpan :
      polyGaussCore (d := d)
        = Submodule.span ℂ (Set.range fun a : Fin d →₀ ℕ => pgLp (hermi
