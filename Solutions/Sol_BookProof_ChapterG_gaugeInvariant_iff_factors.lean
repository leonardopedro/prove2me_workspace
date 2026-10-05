-- Generated from ChapterG.lean — solution of BookProof.ChapterG.gaugeInvariant_iff_factors
import Mathlib
import Definitions.Def_ChapterG
import Theorems.Thm_BookProof_ChapterG_swap_mem_gaugeGroup
open BookProof.ChapterG



open scoped ComplexConjugate InnerProductSpace Matrix

set_option maxHeartbeats 1000000 in
theorem solution {X Y Z : Type*} {π : X → Y}
    (hπ : Function.Surjective π) (f : X → Z) :
    (∀ g ∈ gaugeGroup π, ∀ x, f (g x) = f x) ↔ ∃ h : Y → Z, f = h ∘ π := by

  classical
  constructor
  · intro hinv
    have hconst : ∀ x x', π x = π x' → f x = f x' := by
      intro x x' he
      have h := hinv (Equiv.swap x x') (swap_mem_gaugeGroup he) x
      rw [Equiv.swap_apply_left] at h
      exact h.symm
    refine ⟨f ∘ Function.surjInv hπ, ?_⟩
    funext x
    change f x = f (Function.surjInv hπ (π x))
    exact (hconst _ _ (by rw [Function.surjInv_eq hπ])).symm
  · rintro ⟨h, rfl⟩ g hg x
    simp only [Function.comp_apply]
    rw [hg x]
