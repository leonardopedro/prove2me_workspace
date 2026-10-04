-- Generated from ChapterA2b.lean — theorem BookProof.ChapterA.commutant_eq_complex_scalars
import Mathlib
import Definitions.Def_ChapterA2b
import Definitions.Def_ChapterA
open BookProof.ChapterA
open BookProof.ChapterA

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


open scoped ComplexConjugate InnerProductSpace



theorem BookProof.ChapterA.commutant_eq_complex_scalars (M : System ℂ V) (hSchur : IsSchurFull M)
    (S : V →L[ℂ] V) :
    M.Commutes S ↔ ∃ c : ℂ, S = c • (1 : V →L[ℂ] V) := by sorry
