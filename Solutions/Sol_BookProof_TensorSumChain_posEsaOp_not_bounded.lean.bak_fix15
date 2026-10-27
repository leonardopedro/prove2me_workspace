-- Generated from ChapterTensorSumChain.lean — solution of BookProof.TensorSumChain.posEsaOp_not_bounded
import Mathlib
import Definitions.Def_ChapterTensorSumChain
import Theorems.Thm_BookProof_ChapterStoneSeparable_mulSA_position_unbounded
open BookProof.TensorSumChain




open scoped TensorProduct
open BookProof.FarisLavine BookProof.TensorCore BookProof.TensorSumEsa

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution :
    ¬ ∃ C : ℝ, ∀ x : posEsaOp.dom,
      ‖posEsaOp.op x‖ ≤ C * ‖(x : posEsaOp.space.carrier)‖ := mulSA_position_unbounded
