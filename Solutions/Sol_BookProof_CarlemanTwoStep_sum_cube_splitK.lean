-- Generated from ChapterCarlemanTwoStep.lean — solution of BookProof.CarlemanTwoStep.sum_cube_splitK
import Mathlib
import Definitions.Def_ChapterCarlemanTwoStep
open BookProof.CarlemanTwoStep











open Finset
open BookProof.HermiteCarleman

noncomputable section

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (d N : ℕ) (i : Fin d) (k : ℕ) (F : (Fin d →₀ ℕ) → ℂ) :
    ∑ a ∈ cube d N, F a = ∑ a ∈ innK d N i k, F a + ∑ a ∈ faceK d N i k, F a := by

  classical
  rw [innK, faceK,
    ← Finset.sum_filter_add_sum_filter_not (cube d N) (fun a => a i + k ≤ N) F]
  congr 1
  refine Finset.sum_congr ?_ fun _ _ => rfl
  ext a
  simp only [Finset.mem_filter, mem_cube]
  constructor
  · rintro ⟨h1, h2⟩; exact ⟨h1, by omega⟩
  · rintro ⟨h1, h2⟩; exact ⟨h1, by omega⟩
