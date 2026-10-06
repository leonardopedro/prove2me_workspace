-- Generated from ChapterMaxEntropy.lean — theorem BookProof.ChapterMaxEntropy.isProb_uniform
import Mathlib
import Definitions.Def_ChapterMaxEntropy
import Definitions.Def_ChapterA3n
import Definitions.Def_ChapterDutchBook
open BookProof.ChapterA3n
open BookProof.ChapterDutchBook
open BookProof.ChapterMaxEntropy

variable {α : Type*} [Fintype α]


open Real BigOperators Finset



theorem BookProof.ChapterMaxEntropy.isProb_uniform [Nonempty α] : IsProb (uniform α) := by sorry
