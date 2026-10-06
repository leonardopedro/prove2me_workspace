-- Generated from ChapterBijectionProbability.lean — solution of BookProof.ChapterBijectionProbability.bijProb_eq_card_ratio
import Mathlib
import Definitions.Def_ChapterBijectionProbability
import Theorems.Thm_BookProof_ChapterBijectionProbability_card_fun_fin
import Theorems.Thm_BookProof_ChapterBijectionProbability_card_bijective_fin
open BookProof.ChapterBijectionProbability



open scoped Nat
open Filter Asymptotics

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) :
    bijProb n =
      (Fintype.card {f : Fin n → Fin n // Function.Bijective f} : ℝ)
        / (Fintype.card (Fin n → Fin n) : ℝ) := by

  rw [card_bijective_fin, card_fun_fin, bijProb]
  push_cast
  ring
