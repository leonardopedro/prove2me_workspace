-- Generated from ChapterMaxEntropy.lean — theorem BookProof.ChapterMaxEntropy.entropy_uniform
import Mathlib
import Definitions.Def_ChapterMaxEntropy
import Definitions.Def_ChapterA3n
import Definitions.Def_ChapterIrreversible
open BookProof.ChapterA3n
open BookProof.ChapterIrreversible
open BookProof.ChapterMaxEntropy


open Real BigOperators Finset


variable {α : Type*} [Fintype α]


theorem BookProof.ChapterMaxEntropy.entropy_uniform [Nonempty α] :
    entropy (uniform α) = Real.log (Fintype.card α) := by sorry
