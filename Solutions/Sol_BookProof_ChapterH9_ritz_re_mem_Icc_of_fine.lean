-- Generated from ChapterH9.lean — solution of BookProof.ChapterH9.ritz_re_mem_Icc_of_fine
import Mathlib
import Definitions.Def_ChapterH9
import Theorems.Thm_BookProof_ChapterH9_ritz_mem_numRange_compress
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
theorem solution (Vn : F →L[ℂ] E) (Vm : G →L[ℂ] E) (J : F →L[ℂ] G)
    (X : E →L[ℂ] E) (hJ : Vn = Vm.comp J) (hJiso : ∀ x : F, ‖J x‖ = ‖x‖)
    {lam : ℂ} {y : F} (hy : ‖y‖ = 1) (heig : compress Vn X y = lam • y)
    {a b : ℝ} (hlow : ∀ x : G, ‖x‖ = 1 → a ≤ (inner ℂ x (compress Vm X x) : ℂ).re)
    (hhigh : ∀ x : G, ‖x‖ = 1 → (inner ℂ x (compress Vm X x) : ℂ).re ≤ b) :
    a ≤ lam.re ∧ lam.re ≤ b := by

  obtain ⟨x, hx, hval⟩ :=
    ritz_mem_numRange_compress Vn Vm J X hJ hJiso hy heig
  exact ⟨hval ▸ hlow x hx, hval ▸ hhigh x hx⟩
