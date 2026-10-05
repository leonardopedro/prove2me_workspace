-- Generated from ChapterSchurFiniteDimensional.lean — theorem BookProof.ChapterSchurFiniteDimensional.Rreal_commutant_eq_real_scalars_finiteDimensional
import Mathlib
import Definitions.Def_ChapterSchurFiniteDimensional
import Definitions.Def_ChapterA
import Definitions.Def_ChapterA1
open BookProof.ChapterA
open BookProof.ChapterA
open BookProof.ChapterA
open BookProof.ChapterSchurFiniteDimensional

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


open scoped ComplexConjugate InnerProductSpace


open BookProof.ChapterA BookProof.ChapterA


theorem BookProof.ChapterSchurFiniteDimensional.Rreal_commutant_eq_real_scalars_finiteDimensional [FiniteDimensional ℂ V] [Nontrivial V]
    (M : System ℂ V) (hirr : M.IsIrreducible) {θ : AntiUnitary V} (hθ : IsConjugation M θ)
    (S : V →L[ℂ] V) :
    (M.Commutes S ∧ CommutesConj θ S) ↔ ∃ r : ℝ, S = ((r : ℂ)) • (1 : V →L[ℂ] V) := by sorry
