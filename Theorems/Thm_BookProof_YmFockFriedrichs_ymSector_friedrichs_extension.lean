-- Generated from ChapterYangMillsFockFriedrichs.lean — theorem BookProof.YmFockFriedrichs.ymSector_friedrichs_extension
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterQg3DGaugeFarisLavine
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterYangMillsFockFriedrichs
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsFriedrichs
open BookProof.HermiteProductCore
open BookProof.YangMillsFriedrichs
open BookProof.YmFockFriedrichs



open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.Qg3DGaugeFL
open BookProof.ChapterStoneResolvent

noncomputable section

theorem BookProof.YmFockFriedrichs.ymSector_friedrichs_extension (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) (n : ℕ) :
    ∃ (Dom : Submodule ℂ (L2d (n * 99))) (A : Dom →ₗ[ℂ] L2d (n * 99)),
      IsPositiveSelfAdjointExtension (ymSectorHam fabc n) A := by sorry
