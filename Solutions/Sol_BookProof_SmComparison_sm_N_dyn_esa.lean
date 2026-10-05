-- Generated from ChapterSmComparison.lean — solution of BookProof.SmComparison.sm_N_dyn_esa
import Mathlib
import Definitions.Def_ChapterSmComparison
import Theorems.Thm_BookProof_TensorSumChain_chain_esa
open BookProof.SmComparison




open MvPolynomial
open BookProof.SmOneParticle BookProof.SmHamiltonian
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.HermiteProductCore BookProof.FarisLavine
open BookProof.ScalaronWallEsa BookProof.ScalaronEsa BookProof.WallEsaBddBelow
open BookProof.TensorSumChain BookProof.TensorCore BookProof.TensorSumEsa
open BookProof.EsaClosure BookProof.GraphCore
open BookProof.StoneBridge BookProof.ChapterStoneResolvent
open MeasureTheory

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution :
    EssentiallySelfAdjointOn smDynChain.dom smDynChain.op := chain_esa quarticEsaOp _
