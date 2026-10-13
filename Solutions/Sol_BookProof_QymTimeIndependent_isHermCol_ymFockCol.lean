-- Generated from ChapterQymTimeIndependentFlow.lean — solution of BookProof.QymTimeIndependent.isHermCol_ymFockCol
import Mathlib
import Definitions.Def_ChapterQymTimeIndependentFlow
import Theorems.Thm_BookProof_FockSecondQuantization_isHermCol_opCol
import Theorems.Thm_BookProof_YangMillsHermite_ymHamiltonian_symmetricOn
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterSirkSingleTimeShift
import Definitions.Def_ChapterQgTimeIndependentFlow
import Definitions.Def_ChapterFiniteSectionSingleTime
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterQgCouplingDGammaSum
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsHermite
open BookProof.QymTimeIndependent




open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.HashimotoShiftInvert BookProof.SirkSingleTime BookProof.QgTimeIndependent
open BookProof.FiniteSectionSingleTime BookProof.YangMillsFriedrichs
open BookProof.FockSecondQuantization BookProof.QgCouplingDGammaSum
open BookProof.YangMillsHermite BookProof.HermiteGalerkin
open BookProof.FockSecondQuantization
open BookProof.HermiteGalerkin
open BookProof.HermiteProductCore
open BookProof.YangMillsHermite

variable (e : ℕ ≃ (Fin 99 →₀ ℕ)) (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ)

set_option maxHeartbeats 1000000 in

theorem solution :
    SymmetricOn (lpFiniteModes Conf) (dGammaOp (ymFockCol e fabc)) :=
  dGammaOp_symmetricOn (isHermCol_ymFockCol e fabc)

/-! ## 1. The Weyl gauge: an autonomous generator -/
