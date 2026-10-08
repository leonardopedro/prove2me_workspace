-- Generated from ChapterSchurIrreducible.lean — theorem BookProof.ChapterSchurIrreducible.mem_rangeClosure
import Definitions.Def_ChapterA
import Mathlib
import Definitions.Def_ChapterSchurIrreducible
open BookProof.ChapterSchurIrreducible


open scoped ComplexConjugate InnerProductSpace


open BookProof.ChapterA BookProof.ChapterA.System

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


theorem BookProof.ChapterSchurIrreducible.mem_rangeClosure (F : V →L[ℂ] V) (x : V) : F x ∈ rangeClosure F := by sorry
