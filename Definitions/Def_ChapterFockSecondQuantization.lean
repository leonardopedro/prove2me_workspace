import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_memLpTwo_of_finite_support

import Theorems.Thm_BookProof_NavierStokesFlow_lpSingle_mem_lpFiniteModes

import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterYangMillsHermite
import Mathlib


/-!
# Second quantization over a one-particle core (Part F.11)

`PLAN_LEAN_SPECIALIST_QYM_FLOW.md` Part F.11 asks for the **second-quantized**
Hamiltonian on the finite-occupation states over the one-particle core, i.e. the
last row of the field-space realization of the gauge-fixed Yang–Mills
Hamiltonian.

The Fock space over a one-particle space with a countable orthonormal basis
`(e_k)` is `ℓ²` over the *configurations* `Conf = ℕ →₀ ℕ` (occupation numbers,
finitely many excited modes), and the finite-occupation domain is the dense
subspace `lpFiniteModes Conf` of finitely supported configuration vectors.  All
operators are defined at the *algebraic* level on `FockAlg = Conf →₀ ℂ` — where
linearity is free — and transported to the Hilbert space by the isomorphism
`fockEquiv`.

* `up`, `dn` — adding and removing one quantum in a mode;
* `annA j`, `creA j` — annihilation and creation, with the canonical commutation
  relation `[a_j, a_j†] = 1` (`ccr_annA_creA`) and the adjoint pairing
  `⟪a_j† u, v⟫ = ⟪u, a_j v⟫` (`inner_creA_left`);
* `dGamma col` — the second quantization `dΓ(A) = Σ_{j,k} ⟪e_j, A e_k⟫ a_j† a_k`
  of a one-particle operator given by its (column-finite) matrix `col`, and
  `dGamma_one_particle`, which checks that on the one-particle sector it *is*
  the one-particle operator;
* `dGammaOp_symmetricOn`, `dGammaOp_quadForm_nonneg` — symmetry and positivity of
  `dΓ(A)` on the finite-occupation domain, from Hermiticity and positivity of the
  one-particle matrix;
* `dGamma_friedrichs_extension` — hence `dΓ(A)` has a positive self-adjoint
  (Friedrichs) extension;
* `secondQuantization_friedrichs` — the same for the matrix of an arbitrary
  symmetric positive one-particle operator on the finite-mode domain of a Hilbert
  basis;
* `ym_fock_friedrichs_extension` — **F.11**: the second quantization of the
  field-space Yang–Mills Hamiltonian `H₁ = ½Σπ² + ½ΣB²` of
  `BookProof.YangMillsHermite` has a positive self-adjoint extension on the Fock
  space over the Gauss–polynomial core of `L²(ℝ⁹⁹)`;
* `dGamma_hashimoto_selects`, `secondQuantization_hashimoto_selects` and
  `ym_fock_hashimoto_selects` — the Hashimoto/SIRK shift-invert limit selects
  exactly that Friedrichs extension, with the Galerkin truncations of the
  shift-inverted operator converging strongly and in the resolvent sense.

No mass gap and no global existence is claimed; the Millennium problem stays out
of scope.
-/

namespace BookProof.FockSecondQuantization

open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

/-! ## Configurations -/

/-- A **configuration**: the occupation numbers of the one-particle modes, all
but finitely many of them zero. -/
abbrev Conf := ℕ →₀ ℕ

/-- The **algebraic Fock space**: finite linear combinations of configurations. -/
abbrev FockAlg := Conf →₀ ℂ

/-- The **Fock space** `ℓ²(Conf)`. -/
abbrev Fock := L2I Conf

/-- Add one quantum in the mode `j`. -/
def up (j : ℕ) (α : Conf) : Conf := Finsupp.update α j (α j + 1)

/-- Remove one quantum from the mode `j` (nothing happens if the mode is
empty). -/
def dn (j : ℕ) (α : Conf) : Conf := Finsupp.update α j (α j - 1)



















/-! ## Annihilation and creation at the algebraic level -/

/-- **The annihilation operator of the mode `j`**: on a configuration state,
`a_j |β⟩ = √(β_j) |β − e_j⟩`. -/
def annA (j : ℕ) : FockAlg →ₗ[ℂ] FockAlg :=
  Finsupp.lsum ℂ fun β => LinearMap.toSpanSingleton ℂ FockAlg
    (Finsupp.single (dn j β) ((Real.sqrt (β j) : ℝ) : ℂ))

