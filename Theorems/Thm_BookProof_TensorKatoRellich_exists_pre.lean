-- Generated from ChapterTensorKatoRellich.lean — theorem BookProof.TensorKatoRellich.exists_pre
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterTensorSumEsa
import Mathlib
import Definitions.Def_ChapterTensorKatoRellich
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterPermutationSectorEsa
open BookProof.TensorCore



open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)

theorem BookProof.TensorKatoRellich.exists_pre (x : cpairDom Hs Ks DA DB) :
    ∃ x₀ : DA ⊗[ℂ] DB, (x : ctensor Hs Ks) = pairEmb Hs Ks (inclPair Hs Ks DA DB x₀) := by sorry
