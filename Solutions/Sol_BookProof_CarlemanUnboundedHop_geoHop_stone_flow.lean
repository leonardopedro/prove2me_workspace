-- Generated from ChapterCarlemanUnboundedHop.lean — solution of BookProof.CarlemanUnboundedHop.geoHop_stone_flow
import Mathlib
import Definitions.Def_ChapterCarlemanUnboundedHop
import Theorems.Thm_BookProof_CarlemanUnboundedHop_kernelOp_symmetric
import Theorems.Thm_BookProof_CarlemanUnboundedHop_geoHop_isL2Kernel
import Theorems.Thm_BookProof_CarlemanUnboundedHop_geoHop_essentiallySelfAdjoint
import Theorems.Thm_BookProof_StoneBridge_exists_stone_flow_of_esa
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterKernelBound
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterStoneResolvent
open BookProof.CarlemanUnboundedHop




open Finset
open BookProof.EsaClosure
open BookProof.KernelBound
open BookProof.NavierStokesFlow.DiagonalEsa
open BookProof.NavierStokesFlow.JacobiDeficiency
open BookProof.NavierStokesFlow.LpNat
open BookProof.StoneBridge

noncomputable section

variable {a : ℕ → ℕ → ℂ} {u : ℕ → ℂ} {A θ Θ : ℕ → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (b : ℕ → ℝ) {rho : ℝ} (hrho : 0 ≤ rho) (hrho1 : rho < 1) :
    ∃ (T : ChapterStoneResolvent.UnboundedSelfAdjoint L2N) (U : ℝ → (L2N →L[ℂ] L2N)),
      EsaClosure.IsSelfAdjointExtension (kernelOp (geoHop_isL2Kernel b hrho hrho1)) T.op ∧
        StoneBridge.IsStoneFlow T U :=
  StoneBridge.exists_stone_flow_of_esa _ lpFiniteModes_dense
      (kernelOp_symmetric (geoHop_isL2Kernel b hrho hrho1))
      (geoHop_essentiallySelfAdjoint b hrho hrho1)
