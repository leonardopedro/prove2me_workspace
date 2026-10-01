import Definitions.Def_ChapterFlowDGammaEsa
import Definitions.Def_ChapterEsaOneParticleDGamma
import Definitions.Def_ChapterStoneBridge
import Mathlib


/-!
# The tensor sum of two **different** operators: `A ⊗ 1 + 1 ⊗ B`

`BookProof/ChapterFlowDGammaEsa.lean` and `BookProof/ChapterEsaOneParticleDGamma.lean` settle
the second quantization `dΓ(A)` of a *single* one-particle operator, where every factor of the
tensor power carries the *same* operator.  This module removes that restriction in the
two-factor case: the two Hilbert spaces are different, and so are the two operators.

For a symmetric operator `A` on a dense domain `D_A` of `H` and a symmetric operator `B` on a
dense domain `D_B` of `K`, the **tensor sum**

`(A ⊗ 1 + 1 ⊗ B) (x ⊗ y) = (A x) ⊗ y + x ⊗ (B y)`

is studied on the algebraic tensor product `D_A ⊗ D_B`, inside the Hilbert space `H ⊗̂ K` — the
completion of the algebraic tensor product of the two spaces.  This is the separated-variables
form of a Hamiltonian: for `V(u, v) = V₁(u) + V₂(v)` the operator `−Δ + V` on a product is the
tensor sum of the two one-factor operators, so the theorem below is the exact tool that glues
two continuum factors together without any relative bound, semiboundedness or sign condition.

## What is proved

* `inclPair`, `sumPoly`, `pairDom`, `pairOp`, `ctensor`, `pairEmb`, `cpairDom`, `cpairOp` — the
  tensor sum as an operator on `D_A ⊗ D_B`, in `H ⊗ K` and then in the completion `H ⊗̂ K`.
* `sumPoly_symm`, `symmetricOn_pairOp`, `symmetricOn_cpairOp` — the tensor sum of two
  symmetric operators is symmetric.
* `dense_pairDom`, `dense_cpairDom` — the tensor product of two dense domains is dense: an
  elementary tensor is approximated by moving each factor into its domain, and the two errors
  add.
* `pflow`, `norm_pflow`, `hasDerivAt_pflow` — the **product flow** `U t ⊗ V t` of the two
  one-factor flows: it is isometric, preserves `D_A ⊗ D_B`, and satisfies the Leibniz rule,
  hence solves the Schrödinger equation of the tensor sum.
* `essentiallySelfAdjointOn_cpairDom_flow` — Nelson's invariant-domain criterion
  (`BookProof.FlowDGamma.essentiallySelfAdjointOn_of_orbits`) applied to those orbits: **the
  tensor sum is essentially self-adjoint** as soon as each factor carries a unitary flow.
* `essentiallySelfAdjointOn_cpairDom_selfAdjoint` — the headline for two **self-adjoint**
  operators, Stone's theorem supplying the two flows.  No boundedness, no positivity and no
  assumption on either spectrum.
* `pairCorePoly`, `graphPair`, `exists_pair_core_approx`, `isGraphCore_pairCore`,
  `isGraphCore_cpairCore` — the **two-factor core estimate**: if `C_A` is a graph-norm core of
  `A` and `C_B` one of `B`, then `C_A ⊗ C_B` is a core of the tensor sum; with the transfer
  principle this gives `essentiallySelfAdjointOn_cpairCore` and
  `essentiallySelfAdjointOn_cpairCore_selfAdjoint`.
* `essentiallySelfAdjointOn_cpairDom_esa` — the hypotheses weakened from self-adjointness to
  **essential** self-adjointness on each factor: the two closures are self-adjoint
  (`BookProof.EsaOneParticle.closureSelfAdjoint`), each domain is a core of its closure, the
  core estimate applies, and `exists_pair_of_mem_pairCorePoly` identifies the graph of the
  tensor sum of the closures over `D_A ⊗ D_B` with the graph of the tensor sum of `A` and `B`.
* `tensorSum_stone_flow`, `tensorSum_stone_flow_esa` — the resulting **unitary group**
  `e^{−it(A ⊗ 1 + 1 ⊗ B)}` on `H ⊗̂ K`, via the Stone bridge.
