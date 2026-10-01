-- Generated from ChapterEsaClosureCore.lean — theorem BookProof.EsaClosure.clRange_orthogonal_eq_bot
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


, clExt_apply, hval]
  abel

theorem BookProof.EsaClosure.clRange_orthogonal_eq_bot (T : D →ₗ[ℂ] F) (hdense : Dense (D : Set F))
    (hsym : SymmetricOn D T) (hesa : EssentiallySelfAdjointOn D T) :
    (cshiftRange (clExt T hden := by sorry
