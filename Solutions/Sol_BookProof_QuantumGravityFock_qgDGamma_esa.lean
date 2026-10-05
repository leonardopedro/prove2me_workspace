-- Generated from ChapterQuantumGravityFock.lean — solution of BookProof.QuantumGravityFock.qgDGamma_esa
import Mathlib
import Definitions.Def_ChapterQuantumGravityFock
import Theorems.Thm_BookProof_NavierStokesFlow_FockOfFock_dGamma_hasZeroDeficiencyOn
open BookProof.QuantumGravityFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.FockOfFock BookProof.NavierStokesFlow.FullEsa
open BookProof.FarisLavine BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (omega : ℕ → ℝ) :
    HasZeroDeficiencyOn (BookProof.NavierStokesFlow.FockOfFock.FockDom ℕ)
      (BookProof.NavierStokesFlow.FockOfFock.dGamma omega) := BookProof.NavierStokesFlow.FockOfFock.dGamma_hasZeroDeficiencyOn omega
