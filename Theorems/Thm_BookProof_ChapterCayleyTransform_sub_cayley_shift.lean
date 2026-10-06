-- Generated from ChapterCayleyTransform.lean — theorem BookProof.ChapterCayleyTransform.sub_cayley_shift
import Definitions.Def_ChapterUnitaryTransport
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterCayleyTransform
import Definitions.Def_ChapterStoneResolvent
open BookProof.ChapterCayleyTransform

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)


open scoped InnerProductSpace
open Filter Topology


open BookProof.ChapterUnitaryTransport BookProof.ChapterStoneResolvent


theorem BookProof.ChapterCayleyTransform.sub_cayley_shift (x : T.domain) :
    T.shift (-1) x - cayley T (T.shift (-1) x) = (2 * Complex.I) • (x : H) := by sorry
