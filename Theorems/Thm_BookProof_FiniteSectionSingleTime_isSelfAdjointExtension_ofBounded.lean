-- Generated from ChapterFiniteSectionSingleTime.lean — theorem BookProof.FiniteSectionSingleTime.isSelfAdjointExtension_ofBounded
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterQgTruncationResolvent
import Definitions.Def_ChapterSirkSingleTimeShift
import Definitions.Def_ChapterQgTimeIndependentFlow
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Mathlib
import Definitions.Def_ChapterFiniteSectionSingleTime
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterSirkTrotterKatoGalerkin
open BookProof.EsaClosure
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


theorem BookProof.FiniteSectionSingleTime.isSelfAdjointExtension_ofBounded {F : Type*} [NormedAddCommGroup F]
    [InnerProductSpace ℂ F] [CompleteSpace F] (A : F →L[ℂ] F) (hA : IsSelfAdjoint A)
    (D : Submodule ℂ F) :
    IsSelfAdjointExtension ((A : F →ₗ[ℂ] F).comp D.subtype) (ofBounded A hA).op := by sorry
