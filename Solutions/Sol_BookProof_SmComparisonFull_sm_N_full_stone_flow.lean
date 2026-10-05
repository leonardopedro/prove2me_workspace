-- Generated from ChapterSmComparisonFull.lean — solution of BookProof.SmComparisonFull.sm_N_full_stone_flow
import Mathlib
import Definitions.Def_ChapterSmComparisonFull
import Theorems.Thm_BookProof_TensorSumChain_chain_stone_flow
open BookProof.SmComparisonFull




open BookProof.FarisLavine BookProof.TensorSumChain
open BookProof.SmComparison BookProof.ScalaronEsa
open BookProof.StoneBridge BookProof.ChapterStoneResolvent BookProof.EsaClosure
open MeasureTheory

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution :
    ∃ (G : UnboundedSelfAdjoint smFullChain.space.carrier)
      (U : ℝ → (smFullChain.space.carrier →L[ℂ] smFullChain.space.carrier)),
      IsSelfAdjointExtension smFullChain.op G.op ∧ IsStoneFlow G U := chain_stone_flow quarticEsaOp _
