-- Generated from ChapterSchurIrreducible.lean — theorem BookProof.ChapterSchurIrreducible.selfAdjoint_commutant_scalar
import Mathlib
import Definitions.Def_ChapterSchurIrreducible
import Definitions.Def_ChapterA
open BookProof.ChapterA
open BookProof.ChapterA
open BookProof.ChapterSchurIrreducible

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


open scoped ComplexConjugate InnerProductSpace


open BookProof.ChapterA BookProof.ChapterA


theorem BookProof.ChapterSchurIrreducible.selfAdjoint_commutant_scalar (M : System ℂ V) (hirr : M.IsIrreducible)
    {T : V →L[ℂ] V} (hT : IsSelfAdjoint T) (hcomm : M.Commutes T) :
    ∃ c : ℝ, T = (c : ℂ) • (1 : V →L[ℂ] V) := by sorry
