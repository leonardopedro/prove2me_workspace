-- Generated from ChapterMaxEntropy.lean — theorem BookProof.ChapterMaxEntropy.entropy_nonneg
import Mathlib
import Definitions.Def_ChapterMaxEntropy
import Definitions.Def_ChapterDutchBook
import Definitions.Def_ChapterIrreversible
open BookProof.ChapterDutchBook
open BookProof.ChapterIrreversible
open BookProof.ChapterMaxEntropy


open Real BigOperators Finset


variable {α : Type*} [Fintype α]


theorem BookProof.ChapterMaxEntropy.entropy_nonneg {p : α → ℝ} (hp : IsProb p) : 0 ≤ entropy p := by sorry
