-- Generated from ChapterTensorKatoRellich.lean — theorem BookProof.TensorKatoRellich.pairLiftDom_apply
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterTensorSumEsa
import Mathlib
import Definitions.Def_ChapterTensorKatoRellich
import Definitions.Def_ChapterTensorGraphCore
open BookProof.TensorCore
open BookProof.TensorKatoRellich



open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore BookProof.TensorSumEsa

noncomputable section

variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)

theorem BookProof.TensorKatoRellich.pairLiftDom_apply (L : (DA ⊗[ℂ] DB) →ₗ[ℂ] (Hs.carrier ⊗[ℂ] Ks.carrier))
    (x : pairDom Hs Ks DA DB) (x₀ : DA ⊗[ℂ] DB)
    (hx : (x : Hs.carrier ⊗[ℂ] Ks.carrier) = inclPair Hs Ks DA DB x₀) :
    pairLiftDom Hs Ks DA DB L x = L x₀ := by sorry
