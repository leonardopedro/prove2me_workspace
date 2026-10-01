-- Generated from ChapterHermiteProductCore.lean — solution of BookProof.HermiteProductCore.mul_X_mem_span_hermiteMv
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
import Theorems.Thm_BookProof_HermiteProductCore_hermiteMv_X_mul
open BookProof.HermiteProductCore




open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section

set_option maxHeartbeats 1000000 in
 = a i - 1 := by simp [Finsupp.tsub_apply]
  rw [hermiteMv_erase i a, hermiteMv_erase i (a + Finsupp.single i 1),
    hermiteMv_erase i (a - Finsupp.single i 1), hrest _ hadd, hrest _ hsub, hai, hsi,
    ← mul_assoc, hermiteFactor_X_mul i (a i)]
  rw [add_mul, smul_mul_assoc]

/-- The span of the product Hermite p :=
  olynomials is stable under multiplication by
  each coordinate. -/
  theorem mul_X_mem_span_hermiteMv (i : Fin d) {p : MvPolynomial (Fin d) ℂ}
      (hp : p ∈ Submodule.span ℂ (Set.range (hermiteMv (d := d)))) :
      X i * p ∈ Submodule.span ℂ (Set.range (hermiteMv (d := d))) := by
    induction hp using Submodule.span_induction with
    | mem x hx =>
      obtain ⟨a, rfl⟩ := hx
      rw [hermiteM