/-- **The creation operator of the mode `j`**: on a configuration state,
`a_j† |β⟩ = √(β_j + 1) |β + e_j⟩`. -/
def creA (j : ℕ) : FockAlg →ₗ[ℂ] FockAlg :=
  Finsupp.lsum ℂ fun β => LinearMap.toSpanSingleton ℂ FockAlg
    (Finsupp.single (up j β) ((Real.sqrt ((β j : ℝ) + 1) : ℝ) : ℂ))



























/-- The set of modes excited by a state of the algebraic Fock space. -/
def modes (u : FockAlg) : Finset ℕ := u.support.biUnion Finsupp.support





/-! ## Transport to `ℓ²(Conf)` -/

/-- A finitely supported configuration vector as an element of `ℓ²(Conf)`. -/
def toLp (u : FockAlg) : Fock :=
  ⟨fun α => u α, memLpTwo_of_finite_support u.finite_support⟩



/-- The transport map is linear. -/
def toLpL : FockAlg →ₗ[ℂ] Fock where
  toFun := toLp
  map_add' u v := by
    refine lp.ext (funext fun α => ?_)
    simp [toLp]
    rfl
  map_smul' c u := by
    refine lp.ext (funext fun α => ?_)
    simp u _support

theorem toLp_injective : Function.Injective toLp := by
  intro u v h
  refine Finsupp.ext fun α => ?_
  have := congrArg (fun f : Fock => (f : Conf → ℂ) α) h
  simpa usineref]
 at this

/-- The isomorphism of the algebraic Fock space with the finite-occupation
domain of `ℓ²(Conf)`. -/
def fockEquiv : FockAlg ≃ₗ[ℂ] lpFiniteModes Conf := by
  classical
  refine LinearEquiv.ofBijective (toLpL.codRestrict (lpFiniteModes Conf) toLp_mem) ⟨?_, ?_⟩
  · intro u v h
    exact toLp_injective (congrArg Subtype.val h)
  · rintro ⟨x, hx⟩
    refine ⟨Finsupp.onFinset hx.toFinset (fun α => (x : Conf → ℂ) α) ?_, ?_⟩
    · intro α hα
      exact hx.mem_toFinset.mpr hα
    · refine Subtype.ext (lp.ext (funext fun α => ?_))
   u m_apply]

/-! ## Second quantizatimport Mathlib

/-!
# Second quantization over a one-particle core (Part F.11)

`PLAN_LEAN_SPECIALIST_QYM_FLOW.md` Part F.11 asks for the **second-quantized**
Hamiltonian on the finite-occupation states over the one-particle core, i.e. the
last row of the field-space realization of the gauge-fixed Yang–Mills
Hamiltonian.

The Fock space over a one-particle space with a countable orthonormal basis
`(e_k)` is `ℓ²` over the *configurations* `Conf = ℕ →₀ ℕ` (occupation numbers,
finitely many excited modes), and the finite-occupation domain is the dense
subspace `lpFiniteModes Conf` of finitely supported configuration vectors.  All
operators are defined at the *algebraic* level on `FockAlg = Conf →₀ ℂ` — where
linearity is free — and transported to the Hilbert space by the isomorphism
`fockEquiv`.

* `up`, `dn` — adding and removing one quantum in a mode;
* `annA j`, `creA j` — annihilation and creation, with the canonical commutation
  relation `[a_j, a_j†] = 1` (`ccr_annA_creA`) and the adjoint pairing
  `⟪a_j† u, v⟫ = ⟪u, a_j v⟫` (`inner_creA_left`);
* `dGamma col` — the second quantization `dΓ(A) = Σ_{j,k} ⟪e_j, A e_k⟫ a_j† a_k`
  of a one-particle operator given by its (column-finite) matrix `col`, and
  `dGamma_one_particle`, which checks that on the one-particle sector it *is*
  the one-particle operator;
* `dGammaOp_symmetricOn`, `dGammaOp_quadForm_nonneg` — symmetry and positivity of
  `dΓ(A)` on the finite-occupation domain, from Hermiticity and positivity of the
  one-particle matrix;
* `dGamma_friedrichs_extension` — hence `dΓ(A)` has a positive self-adjoint
  (Friedrichs) extension;
* `secondQuantization_friedrichs` — the same for the matrix of an arbitrary
  symmetric positive one-particle operator on the finite-mode domain of a Hilbert
  basis;
* `ym_fock_friedrichs_extension` — **F.11**: the second quantization of the
  field-space Yang–Mills Hamiltonian `H₁ = ½Σπ² + ½ΣB²` of
  `BookProof.YangMillsHermite` has a positive self-adjoint extension on the Fock
  space over the Gauss–polynomial core of `L²(ℝ⁹⁹)`;
