-- Generated from ChapterHermiteProductCore.lean — solution of BookProof.HermiteProductCore.hermiteMv_erase
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore








open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section



variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) (a : Fin d →₀ ℕ) :
    hermiteMv a = hermiteFactor i (a i) * ∏ j ∈ Finset.univ.erase i, hermiteFactor j (a j) := by

  rw [hermiteMv, ← Finset.mul_prod_erase _ _ (Finset.mem_univ i)]
