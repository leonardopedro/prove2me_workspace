-- Generated from ChapterFreeFieldBornSignOrientationKernel.lean — theorem BookProof.ChapterFreeFieldBornSignOrientationKernel.orientationPreserving_xor
import Definitions.Def_ChapterFreeFieldBornSignHom
import Definitions.Def_ChapterFreeFieldBornSignMatrix
import Definitions.Def_ChapterFreeFieldBornSignOrientation
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSignOrientationKernel
open BookProof.ChapterFreeFieldBornSignOrientationKernel


open BookProof.ChapterFreeFieldBornSignHom
open BookProof.ChapterFreeFieldBornSignMatrix
open BookProof.ChapterFreeFieldBornSignOrientation


variable {n : ℕ}


theorem BookProof.ChapterFreeFieldBornSignOrientationKernel.orientationPreserving_xor {b₁ b₂ : Fin n → Bool}
    (h₁ : flipMatrix b₁ ∈ Matrix.specialOrthogonalGroup (Fin n) ℝ)
    (h₂ : flipMatrix b₂ ∈ Matrix.specialOrthogonalGroup (Fin n) ℝ) :
    flipMatrix (fun k => xor (b₁ k) (b₂ k)) ∈
      Matrix.specialOrthogonalGroup (Fin n) ℝ := by sorry
