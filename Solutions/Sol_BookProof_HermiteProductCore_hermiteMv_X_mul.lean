-- Generated from ChapterHermiteProductCore.lean — solution of BookProof.HermiteProductCore.hermiteMv_X_mul
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
import Theorems.Thm_BookProof_HermiteProductCore_hermiteFactor_X_mul
import Theorems.Thm_BookProof_HermiteProductCore_hermiteMv_erase
open BookProof.HermiteProductCore








open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section



variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) (a : Fin d →₀ ℕ) :
    X i * hermiteMv a
      = hermiteMv (a + Finsupp.single i 1) + ((a i : ℂ)) • hermiteMv (a - Finsupp.single i 1) := by

  classical
  have hrest : ∀ b : Fin d →₀ ℕ, (∀ j : Fin d, j ≠ i → b j = a j) →
      ∏ j ∈ Finset.univ.erase i, hermiteFactor j (b j)
        = ∏ j ∈ Finset.univ.erase i, hermiteFactor j (a j) := by
    intro b hb
    exact Finset.prod_congr rfl fun j hj => by rw [hb j (Finset.ne_of_mem_erase hj)]
  have hadd : ∀ j : Fin d, j ≠ i → (a + Finsupp.single i 1 : Fin d →₀ ℕ) j = a j := by
    intro j hj; simp [hj]
  have hsub : ∀ j : Fin d, j ≠ i → (a - Finsupp.single i 1 : Fin d →₀ ℕ) j = a j := by
    intro j hj; simp [Finsupp.tsub_apply, hj]
  have hai : (a + Finsupp.single i 1 : Fin d →₀ ℕ) i = a i + 1 := by simp
  have hsi : (a - Finsupp.single i 1 : Fin d →₀ ℕ) i = a i - 1 := by simp [Finsupp.tsub_apply]
  rw [hermiteMv_erase i a, hermiteMv_erase i (a + Finsupp.single i 1),
    hermiteMv_erase i (a - Finsupp.single i 1), hrest _ hadd, hrest _ hsub, hai, hsi,
    ← mul_assoc, hermiteFactor_X_mul i (a i)]
  rw [add_mul, smul_mul_assoc]
