-- Generated from ChapterTensorSumChain.lean — solution of BookProof.TensorSumChain.chain_stone_flow
import Mathlib
import Definitions.Def_ChapterTensorSumChain
import Theorems.Thm_BookProof_StoneBridge_exists_stone_flow_of_esa
open BookProof.TensorSumChain




open scoped TensorProduct
open BookProof.FarisLavine BookProof.TensorCore BookProof.TensorSumEsa

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (E : EsaOp) (L : List EsaOp) :
    ∃ (G : UnboundedSelfAdjoint (chain E L).space.carrier)
      (U : ℝ → ((chain E L).space.carrier →L[ℂ] (chain E L).space.carrier)),
      IsSelfAdjointExtension (chain E L).op G.op ∧ IsStoneFlow G U :=
  haveI := (chain E L).complete
    exists_stone_flow_of_esa _ (chain E L).dense (chain E L).sym (chain E L).esa
