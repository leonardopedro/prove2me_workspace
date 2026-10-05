-- Generated from ChapterSchurIrreducible.lean — theorem BookProof.ChapterSchurIrreducible.rangeClosure_ne_bot
import Definitions.Def_ChapterA
import Mathlib
import Definitions.Def_ChapterSchurIrreducible
open BookProof.ChapterSchurIrreducible

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


open scoped ComplexConjugate InnerProductSpace


open BookProof.ChapterA BookProof.ChapterA.System


theorem BookProof.ChapterSchurIrreducible.rangeClosure_ne_bot {F : V →L[ℂ] V} (hF : F ≠ 0) : rangeClosure F ≠ ⊥ := by sorry
