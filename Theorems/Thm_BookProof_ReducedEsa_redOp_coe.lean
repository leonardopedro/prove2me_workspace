-- Generated from ChapterReducingSubspaceEsa.lean — theorem BookProof.ReducedEsa.redOp_coe
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Mathlib
import Definitions.Def_ChapterReducingSubspaceEsa
import Definitions.Def_ChapterA
import Definitions.Def_ChapterA4
open BookProof.ChapterA
open BookProof.ChapterA.System

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {P : F →ₗ[ℂ] F}
variable (P) in
variable (P) (D : Submodule ℂ F) in
variable {D : Submodule ℂ F}
variable (P D) in
variable (T : D →ₗ[ℂ] F)
variable {T}
variable (T) in



open BookProof.FarisLavine BookProof.GraphCore

noncomputable section


theorem BookProof.ReducedEsa.redOp_coe (hP : IsReducingProjection P) {hPD : ∀ x ∈ D, P x ∈ D}
    (hC : Commutes T hPD) (x : redDom P D) :
    ((redOp T hP hC x : sector P) : F) = T (redIncl P D x) := by sorry
