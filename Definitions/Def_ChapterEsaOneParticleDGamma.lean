import Theorems.Thm_BookProof_EsaClosure_clExt_selfAdjointCriterion

import Theorems.Thm_BookProof_EsaClosure_clExt_symmetricOn

import Theorems.Thm_BookProof_EsaClosure_coe_mem_clDom

import Theorems.Thm_BookProof_ChapterUnboundedPosition_single_mem_mulDomain

import Definitions.Def_ChapterFlowDGammaEsa
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterContinuityUnitaryInfinite
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterUnboundedPosition
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterTensorGraphCore
import Mathlib


/-!
# Second quantization of an **essentially self-adjoint** one-particle operator

`BookProof/ChapterFlowDGammaEsa.lean` proves that `dΓ(A)` is essentially self-adjoint on the
finite-particle domain over a graph-norm core `D` whenever the one-particle operator `A` is
**self-adjoint**.  This module removes the self-adjointness: the one-particle operator is
only assumed **symmetric and essentially self-adjoint on its own domain `D`** (trivial
deficiency at `± i`, the classical criterion), and the conclusion is stated for that same `D`.

The route is the one the closure machinery of `BookProof/ChapterEsaClosureCore.lean` makes
available:

* `closureSelfAdjoint` — the closure `Ā` of `A`, an `UnboundedSelfAdjoint` operator on
  `clDom A`, self-adjoint exactly because `A` is essentially self-adjoint;
* `isGraphCore_clDom` — `D` is a graph-norm core of `Ā` (this is what the graph closure is);
* the self-adjoint theorem, applied to `Ā` with core `D`, gives essential self-adjointness of
  the sector derivation of `Ā` on the tensor power `D^{⊗n}` of the core;
* `esa_graph_le` and the tensor lemmas `exists_pow_of_mem_corePow`, `sectorCore_graph_le`,
  `fockSectorCore_graph_le` — essential self-adjointness passes to an extension of the graph,
  and the graph of the sector derivation of `Ā` over `D^{⊗n}` is contained in the graph of the
  sector derivation of `A` itself, because `Ā` extends `A`;
* `essentiallySelfAdjointOn_fockSectorDom_esa` — the sectorwise statement for `A` alone;
* `dGamma_essentiallySelfAdjointOn_of_esa` — **the main theorem**: if the one-particle
  Hermitian operator `A` is essentially self-adjoint on `D`, then `dΓ(A)` is essentially
  self-adjoint on the finite-particle domain `𝓕_fin(D)`.

Nothing is assumed: the module contains no `axiom` and no `sorry`.
-/

namespace BookProof.EsaOneParticle

open scoped TensorProduct ENNReal
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore
  BookProof.SecondQuantizationCore BookProof.DirectSumEsa BookProof.EsaClosure
  BookProof.EsaPair BookProof.FlowDGamma BookProof.ChapterStoneResolvent
  BookProof.ChapterUnitaryTransport

noncomputable section

/-! ## Essential self-adjointness passes to an extension -/

section Transfer

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]





end Transfer

/-! ## The graph of the sector derivation over the core -/

section Tensor

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier) (A₂ : D₂ →ₗ[ℂ] Hs.carrier)
  (D : Submodule ℂ Hs.carrier) (A : D →ₗ[ℂ] Hs.carrier) (hle : D ≤ D₂)
  (hext : ∀ v : D, A₂ ⟨(v : Hs.carrier), hle v.2⟩ = A v)







end Tensor

/-! ## The closure of an essentially self-adjoint one-particle operator -/

section Closure

variable {Hs : IPSpace} {D : Submodule ℂ Hs.carrier}

/-- The domain of the closure is dense, since it contains `D`. -/
theorem dense_clDom (A : D →ₗ[ℂ] Hs.carrier) (hdense : Dense (D : Set Hs.carrier)) :
    Dense ((clDom A : Submodule ℂ Hs.carrier) : Set Hs.carrier) :=
  hdense.mono (fun x hx => coe_mem_clDom A ⟨x, hx⟩)





