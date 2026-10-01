-- Generated from ChapterYangMillsAbelianEsa.lean — theorem BookProof.YangMillsAbelianEsa.ymAbelian_essentiallySelfAdjointOn_core
import Mathlib
import Definitions.Def_ChapterYangMillsAbelianEsa
open BookProof.YangMillsAbelianEsa



open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.FullQuadratic
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.HashimotoShiftInvert BookProof.HermiteGalerkin BookProof.YangMillsFriedrichs

noncomputable section

theorem BookProof.YangMillsAbelianEsa.ymAbelian_essentiallySelfAdjointOn_core :
    EssentiallySelfAdjointOn (polyGaussCore (d := 99)) (ymHamiltonian (coreRepPoly 99) 0) := by sorry
