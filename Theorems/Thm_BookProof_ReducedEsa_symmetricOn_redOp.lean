-- Generated from ChapterReducingSubspaceEsa.lean — theorem BookProof.ReducedEsa.symmetricOn_redOp
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Mathlib
import Definitions.Def_ChapterReducingSubspaceEsa
import Definitions.Def_ChapterA
import Definitions.Def_ChapterFarisLavineCore
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


theorem BookProof.ReducedEsa.symmetricOn_redOp (hP : IsReducingProjection P) {hPD : ∀ x ∈ D, P x ∈ D}
    (hC : Commutes T hPD) (hT : SymmetricOn D T) :
    SymmetricOn (redDom P D) (redOp T hP hC) := by sorry
