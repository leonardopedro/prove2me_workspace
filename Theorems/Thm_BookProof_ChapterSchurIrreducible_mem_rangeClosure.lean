-- Generated from ChapterSchurIrreducible.lean — theorem BookProof.ChapterSchurIrreducible.mem_rangeClosure
import Definitions.Def_ChapterA
import Mathlib
import Definitions.Def_ChapterSchurIrreducible
import Definitions.Def_ChapterA4
open BookProof.ChapterSchurIrreducible

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


open scoped ComplexConjugate InnerProductSpace


open BookProof.ChapterA BookProof.ChapterA.System


theorem BookProof.ChapterSchurIrreducible.mem_rangeClosure (F : V →L[ℂ] V) (x : V) : F x ∈ rangeClosure F := by sorry
