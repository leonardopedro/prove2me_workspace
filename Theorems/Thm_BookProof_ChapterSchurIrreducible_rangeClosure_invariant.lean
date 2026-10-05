-- Generated from ChapterSchurIrreducible.lean — theorem BookProof.ChapterSchurIrreducible.rangeClosure_invariant
import Definitions.Def_ChapterA
import Mathlib
import Definitions.Def_ChapterSchurIrreducible
open BookProof.ChapterSchurIrreducible

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


open scoped ComplexConjugate InnerProductSpace


open BookProof.ChapterA BookProof.ChapterA.System


theorem BookProof.ChapterSchurIrreducible.rangeClosure_invariant {F m : V →L[ℂ] V} (hc : Commute F m) {w : V}
    (hw : w ∈ rangeClosure F) : m w ∈ rangeClosure F := by sorry
