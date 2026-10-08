-- Generated from ChapterMaxEntropy.lean — theorem BookProof.ChapterMaxEntropy.IsProb.le_one
import Mathlib
import Definitions.Def_ChapterMaxEntropy
import Definitions.Def_ChapterDutchBook
open BookProof.ChapterDutchBook
open BookProof.ChapterMaxEntropy


open Real BigOperators Finset


variable {α : Type*} [Fintype α]


theorem BookProof.ChapterMaxEntropy.IsProb.le_one {p : α → ℝ} (hp : IsProb p) (i : α) : p i ≤ 1 := by sorry
