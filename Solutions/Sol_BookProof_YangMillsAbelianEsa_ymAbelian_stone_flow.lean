-- Generated from ChapterYangMillsAbelianEsa.lean — solution of BookProof.YangMillsAbelianEsa.ymAbelian_stone_flow
import Mathlib
import Definitions.Def_ChapterYangMillsAbelianEsa
import Theorems.Thm_BookProof_YangMillsAbelianEsa_ymAbelian_essentiallySelfAdjointOn_core
import Theorems.Thm_BookProof_StoneBridge_exists_stone_flow_of_esa
import Theorems.Thm_BookProof_YangMillsHermite_ymHamiltonian_symmetricOn
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
    ∃ (T : UnboundedSelfAdjoint (L2d 99)) (U : ℝ → (L2d 99 →L[ℂ] L2d 99)),
      IsSelfAdjointExtension (ymHamiltonian (coreRepPoly 99) 0) T.op ∧ IsStoneFlow T U :=
  exists_stone_flow_of_esa _ polyGaussCore_dense
      (ymHamiltonian_symmetricOn (coreRepPoly 99) 0)
      ymAbelian_essentiallySelfAdjointOn_core
