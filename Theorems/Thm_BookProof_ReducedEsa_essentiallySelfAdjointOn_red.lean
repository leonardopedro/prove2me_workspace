-- Generated from ChapterReducingSubspaceEsa.lean — theorem BookProof.ReducedEsa.essentiallySelfAdjointOn_red
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Mathlib
import Definitions.Def_ChapterReducingSubspaceEsa
import Definitions.Def_ChapterA
import Definitions.Def_ChapterFarisLavineCore
open BookProof.ChapterA
open BookProof.ChapterA.System
open BookProof.ReducedEsa



open BookProof.FarisLavine BookProof.GraphCore

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {P : F →ₗ[ℂ] F}
variable {D : Submodule ℂ F}
variable (T : D →ₗ[ℂ] F)
variable {T}

theorem BookProof.ReducedEsa.essentiallySelfAdjointOn_red (hP : IsReducingProjection P) {hPD : ∀ x ∈ D, P x ∈ D}
    (hC : Commutes T hPD) (hesa : EssentiallySelfAdjointOn D T) :
    EssentiallySelfAdjointOn (redDom P D) (redOp T hP hC) := by sorry
