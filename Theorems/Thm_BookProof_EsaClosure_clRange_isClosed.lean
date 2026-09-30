-- Generated from ChapterEsaClosureCore.lean — theorem BookProof.EsaClosure.clRange_isClosed
import Mathlib
import Definitions.Def_ChapterEsaClosureCore
open BookProof.EsaClosure










open Filter Topology


open BookProof.FarisLavine BookProof.HashimotoShiftInvert

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}



























variable [CompleteSpace F]

theorem BookProof.EsaClosure.clRange_isClosed (T : D →ₗ[ℂ] F) (hdense : Dense (D : Set F)) (hsym : SymmetricOn D T)
    {γ : ℂ} (hγ : γ.im ≠ 0) :
    IsClosed ((cshiftRange (clExt T hdense hsym) γ : Submodule ℂ F) : Set F) := by sorry
