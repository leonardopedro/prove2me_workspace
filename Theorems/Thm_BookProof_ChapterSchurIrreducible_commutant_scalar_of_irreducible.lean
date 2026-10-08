-- Generated from ChapterSchurIrreducible.lean — theorem BookProof.ChapterSchurIrreducible.commutant_scalar_of_irreducible
import Mathlib
import Definitions.Def_ChapterSchurIrreducible
import Definitions.Def_ChapterA
open BookProof.ChapterA
open BookProof.ChapterA
open BookProof.ChapterSchurIrreducible


open scoped ComplexConjugate InnerProductSpace


open BookProof.ChapterA BookProof.ChapterA

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


theorem BookProof.ChapterSchurIrreducible.commutant_scalar_of_irreducible (M : System ℂ V) (hM : M.IsNormal)
    (hirr : M.IsIrreducible) {S : V →L[ℂ] V} (hcomm : M.Commutes S) :
    ∃ c : ℂ, S = c • (1 : V →L[ℂ] V) := by sorry
