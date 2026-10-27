-- Generated from ChapterTensorSumChain.lean — solution of BookProof.TensorSumChain.chain_dense
import Mathlib
import Definitions.Def_ChapterTensorSumChain
open BookProof.TensorSumChain




open scoped TensorProduct
open BookProof.FarisLavine BookProof.TensorCore BookProof.TensorSumEsa

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (E : EsaOp) (L : List EsaOp) :
    Dense (((chain E L).dom : Submodule ℂ (chain E L).space.carrier) :
      Set (chain E L).space.carrier) := (chain E L).dense
