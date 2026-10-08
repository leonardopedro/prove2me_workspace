-- Generated from ChapterSchurIrreducible.lean — theorem BookProof.ChapterSchurIrreducible.isClosed_rangeClosure
import Definitions.Def_ChapterA
import Mathlib
import Definitions.Def_ChapterSchurIrreducible
open BookProof.ChapterSchurIrreducible


open scoped ComplexConjugate InnerProductSpace


open BookProof.ChapterA BookProof.ChapterA.System

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


theorem BookProof.ChapterSchurIrreducible.isClosed_rangeClosure (F : V →L[ℂ] V) :
    IsClosed ((rangeClosure F : Submodule ℂ V) : Set V) := by sorry
