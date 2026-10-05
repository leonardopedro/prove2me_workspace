-- Generated from ChapterA3x.lean — solution of BookProof.ChapterA3x.projMixed_three_ne_zero
import Mathlib
import Definitions.Def_ChapterA3x
import Theorems.Thm_BookProof_ChapterA3x_projSym_apply
import Theorems.Thm_BookProof_ChapterA3x_projAnti_apply
open BookProof.ChapterA3x



open Matrix
open scoped BigOperators


open BookProof.ChapterA3 BookProof.ChapterA3j BookProof.ChapterA3n BookProof.ChapterA3o
open BookProof.ChapterA3p

set_option maxHeartbeats 1000000 in
theorem solution : projMixed 3 ≠ 0 := by

  intro h
  set a : Idx 3 := (![0, 0, 1] : Fin 3 → Fin 4) with hadef
  have ha : (projMixed 3) a a = 0 := by rw [h]; simp
  have hsym : ∑ σ : Equiv.Perm (Fin 3), (if a = a ∘ σ then (1 : ℂ) else 0) = 2 := by
    have hZ : ∑ σ : Equiv.Perm (Fin 3), (if a = a ∘ σ then (1 : ℤ) else 0) = 2 := by decide
    calc ∑ σ : Equiv.Perm (Fin 3), (if a = a ∘ σ then (1 : ℂ) else 0)
        = ((∑ σ : Equiv.Perm (Fin 3), (if a = a ∘ σ then (1 : ℤ) else 0) : ℤ) : ℂ) := by
          push_cast
          exact Finset.sum_congr rfl fun σ _ => by split <;> simp
      _ = 2 := by rw [hZ]; norm_num
  have hanti : ∑ σ : Equiv.Perm (Fin 3), signC σ * (if a = a ∘ σ then (1 : ℂ) else 0) = 0 := by
    have hZ : ∑ σ : Equiv.Perm (Fin 3),
        ((Equiv.Perm.sign σ : ℤ) * (if a = a ∘ σ then (1 : ℤ) else 0)) = 0 := by decide
    calc ∑ σ : Equiv.Perm (Fin 3), signC σ * (if a = a ∘ σ then (1 : ℂ) else 0)
        = ((∑ σ : Equiv.Perm (Fin 3),
            ((Equiv.Perm.sign σ : ℤ) * (if a = a ∘ σ then (1 : ℤ) else 0)) : ℤ) : ℂ) := by
          push_cast [signC]
          exact Finset.sum_congr rfl fun σ _ => by split <;> simp
      _ = 0 := by rw [hZ]; norm_num
  rw [projMixed] at ha
  simp only [Matrix.sub_apply, Matrix.one_apply_eq, projSym_apply, projAnti_apply,
    hsym, hanti] at ha
  norm_num [Nat.factorial] at ha
