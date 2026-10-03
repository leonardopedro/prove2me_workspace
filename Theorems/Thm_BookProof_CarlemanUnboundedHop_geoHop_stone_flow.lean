-- Generated from ChapterCarlemanUnboundedHop.lean — theorem BookProof.CarlemanUnboundedHop.geoHop_stone_flow
import Mathlib
import Definitions.Def_ChapterCarlemanUnboundedHop
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterKernelBound
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterA4
open BookProof.EsaClosure
open BookProof.KernelBound
open BookProof.NavierStokesFlow.DiagonalEsa
open BookProof.NavierStokesFlow.JacobiDeficiency
open BookProof.NavierStokesFlow.LpNat
open BookProof.StoneBridge

variable {a : ℕ → ℕ → ℂ} {u : ℕ → ℂ} {A θ Θ : ℕ → ℝ}



open Finset

noncomputable section

theorem BookProof.CarlemanUnboundedHop.geoHop_stone_flow (b : ℕ → ℝ) {rho : ℝ} (hrho : 0 ≤ rho) (hrho1 : rho < 1) :
    ∃ (T : ChapterStoneResolvent.UnboundedSelfAdjoint L2N) (U : ℝ → (L2N →L[ℂ] L2N)),
      EsaClosure.IsSelfAdjointExtension (kernelOp (geoHop_isL2Kernel b hrho hrho1)) T.op ∧
        StoneBridge.IsStoneFlow T U := by sorry