* `dGamma_hashimoto_selects`, `secondQuantization_hashimoto_selects` and
  `ym_fock_hashimoto_selects` — the Hashimoto/SIRK shift-invert limit selects
  exactly that Friedrichs extension, with the Galerkin truncations of the
  shift-inverted operator converging strongly and in the resolvent sense.

No mass gap and no global existence is claimed; the Millennium problem stays out
of scope.
-/

namespace BookProof.FockSecondQuantization

open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

/-! ## Configurations -/

/-- A **configuration**: the occupation numbers of the one-particle modes, all
but finitely many of them zero. -/
abbrev Conf := ℕ →₀ ℕ

/-- The **algebraic Fock space**: finite linear combinations of configurations. -/
abbrev FockAlg := Conf →₀ ℂ

/-- The **Fock space** `ℓ²(Conf)`. -/
abbrev Fock := L2I Conf

/-- Add one quantum in the mode `j`. -/
def up (j : ℕ) (α : Conf) : Conf := Finsupp.update α j (α j + 1)

/-- Remove one quantum from the mode `j` (nothing happens if the mode is
empty). -/
def dn (j : ℕ) (α : Conf) : Conf := Finsupp.update α j (α j - 1)

@[simp] theorem up_self (j : ℕ) (α : Conf) : up j α j = α j + 1 := by
  simp [up]

theorem up_of_ne {i j : ℕ} (α : Conf) (h : i ≠ j) : up j α i = α i := by
  simp [up, Finsupp.update_apply, h]

@[simp] theorem dn_self (j : ℕ) (α : Conf) : dn j α j = α j - 1 := by
  simp [dn]

theorem dn_of_ne {i j : ℕ} (α : Conf) (h : i ≠ j) : dn j α i = α i := by
  simp [dn, Finsupp.update_apply, h]

@[simp] theorem dn_up (j : ℕ) (α : Conf) : dn j (up j α) = α := by
  refine Finsupp.ext fun i => ?_
  by_cases h : i = j
  · subst h; simp
  · rw [dn_of_ne _ h, up_of_ne _ h]

theorem up_dn (j : ℕ) {α : Conf} (h : 1 ≤ α j) : up j (dn j α) = α := by
  refine Finsupp.ext fun i => ?_
  by_cases hi : i = j
  · subst hi; simp; omega
  · rw [up_of_ne _ hi, dn_of_ne _ hi]

theorem up_injective (j : ℕ) : Function.Injective (up j) := by
  intro α β h
  have := congrArg (dn j) h
  simpa using this

theorem support_up (j : ℕ) (α : Conf) : (up j α).support ⊆ insert j α.support := by
  intro i hi
  by_cases h : i = j
  · simp [h]
  · have : α i ≠ 0 := by
      have := Finsupp.mem_support_iff.mp hi
      rwa [up_of_ne _ h] at this
    exact Finset.mem_insert_of_mem (Finsupp.mem_support_iff.mpr this)

theorem support_dn (j : ℕ) (α : Conf) : (dn j α).support ⊆ α.support := by
  intro i hi
  have hi' := Finsupp.mem_support_iff.mp hi
  by_cases h : i = j
  · subst h
    rw [dn_self] at hi'
    exact Finsupp.mem_support_iff.mpr (by omega)
  · rw [dn_of_ne _ h] at hi'
    exact Finsupp.mem_support_iff.mpr hi'

/-! ## Annihilation and creation at the algebraic level -/

/-- **The annihilation operator of the mode `j`**: on a configuration state,
`a_j |β⟩ = √(β_j) |β − e_j⟩`. -/
def annA (j : ℕ) : FockAlg →ₗ[ℂ] FockAlg :=
  Finsupp.lsum ℂ fun β => LinearMap.toSpanSingleton ℂ FockAlg
    (Finsupp.single (dn j β) ((Real.sqrt (β j) : ℝ) : ℂ))

/-- **The creation operator of the mode `j`**: on a configuration state,
`a_j† |β⟩ = √(β_j + 1) |β + e_j⟩`. -/
def creA (j : ℕ) : FockAlg →ₗ[ℂ] FockAlg :=
  Finsupp.lsum ℂ fun β => LinearMap.toSpanSingleton ℂ FockAlg
    (Finsupp.single (up j β) ((Real.sqrt ((β j : ℝ) + 1) : ℝ) : ℂ))

@[simp] theorem annA_single (j : ℕ) (β : Conf) (c : ℂ) :
    annA j (Finsupp.single β c) = c • Finsupp.single (dn j β) ((Real.sqrt (β j) : ℝ) : ℂ) := by
  simp [annA, LinearMap.toSpanSingleton]

