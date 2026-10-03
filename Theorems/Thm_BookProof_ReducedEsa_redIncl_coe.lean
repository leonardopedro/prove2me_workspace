-- Generated from ChapterReducingSubspaceEsa.lean — theorem BookProof.ReducedEsa.redIncl_coe
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Mathlib
import Definitions.Def_ChapterReducingSubspaceEsa
import Definitions.Def_ChapterA4

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {P : F →ₗ[ℂ] F}
variable (P) in
variable (P) (D : Submodule ℂ F) in
variable {D : Submodule ℂ F}
variable (P D) in



open BookProof.FarisLavine BookProof.GraphCore

noncomputable section


theorem BookProof.ReducedEsa.redIncl_coe (x : redDom P D) : ((redIncl P D x : D) : F) = (x : F) := by sorry
