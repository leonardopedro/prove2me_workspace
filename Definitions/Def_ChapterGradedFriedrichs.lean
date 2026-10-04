import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_memLpTwo_of_finite_support

import Definitions.Def_ChapterGradedFock
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterYangMillsFriedrichs
import Mathlib


/-!
# Chapter GradedFriedrichs — the analytic half of the graded second quantization

`BookProof.ChapterGradedFock` builds the graded Fock space `Γˢ ⊗ Γᵃ` and its
**algebraic** structure (the unified graded canonical relation, the `ℤ₂`
grading).  What `CONSOLIDATED_PLAN.md` §10.6.2 item 3 still asked for is the
**analytic** conclusion: that the total graded Hamiltonian

`dΓ(A, B) = dΓˢ(A) ⊗ 1 + 1 ⊗ dΓᵃ(B)`

is a densely defined positive symmetric operator on `ℓ²(Conf × FConf)` itself —
not merely factorwise — and therefore has a positive self-adjoint (Friedrichs)
extension.  This chapter proves that.

## Deliverables

* A reusable **generic transport** of the algebraic model `γ →₀ ℂ` into
  `ℓ²(γ)`: `toL2`, `ainner` (the algebraic inner product), `algEquivL2`
  (the algebraic space *is* the finite-mode domain), `opOfAlg`, and the two
  criteria `IsSymAlg`/`IsPosAlg` transporting to `SymmetricOn` and to
  nonnegativity of the quadratic form, hence `algOp_friedrichs_extension`.
* The **slice calculus** for the tensor product: `sliceFst`, `sliceSnd`, the
  factorization `ainner_eq_sum_sliceFst` / `ainner_eq_sum_sliceSnd` of the inner
  product into a finite sum over the slices, and the intertwining
  `sliceFst_liftFst` / `sliceSnd_liftSnd`.
* **`isSymAlg_liftFst`, `isPosAlg_liftFst`, `isSymAlg_liftSnd`,
  `isPosAlg_liftSnd`** — symmetry and positivity of a one-factor operator are
  inherited by its lift to the tensor product.  This is what makes the graded
  statement genuinely two-dimensional rather than factorwise.
* **`gradedHamiltonian_friedrichs_extension`** — the headline: for a Hermitian
  positive bosonic one-particle matrix `A` and a Hermitian positive fermionic
  one `B`, the operator `dΓˢ(A) ⊗ 1 + 1 ⊗ dΓᵃ(B)` on the finite-mode domain of
  `ℓ²(Conf × FConf)` has a positive self-adjoint extension.
* **`gradedSecondQuantization_friedrichs`** — the same conclusion phrased for
  arbitrary symmetric positive one-particle operators given in a Hilbert basis.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

namespace BookProof.GradedFriedrichs

open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin
open BookProof.FockSecondQuantization BookProof.FermionFock BookProof.GradedFock

noncomputable section

/-! ## A generic transport `(γ →₀ ℂ) → ℓ²(γ)` -/

section Generic

variable {γ : Type*}

/-- A finitely supported function on `γ`, viewed inside `ℓ²(γ)`. -/
def toL2 (u : γ →₀ ℂ) : L2I γ :=
  ⟨fun g => u g, memLpTwo_of_finite_support u.finite_support⟩

@[simp] theorem toL2_apply (u : γ →₀ ℂ) (g : γ) :
    ((toL2 u : L2I γ) : γ → ℂ) g = u g := rfl

/-- The transport map is linear. -/
def toL2L : (γ →₀ ℂ) →ₗ[ℂ] L2I γ where
  toFun := toL2
  map_add' u v := by refine lp.ext (funext fun g => ?_); rfl
  map_smul' c u := by refine lp.ext (funext fun g => ?_); simp [toL2]

@[simp] theorem toL2L_apply (u : γ →₀ ℂ) : toL2L u = toL2 u := rfl

theorem toL2_mem (u : γ →₀ ℂ) : toL2 u ∈ lpFiniteModes γ := u.finite_support

theorem toL2_injective : Function.Injective (toL2 (γ := γ)) := by
  intro u v h
  refine Finsupp.ext fun g => ?_
  have := congrArg (fun f : L2I γ => (f : γ → ℂ) g) h
  simpa using this

/-- The **algebraic inner product**: the `ℓ²` inner product read on the
finitely supported model. -/
def ainner (u v : γ →₀ ℂ) : ℂ := inner ℂ (toL2 u) (toL2 v)









