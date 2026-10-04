-- Generated from ChapterTensorSumChain.lean — theorem BookProof.TensorSumChain.pair_op_tmul
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterTensorGraphCore
import Mathlib
import Definitions.Def_ChapterTensorSumChain
import Definitions.Def_ChapterA4
open BookProof.TensorSumChain



open scoped TensorProduct
open BookProof.FarisLavine BookProof.TensorCore BookProof.TensorSumEsa

noncomputable section

theorem BookProof.TensorSumChain.pair_op_tmul (E F : EsaOp) (x : E.dom) (y : F.dom)
    (v : (pair E F).dom)
    (hv : (v : (pair E F).space.carrier)
      = pairEmb E.space F.space (inclPair E.space F.space E.dom F.dom (x ⊗ₜ[ℂ] y))) :
    (pair E F).op v
      = pairEmb E.space F.space
        ((E.op x) ⊗ₜ[ℂ] (y : F.space.carrier) + (x : E.space.carrier) ⊗ₜ[ℂ] (F.op y)) := by sorry
