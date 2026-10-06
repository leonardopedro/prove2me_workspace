-- Generated from ChapterMaxEntropy.lean — theorem BookProof.ChapterMaxEntropy.entropy_uniform
import Mathlib
import Definitions.Def_ChapterMaxEntropy
import Definitions.Def_ChapterA3n
import Definitions.Def_ChapterIrreversible
open BookProof.ChapterA3n
open BookProof.ChapterIrreversible
open BookProof.ChapterMaxEntropy

variable {α : Type*} [Fintype α]


open Real BigOperators Finset



theorem BookProof.ChapterMaxEntropy.entropy_uniform [Nonempty α] :
    entropy (uniform α) = Real.log (Fintype.card α) := by sorry
