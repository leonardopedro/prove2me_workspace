-- Generated from ChapterYangMillsAbelianFockEsa.lean — theorem BookProof.YmAbelianFock.dGamma_ymAbelian_essentiallySelfAdjointOn_core
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

theorem BookProof.YmAbelianFock.dGamma_ymAbelian_essentiallySelfAdjointOn_core (e : ℕ ≃ (Fin 99 →₀ ℕ)) :
    EssentiallySelfAdjointOn (lpFiniteModes Conf) (dGammaOp (ymAbelianHermCol e)) := by sorry
