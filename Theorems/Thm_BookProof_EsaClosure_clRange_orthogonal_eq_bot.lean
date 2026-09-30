-- Generated from ChapterEsaClosureCore.lean — theorem BookProof.EsaClosure.clRange_orthogonal_eq_bot
import Mathlib
import Definitions.Def_ChapterEsaClosureCore
open BookProof.EsaClosure










open Filter Topology


open BookProof.FarisLavine BookProof.HashimotoShiftInvert

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}



























variable [CompleteSpace F]

theorem BookProof.EsaClosure.clRange_orthogonal_eq_bot (T : D →ₗ[ℂ] F) (hdense : Dense (D : Set F))
    (hsym : SymmetricOn D T) (hesa : EssentiallySelfAdjointOn D T) :
    (cshiftRange (clExt T hdense hsym) Complex.I)ᗮ = ⊥ := by sorry
