-- Generated from ChapterA.lean — theorem BookProof.ChapterA.System.schur_normal_irreducible
import Mathlib
import Definitions.Def_ChapterA
open BookProof.ChapterA
open BookProof.ChapterA


open scoped ComplexConjugate InnerProductSpace

variable {𝔽 : Type*} [RCLike 𝔽] {V : Type*} [NormedAddCommGroup V]
    [InnerProductSpace 𝔽 V] [CompleteSpace V]

theorem BookProof.ChapterA.System.schur_normal_irreducible (M : System 𝔽 V) (hM : IsNormal M)
    (hSchur : ∀ S : V →L[𝔽] V, M.Commutes S → IsSelfAdjoint S →
      ∃ c : 𝔽, S = c • (1 : V →L[𝔽] V)) :
    IsIrreducible M := by sorry