variable [CompleteSpace Hs.carrier]

/-- **The closure of an essentially self-adjoint operator, as a self-adjoint operator.**  Its
domain is the domain `clDom A` of the graph closure, and it extends `A`. -/
def closureSelfAdjoint (A : D →ₗ[ℂ] Hs.carrier) (hdense : Dense (D : Set Hs.carrier))
    (hsym : SymmetricOn D A) (hesa : EssentiallySelfAdjointOn D A) :
    UnboundedSelfAdjoint Hs.carrier where
  domain := clDom A
  op := clExt A hdense hsym
  denseDomain := dense_clDom A hdense
  symmetric := clExt_symmetricOn A hdense hsym
  selfAdjoint := by
    ext phi
    constructor
    · rintro ⟨eta, heta⟩
      obtain ⟨hmem, -⟩ := clExt_selfAdjointCriterion A hdense hsym hesa phi eta heta
      exact hmem
    · intro hphi
      exact ⟨clExt A hdense hsym ⟨phi, hphi⟩,
        fun psi => clExt_symmetricOn A hdense hsym psi ⟨phi, hphi⟩⟩

@[simp] theorem closureSelfAdjoint_domain (A : D →ₗ[ℂ] Hs.carrier)
    (hdense : Dense (D : Set Hs.carrier)) (hsym : SymmetricOn D A)
    (hesa : EssentiallySelfAdjointOn D A) :
    (closureSelfAdjoint A hdense hsym hesa).domain = clDom A := rfl

@[simp] theorem closureSelfAdjoint_op (A : D →ₗ[ℂ] Hs.carrier)
    (hdense : Dense (D : Set Hs.carrier)) (hsym : SymmetricOn D A)
    (hesa : EssentiallySelfAdjointOn D A) :
    (closureSelfAdjoint A hdense hsym hesa).op = clExt A hdense hsym := rfl

end Closure

/-! ## The main theorem -/

section Main

variable {Hs : IPSpace} [CompleteSpace Hs.carrier] {D : Submodule ℂ Hs.carrier}
  (A : D →ₗ[ℂ] Hs.carrier) (hdense : Dense (D : Set Hs.carrier)) (hsym : SymmetricOn D A)
  (hesa : EssentiallySelfAdjointOn D A)







end Main

/-! ## The hypothesis is strictly weaker than self-adjointness -/

section Weaker

variable {Hs : IPSpace}









end Weaker

/-! ## A concrete instance: the position operator on the finitely supported vectors

Nothing above is vacuous.  On `ℓ²(ℤ)` the position operator — multiplication by `k`, an
unbounded self-adjoint operator — is restricted to the span `Dfin` of the basis vectors
`δ_k`, i.e. to the finitely supported sequences.  On that domain it is *essentially* self
adjoint (`positionCore_essentiallySelfAdjoint`) but *not* self-adjoint
(`positionCore_not_isSelfAdjointOn`), and the main theorem applies to it. -/

section PositionExample

open BookProof.ChapterUnboundedPosition BookProof.ChapterStoneSeparable
open BookProof.ChapterContinuityUnitaryInfinite (L2Z)
open BookProof.DiagonalDGamma

/-- The basis vector `δ_k` of `ℓ²(ℤ)`. -/
def deltaVec (k : ℤ) : L2Z := lp.single 2 k (1 : ℂ)

/-- The finitely supported vectors: the span of the basis vectors. -/
def Dfin : Submodule ℂ L2Z := Submodule.span ℂ (Set.range deltaVec)



/-- The finitely supported vectors lie in the domain of every multiplication operator. -/
theorem Dfin_le_mulDomain (f : ℤ → ℝ) : Dfin ≤ mulDomain f := by
  refine Submodule.span_le.mpr ?_
  rintro _ ⟨k, rfl⟩
  exact single_mem_mulDomain f k 1

/-- **The position operator restricted to the finitely supported vectors.** -/
def positionCore : Dfin →ₗ[ℂ] L2Z :=
  restrictOp (mulOp positionField) (Dfin_le_mulDomain positionField)







