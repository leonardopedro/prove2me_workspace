-- Generated from ChapterHermiteProductCore.lean — solution of BookProof.HermiteProductCore.mul_X_mem_span_hermiteMv
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
import Theorems.Thm_BookProof_HermiteProductCore_hermiteMv_X_mul
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteProductCore








open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section



variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) {p : MvPolynomial (Fin d) ℂ}
    (hp : p ∈ Submodule.span ℂ (Set.range (hermiteMv (d := d)))) :
    X i * p ∈ Submodule.span ℂ (Set.range (hermiteMv (d := d))) := by

  induction hp using Submodule.span_induction with
  | mem x hx =>
    obtain ⟨a, rfl⟩ := hx
    rw [hermiteMv_X_mul]
    exact add_mem (Submodule.subset_span ⟨_, rfl⟩)
      (Submodule.smul_mem _ _ (Submodule.subset_span ⟨_, rfl⟩))
  | zero => simp
  | add x y _ _ hx hy => rw [mul_add]; exact add_mem hx hy
  | smul c x _ hx => rw [mul_smul_comm]; exact Submodule.smul_mem _ _ hx
