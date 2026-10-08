-- Generated from ChapterTensorKatoRellich.lean — theorem BookProof.TensorKatoRellich.cpairOp_eq_pairLiftOp
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

theorem BookProof.TensorKatoRellich.cpairOp_eq_pairLiftOp (A : DA →ₗ[ℂ] Hs.carrier) (B : DB →ₗ[ℂ] Ks.carrier) :
    cpairOp Hs Ks DA DB A B = pairLiftOp Hs Ks DA DB (sumPoly Hs Ks DA DB A B) := by sorry
