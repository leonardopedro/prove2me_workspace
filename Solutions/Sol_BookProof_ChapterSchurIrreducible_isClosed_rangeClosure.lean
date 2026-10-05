-- Generated from ChapterSchurIrreducible.lean — solution of BookProof.ChapterSchurIrreducible.isClosed_rangeClosure
import Mathlib
import Definitions.Def_ChapterSchurIrreducible
open BookProof.ChapterSchurIrreducible



open scoped ComplexConjugate InnerProductSpace


open BookProof.ChapterA BookProof.ChapterA.System

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

set_option maxHeartbeats 1000000 in
theorem solution (F : V →L[ℂ] V) :
    IsClosed ((rangeClosure F : Submodule ℂ V) : Set V) := Submodule.isClosed_topologicalClosure _
