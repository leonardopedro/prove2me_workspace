-- Generated from ChapterTensorKatoRellich.lean — theorem BookProof.TensorKatoRellich.mapPoly_symm
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Mathlib
import Definitions.Def_ChapterTensorKatoRellich
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterA4
open BookProof.TensorCore
open BookProof.TensorKatoRellich

variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)



open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore BookProof.TensorSumEsa

noncomputable section

theorem BookProof.TensorKatoRellich.mapPoly_symm (V : DA →ₗ[ℂ] Hs.carrier) (Y : DB →ₗ[ℂ] Ks.carrier)
    (hV : SymmetricOn DA V) (hY : SymmetricOn DB Y) :
    ∀ x y : DA ⊗[ℂ] DB,
      (inner ℂ (TensorProduct.map V Y x) (inclPair Hs Ks DA DB y) : ℂ)
        = inner ℂ (inclPair Hs Ks DA DB x) (TensorProduct.map V Y y) := by sorry
