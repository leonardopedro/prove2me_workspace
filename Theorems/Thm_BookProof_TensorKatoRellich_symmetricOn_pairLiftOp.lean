-- Generated from ChapterTensorKatoRellich.lean — theorem BookProof.TensorKatoRellich.symmetricOn_pairLiftOp
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Mathlib
import Definitions.Def_ChapterTensorKatoRellich
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterA4
open BookProof.TensorCore

variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)



open scoped TensorProduct

noncomputable section

theorem BookProof.TensorKatoRellich.symmetricOn_pairLiftOp (L : (DA ⊗[ℂ] DB) →ₗ[ℂ] (Hs.carrier ⊗[ℂ] Ks.carrier))
    (hL : ∀ x y : DA ⊗[ℂ] DB,
      (inner ℂ (L x) (inclPair Hs Ks DA DB y) : ℂ) = inner ℂ (inclPair Hs Ks DA DB x) (L y)) :
    SymmetricOn (cpairDom Hs Ks DA DB) (pairLiftOp Hs Ks DA DB L) := by sorry
