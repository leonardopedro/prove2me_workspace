-- Generated from ChapterTensorSumChain.lean — theorem BookProof.TensorSumChain.posEsaOp_not_bounded
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterTensorGraphCore
import Mathlib
import Definitions.Def_ChapterTensorSumChain
import Definitions.Def_ChapterA4
open BookProof.TensorSumChain



open scoped TensorProduct
open BookProof.FarisLavine BookProof.TensorCore BookProof.TensorSumEsa

noncomputable section

theorem BookProof.TensorSumChain.posEsaOp_not_bounded :
    ¬ ∃ C : ℝ, ∀ x : posEsaOp.dom,
      ‖posEsaOp.op x‖ ≤ C * ‖(x : posEsaOp.space.carrier)‖ := by sorry
