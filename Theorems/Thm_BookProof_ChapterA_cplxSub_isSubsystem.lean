-- Generated from ChapterA1d.lean — theorem BookProof.ChapterA.cplxSub_isSubsystem
import Mathlib
import Definitions.Def_ChapterA1d
import Definitions.Def_ChapterA
open BookProof.ChapterA
open BookProof.ChapterA


open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace




attribute [local instance] InnerProductSpace.rclikeToReal

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]


theorem BookProof.ChapterA.cplxSub_isSubsystem [CompleteSpace V] (M : System ℂ V) {Y : Submodule ℝ V}
    (hJ : ∀ y ∈ Y, (Complex.I : ℂ) • y ∈ Y) (hY : (rxSystem M).IsSubsystem Y) :
    (M).IsSubsystem (cplxSub Y hJ) := by sorry