@[simp] theorem creA_single (j : ℕ) (β : Conf) (c : ℂ) :
    creA j (Finsupp.single β c)
      = c • Finsupp.single (up j β) ((Real.sqrt ((β j : ℝ) + 1) : ℝ) : ℂ) := by
  simp [creA, LinearMap.toSpanSingleton]

/-- The coordinates of `a_j u`. -/
theorem annA_apply (j : ℕ) (u : FockAlg) (α : Conf) :
    annA j u α = ((Real.sqrt ((α j : ℝ) + 1) : ℝ) : ℂ) * u (up j α) := by
  induction u using Finsupp.induction_linear with
  | zero => simp
  | add f g hf hg => simp [hf, hg]; ring
  | single β c =>
    rw [annA_single]
    by_cases hb : β = up j α
    · subst hb
      simp [mul_comm]
    · have h1 : (Finsupp.single β c : FockAlg) (up j α) = 0 := by
        simp [Ne.symm hb]
      rw [h1, mul_zero]
      by_cases hj : β j = 0
      · simp [hj]
      · have hne : dn j β ≠ α := by
          intro hc
          exact hb (by rw [← hc, up_dn j (by omega)])
        simp [hne]

/-- The coordinates of `a_j† u`. -/
theorem creA_apply (j : ℕ) (u : FockAlg) (α : Conf) :
    creA j u α = ((Real.sqrt (α j) : ℝ) : ℂ) * u (dn j α) := by
  induction u using Finsupp.induction_linear with
  | zero => simp
  | add f g hf hg => simp [hf, hg]; ring
  | single β c =>
    rw [creA_single]
    by_cases hb : β = dn j α
    · subst hb
      by_cases hj : 1 ≤ α j
      · rw [up_dn j hj]
        have hcast : ((α j - 1 : ℕ) : ℝ) + 1 = (α j : ℝ) := by
          rw [Nat.cast_sub (R := ℝ) hj]; ring
        simp only [dn_self, hcast, Finsupp.smul_apply, Finsupp.single_eq_same, smul_eq_mul]
        rw [mul_comm]
      · have h0 : α j = 0 := by omega
        have hne : up j (dn j α) ≠ α := by
          intro hc
          have := congrArg (fun f : Conf => f j) hc
          simp at this
          omega
        simp [hne, h0]
    · have h1 : (Finsupp.single β c : FockAlg) (dn j α) = 0 := by
        simp [Ne.symm hb]
      rw [h1, mul_zero]
      have hne : up j β ≠ α := by
        intro hc
        exact hb (by rw [← hc, dn_up])
      simp [hne]

/-- **The canonical commutation relation** `[a_j, a_j†] = 1`. -/
theorem ccr_annA_creA (j : ℕ) (u : FockAlg) : annA j (creA j u) - creA j (annA j u) = u := by
  refine Finsupp.ext fun α => ?_
  rw [Finsupp.sub_apply, annA_apply, creA_apply, creA_apply, annA_apply, up_self, dn_up]
  by_cases hj : 1 ≤ α j
  · have hcast : ((dn j α) j : ℝ) + 1 = (α j : ℝ) := by
      rw [dn_self, Nat.cast_sub (R := ℝ) hj]; ring
    rw [hcast, up_dn j hj]
    push_cast
    have h1 : ((Real.sqrt ((α j : ℝ) + 1) : ℝ) : ℂ) * ((Real.sqrt ((α j : ℝ) + 1) : ℝ) : ℂ)
        = ((α j : ℝ) : ℂ) + 1 := by
      rw [← Complex.ofReal_mul, Real.mul_self_sqrt (by positivity)]
      push_cast
      ring
    have h2 : ((Real.sqrt ((α j : ℝ)) : ℝ) : ℂ) * ((Real.sqrt ((α j : ℝ)) : ℝ) : ℂ)
        = ((α j : ℝ) : ℂ) := by
      rw [← Complex.ofReal_mul, Real.mul_self_sqrt (by positivity)]
    linear_combination (u α) * h1 - (u α) * h2
  · have h0 : α j = 0 := by omega
    rw [h0]
    norm_num

/-- Adding a quantum in one mode and removing one from a *different* mode are
independent operations. -/
theorem up_dn_comm {j k : ℕ} (h : j ≠ k) (α : Conf) : dn k (up j α) = up j (dn k α) := by
  refine Finsupp.ext fun i => ?_
  by_cases hik : i = k
  · subst hik
    rw [dn_self, up_of_ne _ h.symm, up_of_ne _ h.symm, dn_self]
  · by_cases hij : i = j
    · subst hij
      rw [dn_of_ne _ hik, up_self, up_self, dn_of_ne _ hik]
    · rw [dn_of_ne _ hik, up_of_ne _ hij, up_of_ne _ hij, dn_of_ne _ hik]

