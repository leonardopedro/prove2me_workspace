-- Generated from ChapterSchurIrreducible.lean — theorem BookProof.ChapterSchurIrreducible.isIrreducible_iff_schur
import Mathlib
import Definitions.Def_ChapterSchurIrreducible
import Definitions.Def_ChapterA
open BookProof.ChapterA
open BookProof.ChapterA
open BookProof.ChapterSchurIrreducible

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


open scoped ComplexConjugate InnerProductSpace


open BookProof.ChapterA BookProof.ChapterA


theorem BookProof.ChapterSchurIrreducible.isIrreducible_iff_schur (M : System ℂ V) (hM : M.IsNormal) :
    M.IsIrreducible ↔
      ∀ S : V →L[ℂ] V, M.Commutes S → IsSelfAdjoint S → ∃ c : ℂ, S = c • (1 : V →L[ℂ] V) := by sorry