/-! ### The core is proper: an explicit vector of the domain outside it -/

/-- The summability input: `∑ 1/k²` over `ℤ`. -/
theorem summable_one_div_int_sq : Summable (fun k : ℤ => 1 / ((k : ℝ)) ^ 2) :=
  Real.summable_one_div_int_pow.mpr (by norm_num)

/-- `1 ≤ k²` for a nonzero integer `k`. -/
theorem one_le_int_sq {k : ℤ} (hk : k ≠ 0) : (1 : ℝ) ≤ ((k : ℝ)) ^ 2 := by
  have h1 : (1 : ℝ) ≤ |(k : ℝ)| := by
    have h2 : 1 ≤ |k| := Int.one_le_abs (by omega)
    calc (1 : ℝ) = ((1 : ℤ) : ℝ) := by norm_num
      _ ≤ ((|k| : ℤ) : ℝ) := by exact_mod_cast h2
      _ = |(k : ℝ)| := by push_cast [Int.cast_abs]; ring
  nlinarith [abs_nonneg ((k : ℝ)), sq_abs ((k : ℝ))]

/-- The tail sequence `1/(k²+1)` is square-summable. -/
theorem summable_witness_sq : Summable (fun k : ℤ => (1 / ((k : ℝ) ^ 2 + 1)) ^ 2) := by
  refine (summable_one_div_int_sq.update 0 1).of_nonneg_of_le (fun k => by positivity)
    (fun k => ?_)
  rcases eq_or_ne k 0 with rfl | hk
  · norm_num [Function.update]
  · rw [Function.update_of_ne hk, div_pow, one_pow]
    have ht := one_le_int_sq hk
    exact one_div_le_one_div_of_le (by positivity) (by nlinarith)



/-- The witness sequence `k ↦ 1/(k²+1)`, as a vector of `ℓ²(ℤ)`. -/
def witnessFun (k : ℤ) : ℂ := ((1 / ((k : ℝ) ^ 2 + 1) : ℝ) : ℂ)

theorem memℓp_witnessFun : Memℓp witnessFun 2 := by
  refine memℓp_gen ?_
  have h : (fun k : ℤ => ‖witnessFun k‖ ^ (2 : ℝ≥0∞).toReal)
      = fun k : ℤ => (1 / ((k : ℝ) ^ 2 + 1)) ^ 2 := by
    funext k
    have hpos : (0 : ℝ) ≤ 1 / ((k : ℝ) ^ 2 + 1) := by positivity
    rw [show ((2 : ℝ≥0∞).toReal) = ((2 : ℕ) : ℝ) by norm_num, Real.rpow_natCast, witnessFun,
      Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg hpos]
  rw [h]
  exact summable_witness_sq

/-- The witness vector of `ℓ²(ℤ)`: every entry is nonzero, so it is not finitely
supported. -/
def witness : L2Z := ⟨witnessFun, memℓp_witnessFun⟩





/-- The finitely supported vectors, as a submodule. -/
def finSupp : Submodule ℂ L2Z where
  carrier := {x : L2Z | {k : ℤ | (x : ℤ → ℂ) k ≠ 0}.Finite}
  zero_mem' := by simp
  add_mem' := by
    intro a b ha hb
    refine Set.Finite.subset (ha.union hb) (fun k hk => ?_)
    simp only [Set.mem_setOf_eq, lp.coeFn_add, Pi.add_apply] at hk
    by_contra hcon
    simp only [Set.mem_union, Set.mem_setOf_eq, not_or, not_not] at hcon
    exact hk (by rw [hcon.1, hcon.2, add_zero])
  smul_mem' := by
    intro c a ha
    refine Set.Finite.subset ha (fun k hk => ?_)
    simp only [Set.mem_setOf_eq, lp.coeFn_smul, Pi.smul_apply, smul_eq_mul] at hk ⊢
    intro h0
    exact hk (by rw [h0, mul_zero])











end PositionExample

end

end BookProof.EsaOneParticle
