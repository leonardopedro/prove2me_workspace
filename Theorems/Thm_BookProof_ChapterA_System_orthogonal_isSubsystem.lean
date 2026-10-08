-- Generated from ChapterA.lean — theorem BookProof.ChapterA.System.orthogonal_isSubsystem
import Mathlib
import Definitions.Def_ChapterA
open BookProof.ChapterA
open BookProof.ChapterA


open scoped ComplexConjugate InnerProductSpace

variable {𝔽 : Type*} [RCLike 𝔽] {V : Type*} [NormedAddCommGroup V]
    [InnerProductSpace 𝔽 V] [CompleteSpace V]

theorem BookProof.ChapterA.System.orthogonal_isSubsystem (M : System 𝔽 V) (hM : IsNormal M)
    {W : Submodule 𝔽 V} (hW : IsSubsystem M W) : IsSubsystem M Wᗮ := by sorry
