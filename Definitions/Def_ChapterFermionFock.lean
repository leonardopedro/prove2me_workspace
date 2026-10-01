import Theorems.Thm_BookProof_NavierStokesFlow_lpSingle_mem_lpFiniteModes

import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterBRSTNilpotent
import Mathlib


/-!
# Chapter FermionFock — the fermionic (CAR) Fock space and its second quantization

`CONSOLIDATED_PLAN.md` §10.6.2 item 3 asks for the missing **fermionic half** of
the quantum-gravity second quantization: the project builds the bosonic Fock
space `Γˢ` over a one-particle core (`ChapterFockSecondQuantization`, occupation
numbers `Conf = ℕ →₀ ℕ`), but the antisymmetric factor `Γᵃ` — the ghost/fermion
sector, whose canonical **anticommutation** relations `ChapterBRSTNilpotent`
carries as the abstract hypothesis `GhostCAR` — is not constructed anywhere.

This chapter constructs it, in exactly the style of the bosonic one.

## Deliverables

* `FConf`, `FermiAlg`, `FermiFock` — a fermionic configuration is the **finite
  set of occupied modes**, the algebraic Fock space is `FConf →₀ ℂ`, and the
  Fock space is `ℓ²(FConf)`.
* `fsign` — the Jordan–Wigner sign `(−1)^{#\{i ∈ S : i < j\}}`, and the sign
  calculus it obeys (`fsign_mul_self`, `fsign_erase`, `fsign_insert_self`,
  `fsign_insert_of_ne`).
* `creF`, `annF` — creation and annihilation, with their coordinate formulas
  `creF_apply`, `annF_apply`.
* **The canonical anticommutation relations**, all four of them:
  `car_annF_creF_self` (`{c_j, c_j†} = 1`), `car_creF_creF` (`{c_j†, c_k†} = 0`,
  including `creF_creF_self`: `(c_j†)² = 0`, the Pauli principle),
  `car_annF_annF` (`{c_j, c_k} = 0`) and `car_annF_creF_of_ne`
  (`{c_j, c_k†} = 0` for `j ≠ k`).
* `inner_creF_left` — creation and annihilation are formal adjoints of each
  other on the finite-occupation domain.
* `dGammaF`, `dGammaOpF` — the fermionic second quantization
  `dΓᵃ(A) = Σ_{j,k} ⟪e_j, A e_k⟫ c_j† c_k`, its symmetry
  (`dGammaOpF_symmetricOn`) and positivity (`dGammaOpF_quadForm_nonneg`) for a
  Hermitian, positive semidefinite one-particle matrix.
* `dGammaF_friedrichs_extension`, `secondQuantizationF_friedrichs` — the
  fermionic second quantization of any symmetric positive one-particle operator
  has a positive self-adjoint (Friedrichs) extension …
* `dGammaF_hashimoto_selects`, `secondQuantizationF_hashimoto_selects` — … and
  the Hashimoto/SIRK shift-invert limit selects exactly that extension, with the
  Galerkin truncations converging strongly and in the resolvent sense.
* `parityF` — the fermion-number parity `(−1)^{N_f}`, the `ℤ₂` grading
  operator: an involution (`parityF_involutive`) that anticommutes with both
  creation and annihilation (`parityF_creF`, `parityF_annF`).
* `ghostCAR_creF_annF` — **the abstract ghost relations are realized**: the
  operators built here satisfy `BookProof.BRSTNilpotent.GhostCAR`, so the BRST
  chapter's hypotheses are not vacuous — and `brst_charge_nilpotent_fermiFock`
  is the resulting concrete nilpotency `Q² = 0`.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

namespace BookProof.FermionFock

open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.YangMillsFriedrichs
open BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization (IsHermCol IsPosCol opCol isHermCol_opCol isPosCol_opCol)

noncomputable section

/-! ## Configurations and the Jordan–Wigner sign -/