/-- Removals in two modes commute. -/
theorem dn_dn_comm (j k : ℕ) (α : Conf) : dn k (dn j α) = dn j (dn k α) := by
  rcases eq_or_ne j k with rfl | h
  · rfl
  refine Finsupp.ext fun i => ?_
  by_cases hik : i = k
  · subst hik
    rw [dn_self, dn_of_ne _ h.symm, dn_of_ne _ h.symm, dn_self]
  · by_cases hij : i = j
    · subst hij
      rw [dn_of_ne _ hik, dn_self, dn_self, dn_of_ne _ hik]
    · rw [dn_of_ne _ hik, dn_of_ne _ hij, dn_of_ne _ hij, dn_of_ne _ hik]

/-- Additions in two modes commute. -/
theorem up_up_comm (j k : ℕ) (α : Conf) : up k (up j α) = up j (up k α) := by
  rcases eq_or_ne j k with rfl | h
  · rfl
  refine Finsupp.ext fun i => ?_
  by_cases hik : i = k
  · subst hik
    rw [up_self, up_of_ne _ h.symm, up_of_ne _ h.symm, up_self]
  · by_cases hij : i = j
    · subst hij
      rw [up_of_ne _ hik, up_self, up_self, up_of_ne _ hik]
    · rw [up_of_ne _ hik, up_of_ne _ hij, up_of_ne _ hij, up_of_ne _ hik]

/-- **The off-diagonal canonical commutation relation** `[a_j, a_k†] = 0` for
`j ≠ k`. -/
theorem ccr_annA_creA_of_ne {j k : ℕ} (h : j ≠ k) (u : FockAlg) :
    annA j (creA k u) = creA k (annA j u) := by
  refine Finsupp.ext fun α => ?_
  rw [annA_apply, creA_apply, creA_apply, annA_apply, up_of_ne _ h.symm, dn_of_ne _ h,
    up_dn_comm h]
  ring

/-- **The canonical commutation relation** `[a_j, a_k] = 0`. -/
theorem ccr_annA_annA (j k : ℕ) (u : FockAlg) : annA j (annA k u) = annA k (annA j u) := by
  refine Finsupp.ext fun α => ?_
  rcases eq_or_ne j k with rfl | h
  · rfl
  rw [annA_apply, annA_apply, annA_apply, annA_apply, up_of_ne _ h.symm, up_of_ne _ h,
    up_up_comm]
  ring

/-- **The canonical commutation relation** `[a_j†, a_k†] = 0`. -/
theorem ccr_creA_creA (j k : ℕ) (u : FockAlg) : creA j (creA k u) = creA k (creA j u) := by
  refine Finsupp.ext fun α => ?_
  rcases eq_or_ne j k with rfl | h
  · rfl
  rw [creA_apply, creA_apply, creA_apply, creA_apply, dn_of_ne _ h.symm, dn_of_ne _ h,
    dn_dn_comm]
  ring

theorem support_annA (j : ℕ) (u : FockAlg) : (annA j u).support ⊆ u.support.image (dn j) := by
  intro α hα
  have hα' := Finsupp.mem_support_iff.mp hα
  rw [annA_apply] at hα'
  have hu : u (up j α) ≠ 0 := fun h => hα' (by rw [h, mul_zero])
  exact Finset.mem_image.mpr ⟨up j α, Finsupp.mem_support_iff.mpr hu, by simp⟩

theorem support_creA (j : ℕ) (u : FockAlg) : (creA j u).support ⊆ u.support.image (up j) := by
  intro α hα
  have hα' := Finsupp.mem_support_iff.mp hα
  rw [creA_apply] at hα'
  have hu : u (dn j α) ≠ 0 := fun h => hα' (by rw [h, mul_zero])
  have hj : 1 ≤ α j := by
    by_contra hc
    have h0 : α j = 0 := by omega
    exact hα' (by rw [h0]; norm_num)
  exact Finset.mem_image.mpr ⟨dn j α, Finsupp.mem_support_iff.mpr hu, up_dn j hj⟩

/-- The set of modes excited by a state of the algebraic Fock space. -/
def modes (u : FockAlg) : Finset ℕ := u.support.biUnion Finsupp.support

theorem support_subset_modes {u : FockAlg} {β : Conf} (h : β ∈ u.support) :
    β.support ⊆ modes u := fun _ hi => Finset.mem_biUnion.mpr ⟨β, h, hi⟩

