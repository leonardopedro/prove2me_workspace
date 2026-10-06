-- Generated from ChapterBijectionProbability.lean — theorem BookProof.ChapterBijectionProbability.card_bijective_fin
import Mathlib
import Definitions.Def_ChapterBijectionProbability
open BookProof.ChapterBijectionProbability


open scoped Nat
open Filter Asymptotics

theorem BookProof.ChapterBijectionProbability.card_bijective_fin (n : ℕ) :
    Fintype.card {f : Fin n → Fin n // Function.Bijective f} = n ! := by sorry
