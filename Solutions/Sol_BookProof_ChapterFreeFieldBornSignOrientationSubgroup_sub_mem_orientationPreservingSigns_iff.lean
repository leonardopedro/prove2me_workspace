-- Generated from ChapterFreeFieldBornSignOrientationSubgroup.lean — solution of BookProof.ChapterFreeFieldBornSignOrientationSubgroup.sub_mem_orientationPreservingSigns_iff
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSignOrientationSubgroup
import Theorems.Thm_BookProof_ChapterFreeFieldBornSignOrientationKernel_orientationPreserving_xor_iff
open BookProof.ChapterFreeFieldBornSignOrientationSubgroup



open BookProof.ChapterFreeFieldBornSignHom
open BookProof.ChapterFreeFieldBornSignMatrix
open BookProof.ChapterFreeFieldBornSignOrientation
open BookProof.ChapterFreeFieldBornSignOrientationKernel
open BookProof.ChapterFreeFieldBornSignOrientationCard


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (b₁ b₂ : Fin n → Bool) :
    b₁ - b₂ ∈ orientationPreservingSigns n ↔
      (b₁ ∈ orientationPreservingSigns n ↔
       b₂ ∈ orientationPreservingSigns n) := by

  have hsub : b₁ - b₂ = fun k => xor (b₁ k) (b₂ k) := by
    funext k
    change b₁ k - b₂ k = xor (b₁ k) (b₂ k)
    cases b₁ k <;> cases b₂ k <;> rfl
  rw [hsub]
  exact orientationPreserving_xor_iff b₁ b₂
