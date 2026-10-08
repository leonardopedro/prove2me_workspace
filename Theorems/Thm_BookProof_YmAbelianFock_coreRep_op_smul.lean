-- Generated from ChapterYangMillsAbelianFockEsa.lean — theorem BookProof.YmAbelianFock.coreRep_op_smul
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteBandCalculus
import Definitions.Def_ChapterGradedBandSchurEsa
import Definitions.Def_ChapterQuadraticFockEsa
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFullQuadraticEsa
import Definitions.Def_ChapterYangMillsAbelianEsa
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterSirkSingleTimeShift
import Definitions.Def_ChapterFiniteSectionSingleTime
import Definitions.Def_ChapterQymTimeIndependentFlow
import Definitions.Def_ChapterQgTimeIndependentFlow
import Mathlib
import Definitions.Def_ChapterYangMillsAbelianFockEsa
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsHermite
open BookProof.HermiteProductCore
open BookProof.YangMillsHermite
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

noncomputable section

variable {d : ℕ}


theorem BookProof.YmAbelianFock.coreRep_op_smul {D : Submodule ℂ (L2d d)} (Φ : CoreRep d D) (c : ℂ)
    (T : Module.End ℂ (MvPolynomial (Fin d) ℂ)) :
    Φ.op (c • T) = c • Φ.op T := by sorry
