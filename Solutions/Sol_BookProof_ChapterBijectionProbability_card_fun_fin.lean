-- Generated from ChapterBijectionProbability.lean — solution of BookProof.ChapterBijectionProbability.card_fun_fin
import Mathlib
import Definitions.Def_ChapterBijectionProbability
open BookProof.ChapterBijectionProbability



open scoped Nat
open Filter Asymptotics

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) : Fintype.card (Fin n → Fin n) = n ^ n := by

  simp
