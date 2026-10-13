-- Generated from ChapterTensorKatoRellich.lean — solution of BookProof.TensorKatoRellich.cpairOp_eq_pairLiftOp
import Mathlib
import Definitions.Def_ChapterTensorKatoRellich
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterTensorSumEsa
import Definitions.Def_ChapterTensorGraphCore
open BookProof.TensorKatoRellich




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore BookProof.TensorSumEsa
open BookProof.TensorCore

noncomputable section

variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)

set_option maxHeartbeats 1000000 in
theorem solution (A : DA →ₗ[ℂ] Hs.carrier) (B : DB →ₗ[ℂ] Ks.carrier) :
    cpairOp Hs Ks DA DB A B = pairLiftOp Hs Ks DA DB (sumPoly Hs Ks DA DB A B) := rfl
