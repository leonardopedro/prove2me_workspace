-- Generated from ChapterBijectionProbability.lean — solution of BookProof.ChapterBijectionProbability.card_bijective_fin
import Mathlib
import Definitions.Def_ChapterBijectionProbability
open BookProof.ChapterBijectionProbability



open scoped Nat
open Filter Asymptotics

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) :
    Fintype.card {f : Fin n → Fin n // Function.Bijective f} = n ! := by

  rw [← Fintype.card_congr (permEquivBijective n), Fintype.card_perm, Fintype.card_fin]
