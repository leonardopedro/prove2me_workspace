-- Generated from ChapterQuantumGravityFock.lean — solution of BookProof.QuantumGravityFock.fermToLp_add
import Mathlib
import Definitions.Def_ChapterQuantumGravityFock
open BookProof.QuantumGravityFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.FockOfFock BookProof.NavierStokesFlow.FullEsa
open BookProof.FarisLavine BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (x y : FermAlg) : fermToLp (x + y) = fermToLp x + fermToLp y := by

  refine lp.ext (funext fun α => ?_)
  simp [fermToLp, Pi.add_apply]
  try rfl
