-- Generated from ChapterTensorKatoRellich.lean — theorem BookProof.TensorKatoRellich.exists_pre
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Mathlib
import Definitions.Def_ChapterTensorKatoRellich
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterA4
open BookProof.TensorCore

variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)



open scoped TensorProduct

noncomputable section

theorem BookProof.TensorKatoRellich.exists_pre (x : cpairDom Hs Ks DA DB) :
    ∃ x₀ : DA ⊗[ℂ] DB, (x : ctensor Hs Ks) = pairEmb Hs Ks (inclPair Hs Ks DA DB x₀) := by sorry
