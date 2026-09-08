-- Generated from ChapterHermiteProductCore.lean — solution of BookProof.HermiteProductCore.span_hermiteMv
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
import Theorems.Thm_BookProof_HermiteProductCore_hermiteMv_zero
import Theorems.Thm_BookProof_HermiteProductCore_mul_X_mem_span_hermiteMv
open BookProof.HermiteProductCore








open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section



variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution :
    Submodule.span ℂ (Set.range (hermiteMv (d := d))) = ⊤ := by

  rw [eq_top_iff]
  rintro p -
  induction p using MvPolynomial.induction_on with
  | C a =>
    have h : (C a : MvPolynomial (Fin d) ℂ) = a • hermiteMv (0 : Fin d →₀ ℕ) := by
      rw [hermiteMv_zero, MvPolynomial.smul_eq_C_mul, mul_one]
    rw [h]
    exact Submodule.smul_mem _ _ (Submodule.subset_span ⟨0, rfl⟩)
  | add p q hp hq => exact add_mem hp hq
  | mul_X p i hp => rw [mul_comm]; exact mul_X_mem_span_hermiteMv i hp
