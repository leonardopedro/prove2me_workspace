-- Generated from ChapterTensorSumChain.lean — theorem BookProof.TensorSumChain.chain_dense
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterTensorSumEsa
import Mathlib
import Definitions.Def_ChapterTensorSumChain
open BookProof.TensorSumChain



open scoped TensorProduct
open BookProof.FarisLavine BookProof.TensorCore BookProof.TensorSumEsa

noncomputable section

theorem BookProof.TensorSumChain.chain_dense (E : EsaOp) (L : List EsaOp) :
    Dense (((chain E L).dom : Submodule ℂ (chain E L).space.carrier) :
      Set (chain E L).space.carrier) := by sorry
