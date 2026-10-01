-- Generated from ChapterYangMillsAbelianFockEsa.lean — theorem BookProof.YmAbelianFock.coreRep_op_smul
import Mathlib
import Definitions.Def_ChapterYangMillsAbelianFockEsa
open BookProof.YmAbelianFock

variable {d : ℕ}



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