* `positionCube_essentiallySelfAdjoint` — a concrete instance with two *different* unbounded
  operators: multiplication by `k` on `ℓ²(ℤ)` in the first factor and by `k³` in the second;
  `positionCube_first_not_bounded` records that the first factor is genuinely unbounded.

Nothing is assumed: the module contains no `axiom` and no `sorry`.
-/

namespace BookProof.TensorSumEsa

open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore
  BookProof.FlowDGamma BookProof.EsaOneParticle BookProof.ChapterStoneResolvent
  BookProof.TensorOpBound BookProof.EsaClosure

noncomputable section

/-! ## 1. The two-factor tensor sum -/

section Defs

variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)

/-- The isometric inclusion `D_A ⊗ D_B → H ⊗ K` of the algebraic tensor product of the two
domains into the algebraic tensor product of the two spaces. -/
def inclPair : (DA ⊗[ℂ] DB) →ₗᵢ[ℂ] (Hs.carrier ⊗[ℂ] Ks.carrier) :=
  TensorProduct.mapIsometry DA.subtypeₗᵢ DB.subtypeₗᵢ



variable (A : DA →ₗ[ℂ] Hs.carrier) (B : DB →ₗ[ℂ] Ks.carrier)

/-- The **tensor sum** `A ⊗ 1 + 1 ⊗ B`, on the algebraic tensor product of the domains. -/
def sumPoly : (DA ⊗[ℂ] DB) →ₗ[ℂ] (Hs.carrier ⊗[ℂ] Ks.carrier) :=
  TensorProduct.map A DB.subtype + TensorProduct.map DA.subtype B



/-- The image of `D_A ⊗ D_B` inside `H ⊗ K`: the domain of the tensor sum. -/
def pairDom : Submodule ℂ (Hs.carrier ⊗[ℂ] Ks.carrier) :=
  LinearMap.range (inclPair Hs Ks DA DB).toLinearMap

/-- The tensor sum as an operator on the subspace `pairDom` of `H ⊗ K`. -/
def pairOp : pairDom Hs Ks DA DB →ₗ[ℂ] (Hs.carrier ⊗[ℂ] Ks.carrier) :=
  sumPoly Hs Ks DA DB A B ∘ₗ
    (LinearEquiv.ofInjective (inclPair Hs Ks DA DB).toLinearMap
      (inclPair Hs Ks DA DB).injective).symm.toLinearMap



/-- The Hilbert space `H ⊗̂ K`: the completion of the algebraic tensor product. -/
abbrev ctensor : Type := UniformSpace.Completion (Hs.carrier ⊗[ℂ] Ks.carrier)

/-- The isometric embedding of the algebraic tensor product into its completion. -/
def pairEmb : (Hs.carrier ⊗[ℂ] Ks.carrier) →ₗᵢ[ℂ] ctensor Hs Ks :=
  UniformSpace.Completion.toComplₗᵢ

/-- The domain of the tensor sum inside the completed tensor product. -/
def cpairDom : Submodule ℂ (ctensor Hs Ks) :=
  pushDom (pairEmb Hs Ks) (pairDom Hs Ks DA DB)

/-- The tensor sum as an operator in the completed tensor product. -/
def cpairOp : cpairDom Hs Ks DA DB →ₗ[ℂ] ctensor Hs Ks :=
  pushOp (pairEmb Hs Ks) (pairOp Hs Ks DA DB A B)



end Defs

/-! ## 2. Symmetry -/

section Symmetry

variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)
  (A : DA →ₗ[ℂ] Hs.carrier) (B : DB →ₗ[ℂ] Ks.carrier)







end Symmetry

/-! ## 3. Density -/

section Density

variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)





end Density

/-! ## 4. The product flow and essential self-adjointness -/

section Flow

variable {Hs Ks : IPSpace} {DA : Submodule ℂ Hs.carrier} {DB : Submodule ℂ Ks.carrier}
  {A : DA →ₗ[ℂ] Hs.carrier} {B : DB →ₗ[ℂ] Ks.carrier}

variable (P : OneParticleFlow Hs DA A) (Q : OneParticleFlow Ks DB B)



-- The normed `AddCommGroup`/`Module` structures on the complex tensor product are the ones
-- the product rule and the `Submodule.span_induction` motive both elaborate to; pinning
-- them here keeps goal and hypothesis from disagreeing about the hidden instances.
local instance : AddCommGroup (Hs.carrier ⊗[ℂ] Ks.carrier) :=
  TensorProduct.instNormedAddCommGroup.toAddCommGroup