/-- `T` is **formally symmetric** for the algebraic inner product. -/
def IsSymAlg (T : Module.End ℂ (γ →₀ ℂ)) : Prop := ∀ u v, ainner (T u) v = ainner u (T v)

/-- `T` is **formally positive** for the algebraic inner product. -/
def IsPosAlg (T : Module.End ℂ (γ →₀ ℂ)) : Prop := ∀ u, 0 ≤ (ainner u (T u)).re





/-! ### The algebraic space is the finite-mode domain -/

/-- The finitely supported model **is** the finite-mode subspace of `ℓ²(γ)`. -/
def algEquivL2 : (γ →₀ ℂ) ≃ₗ[ℂ] lpFiniteModes γ := by
  classical
  refine LinearEquiv.ofBijective (toL2L.codRestrict (lpFiniteModes γ) toL2_mem) ⟨?_, ?_⟩
  · intro u v h
    exact toL2_injective (congrArg Subtype.val h)
  · rintro ⟨x, hx⟩
    refine ⟨Finsupp.onFinset hx.toFinset (fun g => (x : γ → ℂ) g) ?_, ?_⟩
    · intro g hg
      exact hx.mem_toFinset.mpr hg
    · exact Subtype.ext (lp.ext (funext fun _ => rfl))

@[simp] theorem coe_algEquivL2 (u : γ →₀ ℂ) :
    ((algEquivL2 u : lpFiniteModes γ) : L2I γ) = toL2 u := rfl



/-- The operator on the finite-mode domain determined by an operator of the
algebraic model. -/
def opOfAlg (T : Module.End ℂ (γ →₀ ℂ)) : lpFiniteModes γ →ₗ[ℂ] L2I γ :=
  (lpFiniteModes γ).subtype.comp (algEquivL2.conj T)









end Generic

/-! ## The slice calculus of the tensor product -/

section Slices

variable {α β : Type*}

/-- The **first-factor slice** at `b`: `(sliceFst b u) a = u (a, b)`. -/
def sliceFst (b : β) : ((α × β) →₀ ℂ) →ₗ[ℂ] (α →₀ ℂ) :=
  Finsupp.lsum ℂ fun p => LinearMap.toSpanSingleton ℂ _
    ((Finsupp.single p.2 (1 : ℂ) : β →₀ ℂ) b • (Finsupp.single p.1 (1 : ℂ) : α →₀ ℂ))

/-- The **second-factor slice** at `a`: `(sliceSnd a u) b = u (a, b)`. -/
def sliceSnd (a : α) : ((α × β) →₀ ℂ) →ₗ[ℂ] (β →₀ ℂ) :=
  Finsupp.lsum ℂ fun p => LinearMap.toSpanSingleton ℂ _
    ((Finsupp.single p.1 (1 : ℂ) : α →₀ ℂ) a • (Finsupp.single p.2 (1 : ℂ) : β →₀ ℂ))





















open Classical in
/-- A finset rectangle containing the supports of all the vectors involved. -/
def rect (s : Finset (α × β)) : Finset α × Finset β := (s.image Prod.fst, s.image Prod.snd)











end Slices

/-! ## The graded Hamiltonian `dΓˢ(A) ⊗ 1 + 1 ⊗ dΓᵃ(B)` -/









/-- The **total graded second-quantized Hamiltonian** on the algebraic graded
Fock space: `dΓˢ(A) ⊗ 1 + 1 ⊗ dΓᵃ(B)`. -/
def gradedHamiltonianAlg (colB colF : ℕ → (ℕ →₀ ℂ)) : Module.End ℂ GradedAlg :=
  liftFst (dGamma colB) + liftSnd (dGammaF colF)

/-- The **total graded second-quantized Hamiltonian** on the finite-mode domain
of `ℓ²(Conf × FConf) ≅ Γˢ ⊗ Γᵃ`. -/
def gradedHamiltonian (colB colF : ℕ → (ℕ →₀ ℂ)) : lpFiniteModes GConf →ₗ[ℂ] GFock :=
  opOfAlg (gradedHamiltonianAlg colB colF)













/-! ## Non-vacuity: the total number operator `N_b ⊗ 1 + 1 ⊗ N_f` -/

/-- The identity one-particle matrix `A e_k = e_k`, whose second quantization is
the number operator. -/
def idCol : ℕ → (ℕ →₀ ℂ) := fun j => Finsupp.single j 1















end

end BookProof.GradedFriedrichs
