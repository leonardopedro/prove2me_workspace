-- Generated from ChapterA1d.lean — theorem BookProof.ChapterA.Jmap_sq
import Mathlib
import Definitions.Def_ChapterA1d
import Definitions.Def_ChapterA
open BookProof.ChapterA

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]


open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace




attribute [local instance] InnerProductSpace.rclikeToReal


theorem BookProof.ChapterA.Jmap_sq (x : V) : Jmap (Jmap x) = -x := by sorry
