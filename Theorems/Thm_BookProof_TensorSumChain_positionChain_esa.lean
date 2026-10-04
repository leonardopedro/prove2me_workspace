-- Generated from ChapterTensorSumChain.lean — theorem BookProof.TensorSumChain.positionChain_esa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterTensorGraphCore
import Mathlib
import Definitions.Def_ChapterTensorSumChain
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterA4
open BookProof.TensorSumChain



open scoped TensorProduct
open BookProof.FarisLavine BookProof.TensorCore BookProof.TensorSumEsa

noncomputable section

theorem BookProof.TensorSumChain.positionChain_esa (n : ℕ) :
    EssentiallySelfAdjointOn (chain posEsaOp (List.replicate n posEsaOp)).dom
      (chain posEsaOp (List.replicate n posEsaOp)).op := by sorry