/-- A mode that is not excited by `u` is annihilated by `a_k`. -/
theorem annA_eq_zero_of_not_mem_modes {u : FockAlg} {k : ℕ} (h : k ∉ modes u) :
    annA k u = 0 := by
  refine Finsupp.ext fun α => ?_
  rw [annA_apply, Finsupp.zero_apply]
  have hu : u (up k α) = 0 := by
    by_contra hc
    refine h (support_subset_modes (Finsupp.mem_support_iff.mpr hc) ?_)
    exact Finsupp.mem_support_iff.mpr (by rw [up_self]; omega)
  rw [hu, mul_zero]

/-! ## Transport to `ℓ²(Conf)` -/

/-- A finitely supported configuration vector as an element of `ℓ²(Conf)`. -/
def toLp (u : FockAlg) : Fock :=
  ⟨fun α => u α, memLpTwo_of_finite_support u.finite_support⟩

@[simp] theorem toLp_apply (u : FockAlg) (α : Conf) : ((toLp u : Fock) : Conf → ℂ) α = u α := rfl

/-- The transport map is linear. -/
def toLpL : FockAlg →ₗ[ℂ] Fock where
  toFun := toLp
  map_add' u v := by
    refine lp.ext (funext fun α => ?_)
    simp [toLp]
    rfl
  map_smul' c u := by
    refine lp.ext (funext fun α => ?_)
    simp [toLp]

@[simp] theorem toLpL_apply (u : FockAlg) : toLpL u = toLp u := rfl

theorem toLp_mem (u : FockAlg) : toLp u ∈ lpFiniteModes Conf := u.finite_support

theorem toLp_injective : Function.Injective toLp := by
  intro u v h
  refine Finsupp.ext fun α => ?_
  have := congrArg (fun f : Fock => (f : Conf → ℂ) α) h
  simpa using this

/-- **The inner product of two finitely supported configuration vectors** is the
finite sum of the products of their coordinates. -/
theorem inner_toLp_of_subset {u : FockAlg} {s : Finset Conf} (hs : u.support ⊆ s)
    (v : FockAlg) :
    (inner ℂ (toLp u) (toLp v) : ℂ) = ∑ α ∈ s, (starRingEnd ℂ) (u α) * v α := by
  rw [lp.inner_eq_tsum]
  have hcoord : ∀ α : Conf,
      (inner ℂ (((toLp u : Fock) : Conf → ℂ) α) (((toLp v : Fock) : Conf → ℂ) α) : ℂ)
        = (starRingEnd ℂ) (u α) * v α := by
    intro α
    simp [RCLike.inner_apply, mul_comm]
  rw [tsum_congr hcoord]
  refine tsum_eq_sum fun α hα => ?_
  have hu : u α = 0 := by
    by_contra hc
    exact hα (hs (Finsupp.mem_support_iff.mpr hc))
  rw [hu, map_zero, zero_mul]

theorem inner_toLp (u v : FockAlg) :
    (inner ℂ (toLp u) (toLp v) : ℂ) = ∑ α ∈ u.support, (starRingEnd ℂ) (u α) * v α :=
  inner_toLp_of_subset (Finset.Subset.refl _) v

/-- **The adjoint pairing of creation and annihilation**: `⟪a_j† u, v⟫ = ⟪u, a_j v⟫`. -/
theorem inner_creA_left (j : ℕ) (u v : FockAlg) :
    (inner ℂ (toLp (creA j u)) (toLp v) : ℂ) = inner ℂ (toLp u) (toLp (annA j v)) := by
  rw [inner_toLp_of_subset (support_creA j u) v, inner_toLp u (annA j v),
    Finset.sum_image (fun x _ y _ h => up_injective j h)]
  refine Finset.sum_congr rfl fun β _ => ?_
  rw [creA_apply, up_self, dn_up, annA_apply]
  have hcast : ((β j + 1 : ℕ) : ℝ) = ((β j : ℝ) + 1) := by push_cast; ring
  rw [hcast, map_mul, Complex.conj_ofReal]
  ring

/-- The mirror image of `inner_creA_left`: `⟪u, a_j† v⟫ = ⟪a_j u, v⟫`. -/
theorem inner_creA_right (j : ℕ) (u v : FockAlg) :
    (inner ℂ (toLp u) (toLp (creA j v)) : ℂ) = inner ℂ (toLp (annA j u)) (toLp v) := by
  have h := inner_creA_left j v u
  have := congrArg (starRingEnd ℂ) h
  rwa [inner_conj_symm, inner_conj_symm] at this

