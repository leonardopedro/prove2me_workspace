-- Generated from ChapterYangMillsAbelianEsa.lean — solution of BookProof.YangMillsAbelianEsa.ymAbelian_essentiallySelfAdjointOn_core
import Mathlib
import Definitions.Def_ChapterYangMillsAbelianEsa
import Theorems.Thm_BookProof_YangMillsAbelianEsa_ymAbelian_eq_fqOp
import Theorems.Thm_BookProof_FullQuadratic_fqOp_essentiallySelfAdjoint
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

set_option maxHeartbeats 1000000 in
theorem solution :
    EssentiallySelfAdjointOn (polyGaussCore (d := 99)) (ymHamiltonian (coreRepPoly 99) 0) := by

  rw [ymAbelian_eq_fqOp]
  exact fqOp_essentiallySelfAdjoint ymFqP ymFqQ 0 0 0
