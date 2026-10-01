-- Generated from ChapterHermiteProductCore.lean — solution of BookProof.HermiteProductCore.span_hermiteMv
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
import Theorems.Thm_BookProof_HermiteProductCore_mul_X_mem_span_hermiteMv
import Theorems.Thm_BookProof_HermiteProductCore_hermiteMv_zero
open BookProof.HermiteProductCore




open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section

set_option maxHeartbeats 1000000 in
X_mul]
    exact add_mem (Submodule.subset_span ⟨_, rfl⟩)
      (Submodule.smul_mem _ _ (Submodule.subset_span ⟨_, rfl⟩))
  | zero => simp
  | a :=
  dd x y _ _ hx hy => rw [mul_add]; exact add_mem hx hy
    | smul c x _ hx => rw [mul_smul_comm]; exact Submodule.smul_mem _ _ hx
  
  /-- **The product Hermite polynomials span all polynomials.** -/
  theorem span_hermiteMv :
      Submodule.span ℂ (Set.range (hermiteMv (d := d))) = ⊤ := by
    rw [eq_top_iff]
    rintro p -
    induction p using MvPolynomial.induction_on with
    | C a =>
      have h : (C a : MvPolynomial (Fin d) ℂ) = a • hermiteMv (0 :
