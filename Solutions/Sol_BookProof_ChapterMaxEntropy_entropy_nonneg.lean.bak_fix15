-- Generated from ChapterMaxEntropy.lean — solution of BookProof.ChapterMaxEntropy.entropy_nonneg
import Mathlib
import Definitions.Def_ChapterMaxEntropy
import Theorems.Thm_BookProof_ChapterMaxEntropy_IsProb_le_one
import Theorems.Thm_BookProof_ChapterDutchBook_Coherent_nonneg
open BookProof.ChapterMaxEntropy



open Real BigOperators Finset


variable {α : Type*} [Fintype α]

variable {α : Type*} [Fintype α]

set_option maxHeartbeats 1000000 in
theorem solution {p : α → ℝ} (hp : IsProb p) : 0 ≤ entropy p := by

  unfold entropy
  apply Finset.sum_nonneg
  intro i _
  exact Real.negMulLog_nonneg (hp.nonneg i) (hp.le_one i)