/-- A **fermionic configuration**: the (finite) set of occupied one-particle
modes.  The Pauli principle is built into the type: a mode is occupied or not. -/
abbrev FConf := Finset ℕ

/-- The **algebraic fermionic Fock space**: finite linear combinations of
configurations. -/
abbrev FermiAlg := FConf →₀ ℂ

/-- The **fermionic Fock space** `ℓ²(FConf)`. -/
abbrev FermiFock := L2I FConf

/-- The **Jordan–Wigner sign** `(−1)^{#\{i ∈ S : i < j\}}` picked up when a
fermion is created in, or removed from, the mode `j` of the configuration
`S`. -/
def fsign (j : ℕ) (S : FConf) : ℂ := (-1 : ℂ) ^ ((S.filter (fun i => i < j)).card)











/-! ## Creation and annihilation at the algebraic level -/

open Classical in
/-- **The fermionic creation operator of the mode `j`**:
`c_j†|S⟩ = 0` if `j ∈ S`, and `(−1)^{#\{i ∈ S : i < j\}}|S ∪ \{j\}⟩` otherwise. -/
def creF (j : ℕ) : FermiAlg →ₗ[ℂ] FermiAlg :=
  Finsupp.lsum ℂ fun S => LinearMap.toSpanSingleton ℂ FermiAlg
    (if j ∈ S then 0 else Finsupp.single (insert j S) (fsign j S))

open Classical in
/-- **The fermionic annihilation operator of the mode `j`**:
`c_j|S⟩ = (−1)^{#\{i ∈ S : i < j\}}|S \ \{j\}⟩` if `j ∈ S`, and `0` otherwise. -/
def annF (j : ℕ) : FermiAlg →ₗ[ℂ] FermiAlg :=
  Finsupp.lsum ℂ fun S => LinearMap.toSpanSingleton ℂ FermiAlg
    (if j ∈ S then Finsupp.single (S.erase j) (fsign j S) else 0)









/-! ## The canonical anticommutation relations -/











/-! ## The occupied modes of a state -/

/-- The set of modes a state of the algebraic Fock space can occupy. -/
def modesF (u : FermiAlg) : Finset ℕ := u.support.biUnion id





/-! ## Transport to `ℓ²(FConf)` -/

/-- A finitely supported fermionic state as an element of `ℓ²(FConf)`. -/
def toLpF (u : FermiAlg) : FermiFock :=
  ⟨fun S => u S, memLpTwo_of_finite_support u.finite_support⟩



/-- The transport map is linear. -/
def toLpFL : FermiAlg →ₗ[ℂ] FermiFock where
  toFun := toLpF
  map_add' u v := by
    refine lp.ext (funext fun S => ?_)
    simp [toLpF, Pi.add_apply]
    try rfl
  map_smul' c u := by
    refine lp.ext (funext fun S => ?_)
    simp [toLpF]



theorem toLpF_mem (u : FermiAlg) : toLpF u ∈ lpFiniteModes FConf := u.finite_support

theorem toLpF_injective : Function.Injective toLpF := by
  intro u v h
  refine Finsupp.ext fun S => ?_
  have := congrArg (fun f : FermiFock => (f : FConf → ℂ) S) h
  simpa using this





/-! ## Creation and annihilation are formal adjoints -/

/-- The involution of configurations that toggles the occupation of the mode
`j`; it matches the configurations `c_j†` connects. -/
def toggle (j : ℕ) (S : FConf) : FConf := if j ∈ S then S.erase j else insert j S















/-! ## The finite-occupation domain of the fermionic Fock space -/

/-- The algebraic fermionic Fock space **is** the finite-occupation subspace of
`ℓ²(FConf)`. -/
def fermiEquiv : FermiAlg ≃ₗ[ℂ] lpFiniteModes FConf := by
  classical
  refine LinearEquiv.ofBijective (toLpFL.codRestrict (lpFiniteModes FConf) toLpF_mem) ⟨?_, ?_⟩
  · intro u v h
    exact toLpF_injective (congrArg Subtype.val h)
  · rintro ⟨x, hx⟩
    refine ⟨Finsupp.onFinset hx.toFinset (fun S => (x : FConf → ℂ) S) ?_, ?_⟩
    · intro S hS
      exact hx.mem_toFinset.mpr hS
    · exact Subtype.ext (lp.ext (funext fun _ => rfl))





