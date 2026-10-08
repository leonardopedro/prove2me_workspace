-- Generated from ChapterSchurIrreducible.lean — theorem BookProof.ChapterSchurIrreducible.rangeClosure_le_ker
import Definitions.Def_ChapterA
import Mathlib
import Definitions.Def_ChapterSchurIrreducible
open BookProof.ChapterSchurIrreducible


open scoped ComplexConjugate InnerProductSpace


open BookProof.ChapterA BookProof.ChapterA.System

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


theorem BookProof.ChapterSchurIrreducible.rangeClosure_le_ker {F G : V →L[ℂ] V} (h : G * F = 0) :
    rangeClosure F ≤ LinearMap.ker (G : V →ₗ[ℂ] V) := by sorry
