-- Generated from ChapterA1e.lean — theorem BookProof.ChapterA.sup_JY_closure_isSubsystem
import Mathlib
import Definitions.Def_ChapterA1e
import Definitions.Def_ChapterA
open BookProof.ChapterA
open BookProof.ChapterA


open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace


attribute [local instance] InnerProductSpace.rclikeToReal

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


theorem BookProof.ChapterA.sup_JY_closure_isSubsystem (M : System ℂ V) {Y : Submodule ℝ V}
    (hY : (rxSystem M).IsSubsystem Y) :
    (rxSystem M).IsSubsystem (Y ⊔ JY Y).topologicalClosure := by sorry
