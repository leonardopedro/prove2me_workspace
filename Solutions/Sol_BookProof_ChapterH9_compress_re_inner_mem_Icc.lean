-- Generated from ChapterH9.lean — solution of BookProof.ChapterH9.compress_re_inner_mem_Icc
import Mathlib
import Definitions.Def_ChapterH9
open BookProof.ChapterH9



noncomputable section


open BookProof.ChapterH1 BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6
open BookProof.ChapterH8
open ContinuousLinearMap


variable {E F G : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G]

set_option maxHeartbeats 1000000 in
theorem solution (V : F →L[ℂ] E) (X : E →L[ℂ] E)
    (hViso : ∀ x : F, ‖V x‖ = ‖x‖) {a b : ℝ}
    (hlow : ∀ x : E, ‖x‖ = 1 → a ≤ (inner ℂ x (X x) : ℂ).re)
    (hhigh : ∀ x : E, ‖x‖ = 1 → (inner ℂ x (X x) : ℂ).re ≤ b)
    (y : F) (hy : ‖y‖ = 1) :
    a ≤ (inner ℂ y (compress V X y) : ℂ).re
      ∧ (inner ℂ y (compress V X y) : ℂ).re ≤ b := by

  have hVy : ‖V y‖ = 1 := by rw [hViso, hy]
  rw [krylov_rayleigh_transfer]
  exact ⟨hlow (V y) hVy, hhigh (V y) hVy⟩
