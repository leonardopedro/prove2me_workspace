-- Generated from ChapterCyclicDirectSum.lean — solution of BookProof.ChapterCyclicDirectSum.exists_isHilbertSum_cyclicSubspace
import Mathlib
import Definitions.Def_ChapterCyclicDirectSum
import Theorems.Thm_BookProof_ChapterCyclicDecomposition_exists_cyclic_decomposition
open BookProof.ChapterCyclicDirectSum



noncomputable section

open MeasureTheory Complex


open BookProof.ChapterCyclicDecomposition

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : H →L[ℂ] H) (hT : IsStarNormal T)

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : H →L[ℂ] H) (hT : IsStarNormal T)

set_option maxHeartbeats 1000000 in
theorem solution :
    ∃ S : Set H, OrthogonalCyclicFamily T hT S ∧
      IsHilbertSum ℂ (fun x : S => (cyclicSubspace T hT (x : H)))
        (fun x : S => (cyclicSubspace T hT (x : H)).subtypeₗᵢ) := by

  obtain ⟨S, hS, htop⟩ := exists_cyclic_decomposition T hT
  exact ⟨S, hS, isHilbertSum_cyclicSubspace T hT hS htop⟩
