-- Generated from ChapterTensorSumChain.lean — solution of BookProof.TensorSumChain.positionChain_esa
import Mathlib
import Definitions.Def_ChapterTensorSumChain
import Theorems.Thm_BookProof_TensorSumChain_chain_esa
open BookProof.TensorSumChain




open scoped TensorProduct
open BookProof.FarisLavine BookProof.TensorCore BookProof.TensorSumEsa

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) :
    EssentiallySelfAdjointOn (chain posEsaOp (List.replicate n posEsaOp)).dom
      (chain posEsaOp (List.replicate n posEsaOp)).op := chain_esa posEsaOp (List.replicate n posEsaOp)
