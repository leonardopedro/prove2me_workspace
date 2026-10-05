-- Generated from ChapterFiniteSectionSingleTime.lean — theorem BookProof.FiniteSectionSingleTime.secOp_tendsto_basis
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterQgTruncationResolvent
import Definitions.Def_ChapterSirkSingleTimeShift
import Definitions.Def_ChapterQgTimeIndependentFlow
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Mathlib
import Definitions.Def_ChapterFiniteSectionSingleTime
import Definitions.Def_ChapterE4
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
open BookProof.ChapterE4
open BookProof.NavierStokesFlow.IkebeKato
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


theorem BookProof.FiniteSectionSingleTime.secOp_tendsto_basis {W : ℕ → Finset ι} (hW : Exhausts W) (k : ι) :
    Tendsto (fun n => secOp H (W n) (basisVec k)) atTop (𝓝 (H (coreVec k))) := by sorry