/-- The isomorphism of the algebraic Fock space with the finite-occupation
domain of `ℓ²(Conf)`. -/
def fockEquiv : FockAlg ≃ₗ[ℂ] lpFiniteModes Conf := by
  classical
  refine LinearEquiv.ofBijective (toLpL.codRestrict (lpFiniteModes Conf) toLp_mem) ⟨?_, ?_⟩
  · intro u v h
    exact toLp_injective (congrArg Subtype.val h)
  · rintro ⟨x, hx⟩
    refine ⟨Finsupp.onFinset hx.toFinset (fun α => (x : Conf → ℂ) α) ?_, ?_⟩
    · intro α hα
      exact hx.mem_toFinset.mpr hα
    · refine Subtype.ext (lp.ext (funext fun α => ?_))
      rfl

@[simp] theorem coe_fockEquiv (u : FockAlg) : ((fockEquiv u : lpFiniteModes Conf) : Fock)
    = toLp u := rfl

theorem coe_fockEquiv_symm (x : lpFiniteModes Conf) :
    ((x : lpFiniteModes Conf) : Fock) = toLp (fockEquiv.symm x) := by
  rw [← coe_fockEquiv, LinearEquiv.apply_symm_apply]

/-! ## Second quantization -/

/-- The creation operator of a finitely supported one-particle vector
`v = Σ_j v_j e_j`: `a†(v) = Σ_j v_j a_j†`. -/
def creVec (v : ℕ →₀ ℂ) : FockAlg →ₗ[ℂ] FockAlg := ∑ j ∈ v.support, (v j) • creA j

