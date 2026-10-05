-- Generated from ChapterTensorSumChain.lean — theorem BookProof.TensorSumChain.chain_symmetric
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterTensorSumEsa
import Mathlib
import Definitions.Def_ChapterTensorSumChain
import Definitions.Def_ChapterFarisLavineCore
open BookProof.TensorSumChain



open scoped TensorProduct
open BookProof.FarisLavine BookProof.TensorCore BookProof.TensorSumEsa

noncomputable section

theorem BookProof.TensorSumChain.chain_symmetric (E : EsaOp) (L : List EsaOp) :
    SymmetricOn (chain E L).dom (chain E L).op := by sorry
