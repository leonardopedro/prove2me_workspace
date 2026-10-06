-- Generated from ChapterBijectionProbability.lean — theorem BookProof.ChapterBijectionProbability.bijProb_eq_card_ratio
import Mathlib
import Definitions.Def_ChapterBijectionProbability
open BookProof.ChapterBijectionProbability


open scoped Nat
open Filter Asymptotics

theorem BookProof.ChapterBijectionProbability.bijProb_eq_card_ratio (n : ℕ) :
    bijProb n =
      (Fintype.card {f : Fin n → Fin n // Function.Bijective f} : ℝ)
        / (Fintype.card (Fin n → Fin n) : ℝ) := by sorry
