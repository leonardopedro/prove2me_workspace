-- Generated from ChapterEsaClosureCore.lean — theorem BookProof.EsaClosure.clRange_isClosed
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterFarisLavineCore
open BookProof.HashimotoShiftInvert
open BookProof.EsaClosure

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable [CompleteSpace F]


open Filter Topology


open BookProof.FarisLavine BookProof.HashimotoShiftInvert




theorem BookProof.EsaClosure.clRange_isClosed (T : D →ₗ[ℂ] F) (hdense : Dense (D : Set F)) (hsym : SymmetricOn D T)
    {γ : ℂ} (hγ : γ.im ≠ 0) :
    IsClosed ((cshiftRange (clExt T hdense hsym) γ := by sorry
