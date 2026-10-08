-- Generated from ChapterCayleyTransform.lean — theorem BookProof.ChapterCayleyTransform.cayley_apply_ne_self
import Definitions.Def_ChapterUnitaryTransport
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterCayleyTransform
import Definitions.Def_ChapterStoneResolvent
open BookProof.ChapterCayleyTransform


open scoped InnerProductSpace
open Filter Topology


open BookProof.ChapterUnitaryTransport BookProof.ChapterStoneResolvent

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)


theorem BookProof.ChapterCayleyTransform.cayley_apply_ne_self {y : H} (hy : y ≠ 0) : cayley T y ≠ y := by sorry
