-- Generated from ChapterEsaClosureCore.lean — theorem BookProof.EsaClosure.clGraph_isClosed
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterComplexShiftCore
import Mathlib
import Definitions.Def_ChapterEsaClosureCore
open BookProof.EsaClosure


open Filter Topology


open BookProof.FarisLavine BookProof.HashimotoShiftInvert

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}


theorem BookProof.EsaClosure.clGraph_isClosed (T : D →ₗ[ℂ] F) :
    IsClosed ((clGraph T : Submodule ℂ (F × F)) : Set (F × F)) := by sorry
