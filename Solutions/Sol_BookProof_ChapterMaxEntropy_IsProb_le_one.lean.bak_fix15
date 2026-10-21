-- Generated from ChapterMaxEntropy.lean — solution of BookProof.ChapterMaxEntropy.IsProb.le_one
import Mathlib
import Definitions.Def_ChapterMaxEntropy
import Theorems.Thm_BookProof_ChapterDutchBook_Coherent_nonneg
open BookProof.ChapterMaxEntropy



open Real BigOperators Finset


variable {α : Type*} [Fintype α]

variable {α : Type*} [Fintype α]

set_option maxHeartbeats 1000000 in
theorem solution {p : α → ℝ} (hp : IsProb p) (i : α) : p i ≤ 1 := by

  rw [← hp.sum_one]
  exact Finset.single_le_sum (fun j _ => hp.nonneg j) (Finset.mem_univ i)
