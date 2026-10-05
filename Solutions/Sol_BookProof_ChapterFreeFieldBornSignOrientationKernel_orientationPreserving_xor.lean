-- Generated from ChapterFreeFieldBornSignOrientationKernel.lean — solution of BookProof.ChapterFreeFieldBornSignOrientationKernel.orientationPreserving_xor
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSignOrientationKernel
import Theorems.Thm_BookProof_ChapterFreeFieldBornSignMatrix_flipMatrix_xor
open BookProof.ChapterFreeFieldBornSignOrientationKernel



open BookProof.ChapterFreeFieldBornSignHom
open BookProof.ChapterFreeFieldBornSignMatrix
open BookProof.ChapterFreeFieldBornSignOrientation


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {b₁ b₂ : Fin n → Bool}
    (h₁ : flipMatrix b₁ ∈ Matrix.specialOrthogonalGroup (Fin n) ℝ)
    (h₂ : flipMatrix b₂ ∈ Matrix.specialOrthogonalGroup (Fin n) ℝ) :
    flipMatrix (fun k => xor (b₁ k) (b₂ k)) ∈
      Matrix.specialOrthogonalGroup (Fin n) ℝ := by

  rw [flipMatrix_xor]
  exact mul_mem h₁ h₂
