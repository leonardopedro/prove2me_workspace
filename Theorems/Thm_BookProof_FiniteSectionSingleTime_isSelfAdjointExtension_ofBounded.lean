-- Generated from ChapterFiniteSectionSingleTime.lean — theorem BookProof.FiniteSectionSingleTime.isSelfAdjointExtension_ofBounded
import Mathlib
import Definitions.Def_ChapterFiniteSectionSingleTime
open BookProof.FiniteSectionSingleTime

variable {ι : Type*} [DecidableEq ι]
variable (H : lpFiniteModes ι →ₗ[ℂ] L2I ι)


open scoped InnerProductSpace


open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.QgTruncationResolvent BookProof.SirkSingleTime BookProof.QgTimeIndependent
open BookProof.HashimotoShiftInvert
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato

noncomputable section

variable {ι : Type*} [DecidableEq ι]

theorem BookProof.FiniteSectionSingleTime.isSelfAdjointExtension_ofBounded {F : Type*} [NormedAddCommGroup F]
    [InnerProductSpace ℂ F] [CompleteSpace F] (A : F →L[ℂ] F) (hA : IsSelfAdjoint A)
    (D : Submodule ℂ F) :
    IsSelfAdjointExtension ((A : F →ₗ[ℂ] F).comp D.subtype) (ofBounded A hA).op := by sorry
