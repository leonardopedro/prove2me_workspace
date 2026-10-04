-- Generated from ChapterTensorKatoRellich.lean — theorem BookProof.TensorKatoRellich.symmetricOn_coupling
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
variable {ι : Type*} [Fintype ι]



open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore BookProof.TensorSumEsa

noncomputable section

theorem BookProof.TensorKatoRellich.symmetricOn_coupling (V : ι → DA →ₗ[ℂ] Hs.carrier) (Y : ι → DB →ₗ[ℂ] Ks.carrier)
    (hV : ∀ i, SymmetricOn DA (V i)) (hY : ∀ i, SymmetricOn DB (Y i)) :
    SymmetricOn (cpairDom Hs Ks DA DB) (pairLiftOp Hs Ks DA DB (couplingPoly Hs Ks DA DB V Y)) := by sorry
