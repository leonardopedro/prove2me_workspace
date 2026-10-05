-- Generated from ChapterSchurIrreducible.lean — theorem BookProof.ChapterSchurIrreducible.isClosed_rangeClosure
import Definitions.Def_ChapterA
import Mathlib
import Definitions.Def_ChapterSchurIrreducible
open BookProof.ChapterSchurIrreducible

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


open scoped ComplexConjugate InnerProductSpace


open BookProof.ChapterA BookProof.ChapterA.System


theorem BookProof.ChapterSchurIrreducible.isClosed_rangeClosure (F : V →L[ℂ] V) :
    IsClosed ((rangeClosure F : Submodule ℂ V) : Set V) := by sorry
