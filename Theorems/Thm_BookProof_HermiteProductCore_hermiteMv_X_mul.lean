-- Generated from ChapterHermiteProductCore.lean — theorem BookProof.HermiteProductCore.hermiteMv_X_mul
import Definitions.Def_ChapterHermiteFunctions
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore

variable {d : ℕ}



open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section

 1 := by
  simp [hermiteMv, hermiteFactor_zero]

theorem BookProof.HermiteProductCore.hermiteMv_X_mul (i : Fin d) (a : Fin d →₀ ℕ) :
    hermiteMv a = hermiteFactor i (a i) * ∏ j ∈ Finset.univ.erase i, hermiteFactor j (a j) := by
  rw [hermiteMv, ← Finset.mul_prod_erase _ _ (Finset.mem_univ i)]

/-- **The three-term recurrence in `d` := by sorry
