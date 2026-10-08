-- Generated from ChapterA2b.lean — theorem BookProof.ChapterA.Rreal_commutant_eq_real_scalars
import Mathlib
import Definitions.Def_ChapterA2b
import Definitions.Def_ChapterA
import Definitions.Def_ChapterA1
open BookProof.ChapterA
open BookProof.ChapterA
open BookProof.ChapterA


open scoped ComplexConjugate InnerProductSpace


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


theorem BookProof.ChapterA.Rreal_commutant_eq_real_scalars (M : System ℂ V) (hSchur : IsSchurFull M)
    {θ : AntiUnitary V} (_hθ : IsConjugation M θ) (S : V →L[ℂ] V) :
    (M.Commutes S ∧ CommutesConj θ S) ↔ ∃ r : ℝ, S = ((r : ℂ)) • (1 : V →L[ℂ] V) := by sorry
