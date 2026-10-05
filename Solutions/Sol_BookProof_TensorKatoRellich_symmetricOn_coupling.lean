-- Generated from ChapterTensorKatoRellich.lean — solution of BookProof.TensorKatoRellich.symmetricOn_coupling
import Mathlib
import Definitions.Def_ChapterTensorKatoRellich
import Theorems.Thm_BookProof_TensorKatoRellich_symmetricOn_pairLiftOp
import Theorems.Thm_BookProof_TensorKatoRellich_mapPoly_symm
open BookProof.TensorKatoRellich




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore BookProof.TensorSumEsa

noncomputable section

variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)
variable {ι : Type*} [Fintype ι]

set_option maxHeartbeats 1000000 in
theorem solution (V : ι → DA →ₗ[ℂ] Hs.carrier) (Y : ι → DB →ₗ[ℂ] Ks.carrier)
    (hV : ∀ i, SymmetricOn DA (V i)) (hY : ∀ i, SymmetricOn DB (Y i)) :
    SymmetricOn (cpairDom Hs Ks DA DB) (pairLiftOp Hs Ks DA DB (couplingPoly Hs Ks DA DB V Y)) := by

  refine symmetricOn_pairLiftOp Hs Ks DA DB _ fun x y => ?_
  simp only [couplingPoly, LinearMap.sum_apply, sum_inner, inner_sum]
  exact Finset.sum_congr rfl fun i _ => mapPoly_symm Hs Ks DA DB (V i) (Y i) (hV i) (hY i) x y
