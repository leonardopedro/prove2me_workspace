-- Generated from ChapterHermiteProductCore.lean — theorem BookProof.HermiteProductCore.mul_X_mem_span_hermiteMv
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore

variable {d : ℕ}



open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section

 = a i - 1 := by simp [Finsupp.tsub_apply]
  rw [hermiteMv_erase i a, hermiteMv_erase i (a + Finsupp.single i 1),
    hermiteMv_erase i (a - Finsupp.single i 1), hrest _ hadd, hrest _ hsub, hai, hsi,
    ← mul_assoc, hermiteFactor_X_mul i (a i)]
  rw [add_mul, smul_mul_assoc]

/-- The span of the product Hermite p := by sorry