/-- **The second quantization** `dΓ(A) = Σ_k a†(A e_k) a_k` of the one-particle
operator whose `k`-th column of matrix elements is `col k` (so
`(col k) j = ⟪e_j, A e_k⟫`). -/
def dGamma (col : ℕ → (ℕ →₀ ℂ)) : FockAlg →ₗ[ℂ] FockAlg :=
  Finsupp.lsum ℂ fun β => LinearMap.toSpanSingleton ℂ FockAlg
    (∑ k ∈ β.support, creVec (col k) (annA k (Finsupp.singlem_ngapapl ]
  simp

/-! ### Symmetry and positivity -/

/-- The matrix is **Hermitian**: `⟪e_j, A e_k⟫ = conj ⟪e_k, A e_j⟫`. -/
def IsHermCol (col : ℕ → (ℕ →₀ ℂ)) : Prop :=
  ∀ j k, (col j) k = (starRingEnd ℂ) ((col k) j)

/-- The matrix is **positive semidefinite** on every finite set of modes. -/
def IsPosCol (col : ℕ → (ℕ →₀ ℂ)) : Prop :=
  ∀ (S : Finset ℕ) (c : ℕ → ℂ),
    0 ≤ (∑ j ∈ S, ∑ k ∈ S, (starRingEnd ℂ) (c j) * (col k) j * croeAA_      simp

/-- A finite set of modes large enough for both states and for the columns of
the one-particle matrix over their modes. -/
def closureModes (col : ℕ → (ℕ →₀ ℂ)) (u v : FockAlg) : Finset ℕ :=
  (modes u ∪ modes v) ∪ (modes u ∪ modes v).biUnion fun k => (col k).sftht, nj k u) α

/-! ### The second-quantized operator on the finite-occupation domain -/

/-- **The second-quantized operator** on the finite-occupation domain of the Fock
space. -/
def dGammaOp (col : ℕ → (ℕ →₀ ℂ)) : lpFiniteModes Conf →ₗ[ℂ] Fock :=
  (lpFiniteModes Conf).subtype.comp (fockEquiv.conj (dGammackheg eson_dense

/-! ## The matrix of a one-particle operator -/

section OneParticle

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

/-- The coordinates of a finite-mode vector, as a finitely supported function. -/
def coordFinsupp (b : HilbertBasis ℕ ℂ F) (x : F) : ℕ →₀ ℂ := by
  classical
  exact if h : x ∈ finiteModeDomain b then
    (Finsupp.mem_span_range_iff_exists_finsupp.mp h).choose finsupp]

/-- The matrix of a one-particle operator in the basis `b`. -/
def opCol (b : HilbertBasis ℕ ℂ F) (A : finiteModeDomain b →ₗ[ℂ] finiteModeDomain b)
    (k : ℕ) : ℕ →₀ ℂ :=
  coordFinsupp b (A ⟨b k, Submodule.subset_span ⟨k, rfl⟩⟩ : finiteModeDomn njexol hpos)

end OneParticle

/-! ## The Hashimoto/SIRK selection for the second-quantized operator -/

section Selection

open Filter Topology

/-- The canonical Hilbert basis of the Fock space, indexed by the
configurations. -/
def fockConfBasis : HilbertBasis Conf ℂ Fock :=
  HilbertBasis.ofRepr (LinearIsometryEquiv.refl ℂ _)

theorem fockConfBasis_apply (α : Conf) : fockConfBasis α = lp.single 2 α (1 : ℂ) := by
  rw [← HilbertBasis.repr_symm_single]
  rfl

/-- The Fock basis re-indexed by `ℕ`, the form in which the abstract Friedrichs
and Hashimoto theorems are stated. -/
def fockBasisN (ε : ℕ ≃ Conf) : HilbertBasis ℕ ℂ Fock :=
  HilbertBasis.mk (fockConfBasis.orthonormal.comp _ ε.injective)
    (by
      have h := fockConfBasis.dense_span
      rw [Set.range_comp, ε.range_eq_univ, Set.image_univ]
      exact h.ge)

theorem fockBasisN_apply (ε : ℕ ≃ Conf) (n : ℕ) :
    fockBasisN ε n = lp.single 2 (ε n) (1 : ℂ) := by
  rw [fockBasisN, HilbertBasis.coe_mk]
  exact fockConfBasis_apply _

theorem lp_sum_single_coord (S : Finset Conf) (f : Conf → ℂ) (β : Conf) :
    (((∑ α ∈ S, f α • lp.single 2 α (1 : ℂ)) : Fock) : Conf → ℂ) β
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

/-- **The finite-mode domain of the Fock basis is exactly the finite-occupation
domain**, so the abstract theorems apply verbatim to `dΓ`. -/
theorem finiteModeDomain_fockBasisN (ε : ℕ ≃ Conf) :
    finiteModeDomain (fockBasisN ε) = lpFiniteModes Conf := by
  classical
  refine le_antisymm (Submodule.span_le.mpr ?_) fun x hx => ?_
  · rintro y ⟨n, rfl⟩
    rw [fockBasisN_apply]
    exact lpSingle_mem_lpFiniteModes _ _
  · set S : Finset Conf := hx.toFinset with hS
    have hxeq : x = ∑ α ∈ S, ((x : Conf → ℂ) α) • lp.single 2 α (1 : ℂ) := by
      refine lp.ext (funext fun β => ?_)
      rw [lp_sum_single_coord]
      by_cases hb : β ∈ S
      · simp [hb]
      · have hz : (x : Conf → ℂ) β = 0 := by
          by_contra hc
          exact hb (hx.mem_toFinset.mpr hc)
        simp [hb, hz]
    rw [hxeq]
    refine Submodule.sum_mem _ fun α _ => Submodule.smul_mem _ _ ?_
    refine Submodule.subset_span ⟨ε.symm α, ?_⟩
    rw [fockBasisN_apply, Equiv.apply_symm_apply]

/-- The second-quantized operator on the finite-mode domain of `fockBasisN ε`
(the same subspace as `lpFiniteModes Conf`). -/
def dGammaOpB (ε : ℕ ≃ Conf) (col : ℕ → (ℕ →₀ ℂ)) :
    finiteModeDomain (fockBasisN ε) →ₗ[ℂ] Fock :=
  (dGammaOp col).comp (LinearEquiv.ofEq _ _ (finiteModeDomain_fockBasisN ε)).toLinN N pos) hγ

/-- A concrete enumeration of the configurations, so that the selection theorem
is not vacuous. -/
def fockEnum : ℕ ≃ Conf :=
  letI : Denumerable Conf := Denumerable.ofEncodableOfInfinite _
  (Denumerable.eqv Confpos) hγ

end Selection

/-! ## The second-quantized Yang–Mills Hamiltonian (F.11) -/

section YangMills

open BookProof.YangMillsHermite BookProof.HermiteProductCore
open Filter Topology

/-- The inner one-particle Yang–Mills Hamiltonian `H₁ = ½Σπ² + ½ΣB²` as an
endomorphism of the Gauss–polynomial core. The full final nested-Fock
Hamiltonian is its outer creation-left/annihilation-right enclosure; inner
pair terms are retained in `H₁`, and the outer annihilator kills the outer
vacuum.  The operator is realized as the finite-mode domain of
the orthonormal basis `coreBasis e` of `L²(ℝ⁹⁹)`. -/
def ymOnePart (e : ℕ ≃ (Fin 99 →₀ ℕ)) (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) :
    finiteModeDomain (coreBasis e) →ₗ[ℂ] finiteModeDomain (coreBasis e) :=
  weylOpDom (piOps (coreRepBasis e)) (magOps (coreRepBasis e)x := rfl

/-- The matrix of the one-particle Yang–Mills Hamiltonian in the product Hermite
basis. -/
def ymFockCol (e : ℕ ≃ (Fin 99 →₀ ℕ)) (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) : ℕ → (ℕ →₀ ℂ) :=
  opCol (coreBasis e) (ymOnePart e _e)abc) hγ

end YangMills

end

end BookProof.FockSecondQuantization
