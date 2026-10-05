-- Generated from ChapterQuantumGravityFock.lean — solution of BookProof.QuantumGravityFock.qgTwoLevel_esa
import Mathlib
import Definitions.Def_ChapterQuantumGravityFock
import Theorems.Thm_BookProof_NavierStokesFlow_FockOfFock_hTwoLevel_hasZeroDeficiencyOn
open BookProof.QuantumGravityFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.FockOfFock BookProof.NavierStokesFlow.FullEsa
open BookProof.FarisLavine BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (ext eps : ℕ → ℝ) :
    HasZeroDeficiencyOn (BookProof.NavierStokesFlow.FockOfFock.FockOfFockDom ℕ ℕ)
      (BookProof.NavierStokesFlow.FockOfFock.hTwoLevel ext eps) := BookProof.NavierStokesFlow.FockOfFock.hTwoLevel_hasZeroDeficiencyOn ext eps