/-! ## Fermionic second quantization -/

/-- The creation operator of a finitely supported one-particle vector
`v = Σ_j v_j e_j`: `c†(v) = Σ_j v_j c_j†`. -/
def creVecF (v : ℕ →₀ ℂ) : FermiAlg →ₗ[ℂ] FermiAlg := ∑ j ∈ v.support, (v j) • creF j

/-- **The fermionic second quantization** `dΓᵃ(A) = Σ_k c†(A e_k) c_k` of the
one-particle operator whose `k`-th column of matrix elements is `col k` (so
`(col k) j = ⟪e_j, A e_k⟫`).  Because a fermionic configuration *is* its set of
occupied modes, the sum on a basis state `|S⟩` runs over `k ∈ S`. -/
def dGammaF (col : ℕ → (ℕ →₀ ℂ)) : FermiAlg →ₗ[ℂ] FermiAlg :=
  Finsupp.lsum ℂ fun S => LinearMap.toSpanSingleton ℂ FermiAlg
    (∑ k ∈ S, creVecF (col k) (annF k (Finsupp.single S 1)))













/-! ### Symmetry and positivity of the fermionic second quantization -/











/-- A finite set of modes large enough for both states and for the columns of
the one-particle matrix over their modes. -/
def closureModesF (col : ℕ → (ℕ →₀ ℂ)) (u v : FermiAlg) : Finset ℕ :=
  (modesF u ∪ modesF v) ∪ (modesF u ∪ modesF v).biUnion fun k => (col k).support











/-! ### The fermionic second-quantized operator on the finite-occupation domain -/

/-- **The fermionic second-quantized operator** on the finite-occupation domain
of the fermionic Fock space. -/
def dGammaOpF (col : ℕ → (ℕ →₀ ℂ)) : lpFiniteModes FConf →ₗ[ℂ] FermiFock :=
  (lpFiniteModes FConf).subtype.comp (fermiEquiv.conj (dGammaF col))













/-! ## The fermion-number parity (the `ℤ₂` grading operator) -/

/-- **The fermion-number parity operator** `(−1)^{N_f}`: it multiplies the
configuration `S` by `(−1)^{|S|}`.  It is the grading operator of the fermionic
Fock space. -/
def parityF : FermiAlg →ₗ[ℂ] FermiAlg :=
  Finsupp.lsum ℂ fun S => LinearMap.toSpanSingleton ℂ FermiAlg
    (Finsupp.single S ((-1 : ℂ) ^ S.card))









/-! ## The Hashimoto/SIRK selection for the fermionic second quantization -/

section Selection

open Filter Topology

variable {ι : Type*} [DecidableEq ι]

/-- The canonical Hilbert basis of `ℓ²(ι)`, indexed by `ι` itself. -/
def l2Basis (ι : Type*) : HilbertBasis ι ℂ (L2I ι) :=
  HilbertBasis.ofRepr (LinearIsometryEquiv.refl ℂ _)

theorem l2Basis_apply (α : ι) : l2Basis ι α = lp.single 2 α (1 : ℂ) := by
  rw [← HilbertBasis.repr_symm_single]
  rfl

/-- The canonical basis of `ℓ²(ι)` re-indexed by `ℕ`, the form in which the
abstract Friedrichs and Hashimoto theorems are stated. -/
def l2BasisN (ε : ℕ ≃ ι) : HilbertBasis ℕ ℂ (L2I ι) :=
  HilbertBasis.mk ((l2Basis ι).orthonormal.comp _ ε.injective)
    (by
      have h := (l2Basis ι).dense_span
      rw [Set.range_comp, ε.range_eq_univ, Set.image_univ]
      exact h.ge)

