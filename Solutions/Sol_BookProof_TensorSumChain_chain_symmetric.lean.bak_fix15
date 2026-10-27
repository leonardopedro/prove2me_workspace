-- Generated from ChapterTensorSumChain.lean — solution of BookProof.TensorSumChain.chain_symmetric
import Mathlib
import Definitions.Def_ChapterTensorSumChain
open BookProof.TensorSumChain




open scoped TensorProduct
open BookProof.FarisLavine BookProof.TensorCore BookProof.TensorSumEsa

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (E : EsaOp) (L : List EsaOp) :
    SymmetricOn (chain E L).dom (chain E L).op := (chain E L).sym
