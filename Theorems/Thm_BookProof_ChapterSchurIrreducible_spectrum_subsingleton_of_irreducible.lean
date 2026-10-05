-- Generated from ChapterSchurIrreducible.lean — theorem BookProof.ChapterSchurIrreducible.spectrum_subsingleton_of_irreducible
import Mathlib
import Definitions.Def_ChapterSchurIrreducible
import Definitions.Def_ChapterA
open BookProof.ChapterA
open BookProof.ChapterA
open BookProof.ChapterSchurIrreducible

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


open scoped ComplexConjugate InnerProductSpace


open BookProof.ChapterA BookProof.ChapterA


theorem BookProof.ChapterSchurIrreducible.spectrum_subsingleton_of_irreducible [Nontrivial V] (M : System ℂ V)
    (hirr : M.IsIrreducible) {T : V →L[ℂ] V} (hT : IsSelfAdjoint T) (hcomm : M.Commutes T)
    {a b : ℝ} (ha : a ∈ spectrum ℝ T) (hb : b ∈ spectrum ℝ T) : a = b := by sorry
