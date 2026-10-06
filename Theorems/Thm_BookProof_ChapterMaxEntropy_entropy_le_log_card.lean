-- Generated from ChapterMaxEntropy.lean — theorem BookProof.ChapterMaxEntropy.entropy_le_log_card
import Mathlib
import Definitions.Def_ChapterMaxEntropy
import Definitions.Def_ChapterDutchBook
import Definitions.Def_ChapterIrreversible
open BookProof.ChapterDutchBook
open BookProof.ChapterIrreversible
open BookProof.ChapterMaxEntropy

variable {α : Type*} [Fintype α]


open Real BigOperators Finset



theorem BookProof.ChapterMaxEntropy.entropy_le_log_card [Nonempty α] {p : α → ℝ} (hp : IsProb p) :
    entropy p ≤ Real.log (Fintype.card α) := by sorry