local instance : Module ℝ (Hs.carrier ⊗[ℂ] Ks.carrier) := NormedSpace.complexToReal.toModule

/-- The product flow `U t ⊗ V t`, acting on the algebraic tensor product of the domains. -/
def pflow (t : ℝ) : (DA ⊗[ℂ] DB) →ₗ[ℂ] (DA ⊗[ℂ] DB) :=
  TensorProduct.map (OneParticleFlow.dmap P t) (OneParticleFlow.dmap Q t)















/-- The orbit of a vector of `D_A ⊗ D_B`, inside the completed tensor product. -/
def porbit (x : DA ⊗[ℂ] DB) (t : ℝ) : cpairDom Hs Ks DA DB :=
  ⟨pairEmb Hs Ks (inclPair Hs Ks DA DB (pflow P Q t x)),
    mem_pushDom (pairEmb Hs Ks)
      (⟨inclPair Hs Ks DA DB (pflow P Q t x), ⟨pflow P Q t x, rfl⟩⟩ : pairDom Hs Ks DA DB)⟩











end Flow

/-! ## 5. Two self-adjoint operators -/

section SelfAdjoint

variable {Hs Ks : IPSpace} [CompleteSpace Hs.carrier] [CompleteSpace Ks.carrier]



end SelfAdjoint

/-! ## 6. The two-factor core estimate -/

section Core

variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)
  (A : DA →ₗ[ℂ] Hs.carrier) (B : DB →ₗ[ℂ] Ks.carrier)
  (CA : Submodule ℂ Hs.carrier) (CB : Submodule ℂ Ks.carrier)

/-- The algebraic tensor product `C_A ⊗ C_B` of the two cores, inside `D_A ⊗ D_B`. -/
def pairCorePoly : Submodule ℂ (DA ⊗[ℂ] DB) :=
  Submodule.span ℂ
    {t | ∃ a : DA, (a : Hs.carrier) ∈ CA ∧ ∃ b : DB, (b : Ks.carrier) ∈ CB ∧ a ⊗ₜ[ℂ] b = t}



/-- The graph map `x ↦ (x, (A ⊗ 1 + 1 ⊗ B) x)`. -/
def graphPair :
    (DA ⊗[ℂ] DB) →ₗ[ℂ] (Hs.carrier ⊗[ℂ] Ks.carrier) × (Hs.carrier ⊗[ℂ] Ks.carrier) :=
  (inclPair Hs Ks DA DB).toLinearMap.prod (sumPoly Hs Ks DA DB A B)









/-- The image of `C_A ⊗ C_B` inside `H ⊗ K`. -/
def pairCore : Submodule ℂ (Hs.carrier ⊗[ℂ] Ks.carrier) :=
  Submodule.map (inclPair Hs Ks DA DB).toLinearMap (pairCorePoly Hs Ks DA DB CA CB)



/-- The image of `C_A ⊗ C_B` in the completed tensor product. -/
def cpairCore : Submodule ℂ (ctensor Hs Ks) :=
  pushDom (pairEmb Hs Ks) (pairCore Hs Ks DA DB CA CB)









end Core

/-! ## 7. Two self-adjoint operators and two cores -/

section SelfAdjointCore

variable {Hs Ks : IPSpace} [CompleteSpace Hs.carrier] [CompleteSpace Ks.carrier]



end SelfAdjointCore

/-! ## 8. Two merely essentially self-adjoint operators -/

section Esa

variable {Hs Ks : IPSpace}



variable [CompleteSpace Hs.carrier] [CompleteSpace Ks.carrier]



end Esa

/-! ## 9. The unitary flow -/

section StoneFlow

open BookProof.StoneBridge

variable {Hs Ks : IPSpace} [CompleteSpace Hs.carrier] [CompleteSpace Ks.carrier]





end StoneFlow

/-! ## 10. A genuinely unbounded instance -/

section Instance

open BookProof.ChapterStoneSeparable BookProof.ChapterUnboundedPosition

/-- Multiplication by `k³` on `ℓ²(ℤ)`. -/
def cubeField : ℤ → ℝ := fun k => (k : ℝ) ^ 3





end Instance

end

end BookProof.TensorSumEsa
