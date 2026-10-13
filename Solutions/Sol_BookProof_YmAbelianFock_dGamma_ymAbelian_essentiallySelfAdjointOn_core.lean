-- Generated from ChapterYangMillsAbelianFockEsa.lean — solution of BookProof.YmAbelianFock.dGamma_ymAbelian_essentiallySelfAdjointOn_core
import Mathlib
import Definitions.Def_ChapterYangMillsAbelianFockEsa
import Theorems.Thm_BookProof_YmAbelianFock_ymAbelianHermCol_eq
import Theorems.Thm_BookProof_FullQuadratic_polySym_fqPoly
import Theorems.Thm_BookProof_HermiteBand_isBand2_fqPoly
import Theorems.Thm_BookProof_QuadFockEsa_dGamma_hermCol_essentiallySelfAdjointOn_core
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterGradedBandSchurEsa
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterSirkSingleTimeShift
import Definitions.Def_ChapterFiniteSectionSingleTime
import Definitions.Def_ChapterQymTimeIndependentFlow
import Definitions.Def_ChapterQgTimeIndependentFlow
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFullQuadraticEsa
import Definitions.Def_ChapterHermiteBandCalculus
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterQuadraticFockEsa
import Definitions.Def_ChapterYangMillsAbelianEsa
import Definitions.Def_ChapterYangMillsHermite
open BookProof.YmAbelianFock




open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteBand BookProof.GradedBandSchur BookProof.QuadFockEsa
open BookProof.FockSecondQuantization BookProof.NavierStokesFlow
open BookProof.HermiteGalerkin BookProof.FarisLavine
open BookProof.YangMillsHermite BookProof.FullQuadratic BookProof.YangMillsAbelianEsa
open BookProof.YangMillsFriedrichs
open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.EsaClosure BookProof.StoneBridge
open BookProof.HashimotoShiftInvert BookProof.SirkSingleTime
open BookProof.FiniteSectionSingleTime BookProof.QymTimeIndependent BookProof.QgTimeIndependent
open BookProof.FockSecondQuantization
open BookProof.FullQuadratic
open BookProof.HermiteBand
open BookProof.QuadFockEsa
open BookProof.YangMillsAbelianEsa
open BookProof.YangMillsHermite

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (e : ℕ ≃ (Fin 99 →₀ ℕ)) :
    EssentiallySelfAdjointOn (lpFiniteModes Conf) (dGammaOp (ymAbelianHermCol e)) := by

  rw [ymAbelianHermCol_eq]
  refine dGamma_hermCol_essentiallySelfAdjointOn_core e ?_ ?_
  · rw [ymAbelianPoly_eq_fqPoly]
    exact polySym_fqPoly _ _ _ _ _
  · rw [ymAbelianPoly_eq_fqPoly]
    exact isBand2_fqPoly _ _ _ _ _