theorem l2BasisN_apply (ε : ℕ ≃ ι) (n : ℕ) :
    l2BasisN ε n = lp.single 2 (ε n) (1 : ℂ) := by
  rw [l2BasisN, HilbertBasis.coe_mk]
  exact l2Basis_apply _

theorem lp_sum_single_coordI (S : Finset ι) (f : ι → ℂ) (β : ι) :
    (((∑ α ∈ S, f α • lp.single 2 α (1 : ℂ)) : L2I ι) : ι → ℂ) β
      = if β ∈ S then f β else 0 := by
  classical
  induction S using Finset.induction with
  | empty => simp
  | insert a s ha ih =>
    rw [Finset.sum_insert ha]
    simp only [lp.coeFn_add, Pi.add_apply, lp.coeFn_smul, Pi.smul_apply, smul_eq_mul,
      lp.single_apply, ih]
    by_cases hb : β = a
    · subst hb
      simp [ha]
    · simp [hb, Finset.mem_insert]

omit [DecidableEq ι] in
/-- **The finite-mode domain of the canonical basis of `ℓ²(ι)` is exactly the
finitely supported subspace**, so the abstract theorems apply verbatim. -/
theorem finiteModeDomain_l2BasisN (ε : ℕ ≃ ι) :
    finiteModeDomain (l2BasisN ε) = lpFiniteModes ι := by
  classical
  refine le_antisymm (Submodule.span_le.mpr ?_) fun x hx => ?_
  · rintro y ⟨n, rfl⟩
    rw [l2BasisN_apply]
    exact lpSingle_mem_lpFiniteModes _ _
  · set S : Finset ι := hx.toFinset with hS
    have hxeq : x = ∑ α ∈ S, ((x : ι → ℂ) α) • lp.single 2 α (1 : ℂ) := by
      refine lp.ext (funext fun β => ?_)
      rw [lp_sum_single_coordI]
      by_cases hb : β ∈ S
      · simp [hb]
      · have hz : (x : ι → ℂ) β = 0 := by
          by_contra hc
          exact hb (hx.mem_toFinset.mpr hc)
        simp [hb, hz]
    rw [hxeq]
    refine Submodule.sum_mem _ fun α _ => Submodule.smul_mem _ _ ?_
    refine Submodule.subset_span ⟨ε.symm α, ?_⟩
    rw [l2BasisN_apply, Equiv.apply_symm_apply]

/-- The fermionic second-quantized operator on the finite-mode domain of
`l2BasisN ε` (the same subspace as `lpFiniteModes FConf`). -/
def dGammaOpFB (ε : ℕ ≃ FConf) (col : ℕ → (ℕ →₀ ℂ)) :
    finiteModeDomain (l2BasisN ε) →ₗ[ℂ] FermiFock :=
  (dGammaOpF col).comp (LinearEquiv.ofEq _ _ (finiteModeDomain_l2BasisN ε)).toLinearMap







/-- A concrete enumeration of the fermionic configurations, so that the
selection theorem is not vacuous. -/
def fermiEnum : ℕ ≃ FConf :=
  letI : Denumerable FConf := Denumerable.ofEncodableOfInfinite _
  (Denumerable.eqv FConf).symm



end Selection

/-! ## The BRST ghost relations are realized

`BookProof.BRSTNilpotent` proves the nilpotency `Q² = 0` of the cubic ghost BRST
charge from the *abstract* hypothesis `GhostCAR χ β`.  The operators built in
this chapter satisfy it, so those hypotheses are not vacuous. -/

/-- The ghost creation operators `χ_a = c_a†` on the fermionic Fock space. -/
def ghostChi (n : ℕ) : Fin n → Module.End ℂ FermiAlg := fun a => creF a.val

/-- The ghost annihilation operators `β_a = c_a` on the fermionic Fock space. -/
def ghostBeta (n : ℕ) : Fin n → Module.End ℂ FermiAlg := fun a => annF a.val





end

end BookProof.FermionFock
