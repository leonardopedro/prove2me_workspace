-- Generated from ChapterTensorKatoRellich.lean — theorem BookProof.TensorKatoRellich.cpairOp_eq_pairLiftOp
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

theorem BookProof.TensorKatoRellich.cpairOp_eq_pairLiftOp (A : DA →ₗ[ℂ] Hs.carrier) (B : DB →ₗ[ℂ] Ks.carrier) :
    cpairOp Hs Ks DA DB A B = pairLiftOp Hs Ks DA DB (sumPoly Hs Ks DA DB A B) := by sorry
