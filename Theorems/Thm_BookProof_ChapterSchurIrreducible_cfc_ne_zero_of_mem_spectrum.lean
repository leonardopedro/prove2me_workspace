-- Generated from ChapterSchurIrreducible.lean — theorem BookProof.ChapterSchurIrreducible.cfc_ne_zero_of_mem_spectrum
import Definitions.Def_ChapterA
import Mathlib
import Definitions.Def_ChapterSchurIrreducible
open BookProof.ChapterSchurIrreducible


open scoped ComplexConjugate InnerProductSpace


open BookProof.ChapterA BookProof.ChapterA.System

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


theorem BookProof.ChapterSchurIrreducible.cfc_ne_zero_of_mem_spectrum [Nontrivial V] {T : V →L[ℂ] V} (hT : IsSelfAdjoint T)
    {f : ℝ → ℝ} (hf : Continuous f) {p : ℝ} (hp : p ∈ spectrum ℝ T) (hfp : f p ≠ 0) :
    cfc f T ≠ 0 := by sorry
