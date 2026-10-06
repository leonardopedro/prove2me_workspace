-- Generated from ChapterMaxEntropy.lean — theorem BookProof.ChapterMaxEntropy.entropy_eq_log_card_iff
import Mathlib
import Definitions.Def_ChapterMaxEntropy
import Definitions.Def_ChapterA3n
import Definitions.Def_ChapterDutchBook
import Definitions.Def_ChapterIrreversible
open BookProof.ChapterA3n
open BookProof.ChapterDutchBook
open BookProof.ChapterIrreversible
open BookProof.ChapterMaxEntropy

variable {α : Type*} [Fintype α]


open Real BigOperators Finset



theorem BookProof.ChapterMaxEntropy.entropy_eq_log_card_iff [Nonempty α] {p : α → ℝ} (hp : IsProb p) :
    entropy p = Real.log (Fintype.card α) ↔ p = uniform α := by sorry
