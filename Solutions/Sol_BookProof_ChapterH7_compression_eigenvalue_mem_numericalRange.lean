-- Generated from ChapterH7.lean — solution of BookProof.ChapterH7.compression_eigenvalue_mem_numericalRange
import Mathlib
import Definitions.Def_ChapterH7
import Theorems.Thm_BookProof_ChapterH7_inner_self_real
import Theorems.Thm_BookProof_ChapterH6_krylovRetainsDominantSpectrum
open BookProof.ChapterH7



noncomputable section

open BookProof.ChapterH4 BookProof.ChapterH6

set_option maxHeartbeats 1000000 in
theorem solution (V : F →L[ℂ] E) (X : E →L[ℂ] E)
    (hX : IsSelfAdjoint X) (hViso : ∀ x : F, ‖V x‖ = ‖x‖)
    {lam : ℂ} {y : F} (hy : ‖y‖ = 1) (heig : compress V X y = lam • y)
    {a b : ℝ} (hlow : ∀ x : E, ‖x‖ = 1 → a ≤ (inner ℂ x (X x) : ℂ).re)
    (hhigh : ∀ x : E, ‖x‖ = 1 → (inner ℂ x (X x) : ℂ).re ≤ b) :
    lam.im = 0 ∧ a ≤ lam.re ∧ lam.re ≤ b := by

  have hval : lam = inner ℂ (V y) (X (V y)) :=
    (krylovRetainsDominantSpectrum V X hViso lam y hy heig).1
  have hVy : ‖V y‖ = 1 := by rw [hViso, hy]
  refine ⟨?_, ?_, ?_⟩
  · rw [hval]; exact inner_self_real X hX (V y)
  · rw [hval]; exact hlow _ hVy
  · rw [hval]; exact hhigh _ hVy
