-- Generated from ChapterMaxEntropy.lean — solution of BookProof.ChapterMaxEntropy.entropy_le_entropy_uniform
import Mathlib
import Definitions.Def_ChapterMaxEntropy
import Theorems.Thm_BookProof_ChapterMaxEntropy_entropy_le_log_card
import Theorems.Thm_BookProof_ChapterMaxEntropy_entropy_uniform
open BookProof.ChapterMaxEntropy



open Real BigOperators Finset


variable {α : Type*} [Fintype α]

variable {α : Type*} [Fintype α]

set_option maxHeartbeats 1000000 in
theorem solution [Nonempty α] {p : α → ℝ} (hp : IsProb p) :
    entropy p ≤ entropy (uniform α) := by

  rw [entropy_uniform]
  exact entropy_le_log_card hp
