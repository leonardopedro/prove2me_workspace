import Definitions.Def_ChapterTensorSumEsa
import Definitions.Def_ChapterKatoRellichRelative
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterA4
import Mathlib


/-!
# Kato–Rellich for product couplings on a tensor sum with a finite-dimensional factor

`BookProof.ChapterTensorSumEsa` proves that a tensor **sum** `A ⊗ 1 + 1 ⊗ B` of two essentially
self-adjoint operators is essentially self-adjoint on `D_A ⊗ D_B`.  A tensor sum is not an
interaction.  This module adds a genuine coupling between the two factors,

`H = A ⊗ 1 + 1 ⊗ B + Σᵢ Vᵢ ⊗ Yᵢ`,

when the second factor is **finite-dimensional** and every `Vᵢ` is `A`-bounded with relative
bound `0` (`‖Vᵢ u‖ ≤ ε‖A u‖ + C_ε‖u‖` for every `ε > 0`).  The `Yᵢ` are arbitrary symmetric
operators on the finite-dimensional factor.

## What is proved

* `norm_sq_sum_tmul_orthonormal`, `norm_sum_tmul_le` — norm identities for sums of elementary
  tensors against an orthonormal family;
* `pairLiftOp`, `pairLiftOp_apply` — any linear map `D_A ⊗ D_B → H ⊗ K`, read as an operator
  in the completed tensor product on the domain `cpairDom` of the tensor sum
  (`cpairOp = pairLiftOp (sumPoly …)`, `cpairOp_eq_pairLiftOp`);
* `mapPoly_symm`, `symmetricOn_pairLiftOp`, `symmetricOn_coupling` — the product coupling
  `Σᵢ Vᵢ ⊗ Yᵢ` is symmetric when every `Vᵢ` and `Yᵢ` is;
* `coupling_relBound` — **the relative bound**: the coupling is bounded relative to the tensor
  sum with a relative bound `< 1`;
* **`essentiallySelfAdjointOn_tensorSum_add_coupling`** — hence, by Kato–Rellich
  (`KatoRellich.essentiallySelfAdjointOn_add_relBounded`), the coupled operator is essentially
  self-adjoint on `cpairDom` whenever the tensor sum is.

Nothing is assumed: the module contains no `axiom` and no `sorry`.
-/

namespace BookProof.TensorKatoRellich

open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore BookProof.TensorSumEsa

noncomputable section

/-! ## 1. Norms of sums of elementary tensors -/







/-! ## 2. Operators on the domain of the tensor sum -/

section Lift

variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)

/-- A linear map `D_A ⊗ D_B → H ⊗ K`, read as an operator on the subspace `pairDom` of `H ⊗ K`. -/
def pairLiftDom (L : (DA ⊗[ℂ] DB) →ₗ[ℂ] (Hs.carrier ⊗[ℂ] Ks.carrier)) :
    pairDom Hs Ks DA DB →ₗ[ℂ] (Hs.carrier ⊗[ℂ] Ks.carrier) :=
  L ∘ₗ
    (LinearEquiv.ofInjective (inclPair Hs Ks DA DB).toLinearMap
      (fun _ _ h => (inclPair Hs Ks DA DB).injective h)).symm.toLinearMap



/-- A linear map `D_A ⊗ D_B → H ⊗ K`, read as an operator in the completed tensor product on
the domain `cpairDom` of the tensor sum. -/
def pairLiftOp (L : (DA ⊗[ℂ] DB) →ₗ[ℂ] (Hs.carrier ⊗[ℂ] Ks.carrier)) :
    cpairDom Hs Ks DA DB →ₗ[ℂ] ctensor Hs Ks :=
  pushOp (pairEmb Hs Ks) (pairLiftDom Hs Ks DA DB L)











variable {ι : Type*} [Fintype ι]

/-- The product coupling `Σᵢ Vᵢ ⊗ Yᵢ` on the algebraic tensor product of the domains. -/
def couplingPoly (V : ι → DA →ₗ[ℂ] Hs.carrier) (Y : ι → DB →ₗ[ℂ] Ks.carrier) :
    (DA ⊗[ℂ] DB) →ₗ[ℂ] (Hs.carrier ⊗[ℂ] Ks.carrier) :=
  ∑ i, TensorProduct.map (V i) (Y i)



/-! ## 3. The relative bound -/





end Lift

end

end BookProof.TensorKatoRellich
