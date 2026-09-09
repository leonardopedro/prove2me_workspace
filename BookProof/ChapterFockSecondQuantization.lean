import Mathlib
import BookProof.ChapterNavierStokesEsa
import BookProof.ChapterNavierStokesIkebeKato
import BookProof.ChapterFriedrichsExtension
import BookProof.ChapterYangMillsHermite

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
    (∑ k ∈ β.support, creVec (col k) (annA k (Finsupp.single β 1)))

/-- On a state exciting only modes in `K`, the second quantization is the finite
sum `Σ_{k ∈ K} a†(A e_k) a_k`. -/
theorem creVec_apply (v : ℕ →₀ ℂ) (x : FockAlg) :
    creVec v x = ∑ j ∈ v.support, v j • creA j x := by
  simp [creVec, LinearMap.sum_apply]

@[simp] theorem dGamma_single (col : ℕ → (ℕ →₀ ℂ)) (β : Conf) (c : ℂ) :
    dGamma col (Finsupp.single β c)
      = c • ∑ k ∈ β.support, creVec (col k) (annA k (Finsupp.single β 1)) := by
  simp [dGamma, LinearMap.toSpanSingleton]

/-- Enlarging the index set beyond the excited modes does not change the sum. -/
theorem sum_creVec_annA_subset (col : ℕ → (ℕ →₀ ℂ)) (u : FockAlg) {K L : Finset ℕ}
    (hKL : K ⊆ L) (hK : modes u ⊆ K) :
    ∑ k ∈ K, creVec (col k) (annA k u) = ∑ k ∈ L, creVec (col k) (annA k u) :=
  Finset.sum_subset hKL fun k _ hk => by
    rw [annA_eq_zero_of_not_mem_modes (fun hc => hk (hK hc)), map_zero]

theorem dGamma_eq_sum_aux (col : ℕ → (ℕ →₀ ℂ)) (u : FockAlg) :
    ∀ K : Finset ℕ, modes u ⊆ K → dGamma col u = ∑ k ∈ K, creVec (col k) (annA k u) := by
  classical
  induction u using Finsupp.induction_linear with
  | zero => intro K _; simp
  | add f g hf hg =>
    intro K hK
    have hL1 : modes f ⊆ K ∪ (modes f ∪ modes g) := fun x hx =>
      Finset.mem_union_right _ (Finset.mem_union_left _ hx)
    have hL2 : modes g ⊆ K ∪ (modes f ∪ modes g) := fun x hx =>
      Finset.mem_union_right _ (Finset.mem_union_right _ hx)
    have hKL : K ⊆ K ∪ (modes f ∪ modes g) := Finset.subset_union_left
    rw [map_add, hf _ hL1, hg _ hL2, ← Finset.sum_add_distrib,
      sum_creVec_annA_subset col (f + g) hKL hK]
    refine Finset.sum_congr rfl fun k _ => ?_
    rw [map_add, map_add]
  | single β c =>
    intro K hK
    have hsingle : (Finsupp.single β c : FockAlg) = c • Finsupp.single β (1 : ℂ) := by
      rw [Finsupp.smul_single, smul_eq_mul, mul_one]
    by_cases hc : c = 0
    · subst hc
      simp
    have hb : β.support ⊆ K := by
      refine fun i hi => hK ?_
      exact Finset.mem_biUnion.mpr ⟨β, Finsupp.mem_support_iff.mpr (by simpa using hc), hi⟩
    have hzero : ∀ k ∈ K, k ∉ β.support →
        creVec (col k) (annA k (Finsupp.single β c)) = 0 := by
      intro k _ hk
      have hβ : β k = 0 := by simpa using hk
      have hz : annA k (Finsupp.single β c) = 0 := by
        rw [annA_single, hβ]
        simp
      rw [hz, map_zero]
    rw [← Finset.sum_subset hb hzero, dGamma_single, Finset.smul_sum]
    refine Finset.sum_congr rfl fun k _ => ?_
    rw [hsingle, map_smul, map_smul]

/-- On a state exciting only modes in `K`, the second quantization is the finite
sum `∑_{k ∈ K} a†(A e_k) a_k`. -/
theorem dGamma_eq_sum (col : ℕ → (ℕ →₀ ℂ)) {u : FockAlg} {K : Finset ℕ} (hK : modes u ⊆ K) :
    dGamma col u = ∑ k ∈ K, creVec (col k) (annA k u) :=
  dGamma_eq_sum_aux col u K hK

/-- **On the one-particle sector the second quantization is the one-particle
operator**: `dΓ(A)|e_k⟩ = Σ_j ⟪e_j, A e_k⟫ |e_j⟩`. -/
theorem dGamma_one_particle (col : ℕ → (ℕ →₀ ℂ)) (k : ℕ) :
    dGamma col (Finsupp.single (Finsupp.single k 1) 1)
      = ∑ j ∈ (col k).support, (col k) j • Finsupp.single (Finsupp.single j 1) (1 : ℂ) := by
  classical
  have hup : ∀ j : ℕ, up j (0 : Conf) = Finsupp.single j 1 := by
    intro j
    refine Finsupp.ext fun i => ?_
    by_cases h : i = j
    · subst h; simp
    · rw [up_of_ne _ h]
      simp [h]
  have hsupp : (Finsupp.single k 1 : Conf).support = {k} :=
    Finsupp.support_single_ne_zero k one_ne_zero
  have hdn : dn k (Finsupp.single k 1 : Conf) = 0 := by
    refine Finsupp.ext fun i => ?_
    by_cases h : i = k
    · subst h; simp
    · rw [dn_of_ne _ h]
      simp [h]
  rw [dGamma_single, hsupp]
  have hann : annA k (Finsupp.single (Finsupp.single k 1 : Conf) (1 : ℂ))
      = Finsupp.single (0 : Conf) (1 : ℂ) := by
    rw [annA_single, hdn]
    simp
  rw [Finset.sum_singleton, hann, one_smul, creVec_apply]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [creA_single, hup j]
  simp

/-! ### Symmetry and positivity -/

/-- The matrix is **Hermitian**: `⟪e_j, A e_k⟫ = conj ⟪e_k, A e_j⟫`. -/
def IsHermCol (col : ℕ → (ℕ →₀ ℂ)) : Prop :=
  ∀ j k, (col j) k = (starRingEnd ℂ) ((col k) j)

/-- The matrix is **positive semidefinite** on every finite set of modes. -/
def IsPosCol (col : ℕ → (ℕ →₀ ℂ)) : Prop :=
  ∀ (S : Finset ℕ) (c : ℕ → ℂ),
    0 ≤ (∑ j ∈ S, ∑ k ∈ S, (starRingEnd ℂ) (c j) * (col k) j * c k).re

@[simp] theorem toLp_zero : toLp (0 : FockAlg) = 0 := map_zero toLpL

/-- One term of the double-sum expansion, on the left. -/
theorem inner_creVec_annA (col : ℕ → (ℕ →₀ ℂ)) (u v : FockAlg) (k : ℕ) {L : Finset ℕ}
    (h : (col k).support ⊆ L) :
    (inner ℂ (toLp (creVec (col k) (annA k u))) (toLp v) : ℂ)
      = ∑ j ∈ L, (starRingEnd ℂ) ((col k) j)
          * inner ℂ (toLp (annA k u)) (toLp (annA j v)) := by
  have hexp : toLp (creVec (col k) (annA k u))
      = ∑ j ∈ (col k).support, (col k) j • toLp (creA j (annA k u)) := by
    rw [creVec_apply, ← toLpL_apply, map_sum]
    exact Finset.sum_congr rfl fun j _ => by rw [map_smul, toLpL_apply]
  rw [hexp, sum_inner, ← Finset.sum_subset h (fun j _ hj => by
    rw [Finsupp.notMem_support_iff.mp hj, map_zero, zero_mul])]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [inner_smul_left, inner_creA_left]

/-- One term of the double-sum expansion, on the right. -/
theorem inner_annA_creVec (col : ℕ → (ℕ →₀ ℂ)) (u v : FockAlg) (j : ℕ) {L : Finset ℕ}
    (h : (col j).support ⊆ L) :
    (inner ℂ (toLp u) (toLp (creVec (col j) (annA j v))) : ℂ)
      = ∑ k ∈ L, (col j) k * inner ℂ (toLp (annA k u)) (toLp (annA j v)) := by
  have hexp : toLp (creVec (col j) (annA j v))
      = ∑ k ∈ (col j).support, (col j) k • toLp (creA k (annA j v)) := by
    rw [creVec_apply, ← toLpL_apply, map_sum]
    exact Finset.sum_congr rfl fun k _ => by rw [map_smul, toLpL_apply]
  rw [hexp, inner_sum, ← Finset.sum_subset h (fun k _ hk => by
    rw [Finsupp.notMem_support_iff.mp hk, zero_mul])]
  refine Finset.sum_congr rfl fun k _ => ?_
  rw [inner_smul_right, inner_creA_right]

/-- The double-sum expansion of the second-quantized sesquilinear form. -/
theorem inner_dGamma_left (col : ℕ → (ℕ →₀ ℂ)) (u v : FockAlg) {L : Finset ℕ}
    (hu : modes u ⊆ L)
    (hL : ∀ k ∈ modes u ∪ modes v, (col k).support ⊆ L) :
    (inner ℂ (toLp (dGamma col u)) (toLp v) : ℂ)
      = ∑ k ∈ L, ∑ j ∈ L,
        (starRingEnd ℂ) ((col k) j) * inner ℂ (toLp (annA k u)) (toLp (annA j v)) := by
  have hsum : toLp (dGamma col u) = ∑ k ∈ L, toLp (creVec (col k) (annA k u)) := by
    rw [dGamma_eq_sum col hu, ← toLpL_apply, map_sum]
    rfl
  rw [hsum, sum_inner]
  refine Finset.sum_congr rfl fun k _ => ?_
  by_cases hku : k ∈ modes u
  · exact inner_creVec_annA col u v k (hL k (Finset.mem_union_left _ hku))
  · have h0 : annA k u = 0 := annA_eq_zero_of_not_mem_modes hku
    rw [h0, map_zero]
    simp

theorem inner_dGamma_right (col : ℕ → (ℕ →₀ ℂ)) (u v : FockAlg) {L : Finset ℕ}
    (hv : modes v ⊆ L)
    (hL : ∀ k ∈ modes u ∪ modes v, (col k).support ⊆ L) :
    (inner ℂ (toLp u) (toLp (dGamma col v)) : ℂ)
      = ∑ j ∈ L, ∑ k ∈ L,
        (col j) k * inner ℂ (toLp (annA k u)) (toLp (annA j v)) := by
  have hsum : toLp (dGamma col v) = ∑ j ∈ L, toLp (creVec (col j) (annA j v)) := by
    rw [dGamma_eq_sum col hv, ← toLpL_apply, map_sum]
    rfl
  rw [hsum, inner_sum]
  refine Finset.sum_congr rfl fun j _ => ?_
  by_cases hjv : j ∈ modes v
  · exact inner_annA_creVec col u v j (hL j (Finset.mem_union_right _ hjv))
  · have h0 : annA j v = 0 := annA_eq_zero_of_not_mem_modes hjv
    rw [h0, map_zero]
    simp

/-- A finite set of modes large enough for both states and for the columns of
the one-particle matrix over their modes. -/
def closureModes (col : ℕ → (ℕ →₀ ℂ)) (u v : FockAlg) : Finset ℕ :=
  (modes u ∪ modes v) ∪ (modes u ∪ modes v).biUnion fun k => (col k).support

theorem modes_left_subset_closure (col : ℕ → (ℕ →₀ ℂ)) (u v : FockAlg) :
    modes u ⊆ closureModes col u v := fun _ hx =>
  Finset.mem_union_left _ (Finset.mem_union_left _ hx)

theorem modes_right_subset_closure (col : ℕ → (ℕ →₀ ℂ)) (u v : FockAlg) :
    modes v ⊆ closureModes col u v := fun _ hx =>
  Finset.mem_union_left _ (Finset.mem_union_right _ hx)

theorem col_support_subset_closure (col : ℕ → (ℕ →₀ ℂ)) (u v : FockAlg) :
    ∀ k ∈ modes u ∪ modes v, (col k).support ⊆ closureModes col u v := by
  intro k hk i hi
  exact Finset.mem_union_right _ (Finset.mem_biUnion.mpr ⟨k, hk, hi⟩)

/-- **The second quantization of a Hermitian one-particle matrix is symmetric.** -/
theorem inner_dGamma_symm {col : ℕ → (ℕ →₀ ℂ)} (hherm : IsHermCol col) (u v : FockAlg) :
    (inner ℂ (toLp (dGamma col u)) (toLp v) : ℂ) = inner ℂ (toLp u) (toLp (dGamma col v)) := by
  rw [inner_dGamma_left col u v (modes_left_subset_closure col u v)
      (col_support_subset_closure col u v),
    inner_dGamma_right col u v (modes_right_subset_closure col u v)
      (col_support_subset_closure col u v),
    Finset.sum_comm]
  refine Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun j _ => ?_
  rw [hherm j k, Complex.conj_conj]

/-- **The second quantization of a positive one-particle matrix is positive.** -/
theorem inner_dGamma_nonneg {col : ℕ → (ℕ →₀ ℂ)} (hpos : IsPosCol col) (u : FockAlg) :
    0 ≤ (inner ℂ (toLp u) (toLp (dGamma col u)) : ℂ).re := by
  classical
  set L := closureModes col u u with hLdef
  set S : Finset Conf := L.biUnion fun k => (annA k u).support with hSdef
  rw [inner_dGamma_right col u u (modes_right_subset_closure col u u)
    (col_support_subset_closure col u u)]
  have hinner : ∀ k ∈ L, ∀ j : ℕ,
      (inner ℂ (toLp (annA k u)) (toLp (annA j u)) : ℂ)
        = ∑ α ∈ S, (starRingEnd ℂ) ((annA k u) α) * (annA j u) α := by
    intro k hk j
    exact inner_toLp_of_subset (fun α hα => Finset.mem_biUnion.mpr ⟨k, hk, hα⟩) _
  have hstep : (∑ j ∈ L, ∑ k ∈ L, (col j) k * inner ℂ (toLp (annA k u)) (toLp (annA j u)))
      = ∑ α ∈ S, ∑ j ∈ L, ∑ k ∈ L,
          (starRingEnd ℂ) ((annA j u) α) * (col k) j * ((annA k u) α) := by
    have h1 : (∑ j ∈ L, ∑ k ∈ L, (col j) k * inner ℂ (toLp (annA k u)) (toLp (annA j u)))
        = ∑ j ∈ L, ∑ k ∈ L, ∑ α ∈ S,
            (col j) k * ((starRingEnd ℂ) ((annA k u) α) * (annA j u) α) := by
      refine Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun k hk => ?_
      rw [hinner k hk j, Finset.mul_sum]
    rw [h1]
    rw [Finset.sum_comm (s := L) (t := L)]
    rw [show (∑ k ∈ L, ∑ j ∈ L, ∑ α ∈ S,
          (col j) k * ((starRingEnd ℂ) ((annA k u) α) * (annA j u) α))
        = ∑ k ∈ L, ∑ α ∈ S, ∑ j ∈ L,
          (col j) k * ((starRingEnd ℂ) ((annA k u) α) * (annA j u) α) from
      Finset.sum_congr rfl fun k _ => Finset.sum_comm]
    rw [Finset.sum_comm (s := L) (t := S)]
    refine Finset.sum_congr rfl fun α _ => ?_
    refine Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun j _ => by ring
  rw [hstep, Complex.re_sum]
  refine Finset.sum_nonneg fun α _ => hpos L fun k => (annA k u) α

/-! ### The second-quantized operator on the finite-occupation domain -/

/-- **The second-quantized operator** on the finite-occupation domain of the Fock
space. -/
def dGammaOp (col : ℕ → (ℕ →₀ ℂ)) : lpFiniteModes Conf →ₗ[ℂ] Fock :=
  (lpFiniteModes Conf).subtype.comp (fockEquiv.conj (dGamma col))

theorem coe_dGammaOp (col : ℕ → (ℕ →₀ ℂ)) (x : lpFiniteModes Conf) :
    dGammaOp col x = toLp (dGamma col (fockEquiv.symm x)) := by
  simp [dGammaOp, LinearEquiv.conj_apply, coe_fockEquiv]

theorem dGammaOp_symmetricOn {col : ℕ → (ℕ →₀ ℂ)} (hherm : IsHermCol col) :
    SymmetricOn (lpFiniteModes Conf) (dGammaOp col) := by
  intro x y
  rw [coe_dGammaOp, coe_dGammaOp, coe_fockEquiv_symm x, coe_fockEquiv_symm y]
  exact inner_dGamma_symm hherm _ _

theorem dGammaOp_quadForm_nonneg {col : ℕ → (ℕ →₀ ℂ)} (hpos : IsPosCol col)
    (x : lpFiniteModes Conf) : 0 ≤ quadForm (dGammaOp col) x := by
  rw [quadForm, coe_dGammaOp, coe_fockEquiv_symm x]
  exact inner_dGamma_nonneg hpos _

/-- The finite-occupation domain is dense in the Fock space. -/
theorem finiteOccupation_dense : Dense ((lpFiniteModes Conf : Submodule ℂ Fock) : Set Fock) :=
  lpFiniteModes_dense

/-- **The second-quantized Hamiltonian has a positive self-adjoint (Friedrichs)
extension.** -/
theorem dGamma_friedrichs_extension {col : ℕ → (ℕ →₀ ℂ)} (hherm : IsHermCol col)
    (hpos : IsPosCol col) :
    ∃ (Dom : Submodule ℂ Fock) (A : Dom →ₗ[ℂ] Fock),
      IsPositiveSelfAdjointExtension (dGammaOp col) A :=
  friedrichs_extension_exists
    ⟨lpFiniteModes Conf, dGammaOp col, dGammaOp_symmetricOn hherm,
      dGammaOp_quadForm_nonneg hpos⟩
    finiteOccupation_dense

/-! ## The matrix of a one-particle operator -/

section OneParticle

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

/-- The coordinates of a finite-mode vector, as a finitely supported function. -/
def coordFinsupp (b : HilbertBasis ℕ ℂ F) (x : F) : ℕ →₀ ℂ := by
  classical
  exact if h : x ∈ finiteModeDomain b then
    (Finsupp.mem_span_range_iff_exists_finsupp.mp h).choose else 0

theorem coordFinsupp_apply {b : HilbertBasis ℕ ℂ F} {x : F} (hx : x ∈ finiteModeDomain b)
    (j : ℕ) : coordFinsupp b x j = inner ℂ (b j) x := by
  classical
  have hx' : x ∈ Submodule.span ℂ (Set.range b) := hx
  have hspec : ((Finsupp.mem_span_range_iff_exists_finsupp.mp hx').choose.sum
      fun i a => a • b i) = x := (Finsupp.mem_span_range_iff_exists_finsupp.mp hx').choose_spec
  rw [coordFinsupp, dif_pos hx]
  conv_rhs => rw [← hspec]
  rw [← Finsupp.linearCombination_apply, b.orthonormal.inner_right_finsupp]

/-- The matrix of a one-particle operator in the basis `b`. -/
def opCol (b : HilbertBasis ℕ ℂ F) (A : finiteModeDomain b →ₗ[ℂ] finiteModeDomain b)
    (k : ℕ) : ℕ →₀ ℂ :=
  coordFinsupp b (A ⟨b k, Submodule.subset_span ⟨k, rfl⟩⟩ : finiteModeDomain b)

theorem opCol_apply (b : HilbertBasis ℕ ℂ F) (A : finiteModeDomain b →ₗ[ℂ] finiteModeDomain b)
    (k j : ℕ) :
    opCol b A k j
      = inner ℂ (b j) ((A ⟨b k, Submodule.subset_span ⟨k, rfl⟩⟩ : finiteModeDomain b) : F) :=
  coordFinsupp_apply (A ⟨b k, Submodule.subset_span ⟨k, rfl⟩⟩ : finiteModeDomain b).2 j

theorem isHermCol_opCol {b : HilbertBasis ℕ ℂ F}
    {A : finiteModeDomain b →ₗ[ℂ] finiteModeDomain b}
    (hA : SymmetricOn (finiteModeDomain b) ((finiteModeDomain b).subtype.comp A)) :
    IsHermCol (opCol b A) := by
  intro j k
  have h := hA ⟨b k, Submodule.subset_span ⟨k, rfl⟩⟩ ⟨b j, Submodule.subset_span ⟨j, rfl⟩⟩
  simp only [LinearMap.coe_comp, Function.comp_apply, Submodule.subtype_apply] at h
  rw [opCol_apply, opCol_apply, ← h, inner_conj_symm]

theorem isPosCol_opCol {b : HilbertBasis ℕ ℂ F}
    {A : finiteModeDomain b →ₗ[ℂ] finiteModeDomain b}
    (hpos : ∀ x, 0 ≤ quadForm ((finiteModeDomain b).subtype.comp A) x) :
    IsPosCol (opCol b A) := by
  intro S c
  classical
  set x : finiteModeDomain b :=
    ∑ k ∈ S, c k • (⟨b k, Submodule.subset_span ⟨k, rfl⟩⟩ : finiteModeDomain b) with hxdef
  have hxc : ((x : finiteModeDomain b) : F) = ∑ k ∈ S, c k • b k := by
    rw [hxdef, Submodule.coe_sum]
    exact Finset.sum_congr rfl fun k _ => rfl
  have hAx : ((A x : finiteModeDomain b) : F)
      = ∑ k ∈ S, c k • ((A ⟨b k, Submodule.subset_span ⟨k, rfl⟩⟩ : finiteModeDomain b) : F) := by
    rw [hxdef, map_sum, Submodule.coe_sum]
    exact Finset.sum_congr rfl fun k _ => by rw [map_smul]; rfl
  have hval : (inner ℂ ((x : finiteModeDomain b) : F)
        (((finiteModeDomain b).subtype.comp A) x) : ℂ)
      = ∑ j ∈ S, ∑ k ∈ S, (starRingEnd ℂ) (c j) * opCol b A k j * c k := by
    change (inner ℂ ((x : finiteModeDomain b) : F)
      ((A x : finiteModeDomain b) : F) : ℂ) = _
    rw [hxc, hAx, sum_inner]
    refine Finset.sum_congr rfl fun j _ => ?_
    rw [inner_smul_left, inner_sum, Finset.mul_sum]
    refine Finset.sum_congr rfl fun k _ => ?_
    rw [inner_smul_right, opCol_apply]
    ring
  have hq := hpos x
  rw [quadForm, hval] at hq
  exact hq

/-- **Second quantization of an arbitrary symmetric positive one-particle
operator**: `dΓ(A)` on the finite-occupation domain of the Fock space has a
positive self-adjoint (Friedrichs) extension. -/
theorem secondQuantization_friedrichs (b : HilbertBasis ℕ ℂ F)
    (A : finiteModeDomain b →ₗ[ℂ] finiteModeDomain b)
    (hA : SymmetricOn (finiteModeDomain b) ((finiteModeDomain b).subtype.comp A))
    (hpos : ∀ x, 0 ≤ quadForm ((finiteModeDomain b).subtype.comp A) x) :
    ∃ (Dom : Submodule ℂ Fock) (A' : Dom →ₗ[ℂ] Fock),
      IsPositiveSelfAdjointExtension (dGammaOp (opCol b A)) A' :=
  dGamma_friedrichs_extension (isHermCol_opCol hA) (isPosCol_opCol hpos)

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
  (dGammaOp col).comp (LinearEquiv.ofEq _ _ (finiteModeDomain_fockBasisN ε)).toLinearMap

theorem dGammaOpB_symmetricOn {ε : ℕ ≃ Conf} {col : ℕ → (ℕ →₀ ℂ)} (hherm : IsHermCol col) :
    SymmetricOn (finiteModeDomain (fockBasisN ε)) (dGammaOpB ε col) := by
  intro x y
  exact dGammaOp_symmetricOn hherm
    (LinearEquiv.ofEq _ _ (finiteModeDomain_fockBasisN ε) x)
    (LinearEquiv.ofEq _ _ (finiteModeDomain_fockBasisN ε) y)

theorem dGammaOpB_quadForm_nonneg {ε : ℕ ≃ Conf} {col : ℕ → (ℕ →₀ ℂ)} (hpos : IsPosCol col)
    (x : finiteModeDomain (fockBasisN ε)) : 0 ≤ quadForm (dGammaOpB ε col) x :=
  dGammaOp_quadForm_nonneg hpos
    (LinearEquiv.ofEq _ _ (finiteModeDomain_fockBasisN ε) x)

/-- **The Hashimoto/SIRK shift-invert limit selects the Friedrichs extension of
the second-quantized Hamiltonian.**  For a Hermitian, positive semidefinite,
column-finite one-particle matrix the second quantization `dΓ(A)` has a positive
self-adjoint extension `A'`, and for every shift `γ > 0` the shift-inverted
operator `R = (A' + γ)⁻¹` is bounded and self-adjoint, its Galerkin truncations
converge strongly and in the resolvent sense, and `R` determines `A'`
uniquely. -/
theorem dGamma_hashimoto_selects (ε : ℕ ≃ Conf) {col : ℕ → (ℕ →₀ ℂ)}
    (hherm : IsHermCol col) (hpos : IsPosCol col) {γ : ℝ} (hγ : 0 < γ) :
    ∃ (Dom : Submodule ℂ Fock) (A : Dom →ₗ[ℂ] Fock) (R : Fock →L[ℂ] Fock),
      IsPositiveSelfAdjointExtension (dGammaOpB ε col) A ∧ IsShiftInvert A γ R ∧
        ‖R‖ ≤ γ⁻¹ ∧ IsSelfAdjoint R ∧
        (∀ u : Fock, Tendsto (fun k : ℕ => galerkinCompression R (fockBasisN ε) k u)
          atTop (nhds (R u))) ∧
        (∀ z : ℂ, z.im ≠ 0 → ∀ u : Fock,
          Tendsto (fun k : ℕ => resolvent (galerkinCompression R (fockBasisN ε) k) z u) atTop
            (nhds (resolvent R z u))) ∧
        (∀ (Dom' : Submodule ℂ Fock) (A' : Dom' →ₗ[ℂ] Fock), IsShiftInvert A' γ R →
          Dom' = Dom ∧ ∀ (x : Fock) (hx : x ∈ Dom) (hx' : x ∈ Dom'), A' ⟨x, hx'⟩ = A ⟨x, hx⟩) :=
  friedrichs_hashimoto_selects (fockBasisN ε) (dGammaOpB ε col)
    (dGammaOpB_symmetricOn hherm) (dGammaOpB_quadForm_nonneg hpos) hγ

/-- A concrete enumeration of the configurations, so that the selection theorem
is not vacuous. -/
def fockEnum : ℕ ≃ Conf :=
  letI : Denumerable Conf := Denumerable.ofEncodableOfInfinite _
  (Denumerable.eqv Conf).symm

/-- **The Hashimoto/SIRK algorithm selects the Friedrichs extension of the second
quantization of an arbitrary symmetric positive one-particle operator.** -/
theorem secondQuantization_hashimoto_selects {F : Type*} [NormedAddCommGroup F]
    [InnerProductSpace ℂ F] (ε : ℕ ≃ Conf) (b : HilbertBasis ℕ ℂ F)
    (A : finiteModeDomain b →ₗ[ℂ] finiteModeDomain b)
    (hA : SymmetricOn (finiteModeDomain b) ((finiteModeDomain b).subtype.comp A))
    (hpos : ∀ x, 0 ≤ quadForm ((finiteModeDomain b).subtype.comp A) x)
    {γ : ℝ} (hγ : 0 < γ) :
    ∃ (Dom : Submodule ℂ Fock) (A' : Dom →ₗ[ℂ] Fock) (R : Fock →L[ℂ] Fock),
      IsPositiveSelfAdjointExtension (dGammaOpB ε (opCol b A)) A' ∧ IsShiftInvert A' γ R ∧
        ‖R‖ ≤ γ⁻¹ ∧ IsSelfAdjoint R ∧
        (∀ u : Fock, Tendsto (fun k : ℕ => galerkinCompression R (fockBasisN ε) k u)
          atTop (nhds (R u))) ∧
        (∀ z : ℂ, z.im ≠ 0 → ∀ u : Fock,
          Tendsto (fun k : ℕ => resolvent (galerkinCompression R (fockBasisN ε) k) z u) atTop
            (nhds (resolvent R z u))) ∧
        (∀ (Dom' : Submodule ℂ Fock) (A'' : Dom' →ₗ[ℂ] Fock), IsShiftInvert A'' γ R →
          Dom' = Dom ∧ ∀ (x : Fock) (hx : x ∈ Dom) (hx' : x ∈ Dom'),
            A'' ⟨x, hx'⟩ = A' ⟨x, hx⟩) :=
  dGamma_hashimoto_selects ε (isHermCol_opCol hA) (isPosCol_opCol hpos) hγ

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
  weylOpDom (piOps (coreRepBasis e)) (magOps (coreRepBasis e) fabc)

theorem coe_ymOnePart (e : ℕ ≃ (Fin 99 →₀ ℕ)) (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ)
    (x : finiteModeDomain (coreBasis e)) :
    ((ymOnePart e fabc x : finiteModeDomain (coreBasis e)) : L2d 99)
      = ymHamiltonian (coreRepBasis e) fabc x := rfl

/-- The matrix of the one-particle Yang–Mills Hamiltonian in the product Hermite
basis. -/
def ymFockCol (e : ℕ ≃ (Fin 99 →₀ ℕ)) (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) : ℕ → (ℕ →₀ ℂ) :=
  opCol (coreBasis e) (ymOnePart e fabc)

theorem ymFockCol_apply (e : ℕ ≃ (Fin 99 →₀ ℕ)) (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) (k j : ℕ) :
    ymFockCol e fabc k j
      = inner ℂ (coreBasis e j)
          (ymHamiltonian (coreRepBasis e) fabc
            ⟨coreBasis e k, Submodule.subset_span ⟨k, rfl⟩⟩) :=
  opCol_apply _ _ k j

/-- **F.11 — the second-quantized field-space Yang–Mills Hamiltonian has a
positive self-adjoint extension.**  The one-particle operator is the concrete
`H₁ = ½Σπ² + ½ΣB²` of `BookProof.YangMillsHermite` on the Gauss–polynomial core
of `L²(ℝ⁹⁹)`; its second quantization
`dΓ(H₁) = Σ_{j,k} ⟪e_j, H₁ e_k⟫ a_j† a_k` on the finite-occupation states over
that core is symmetric and positive, hence has a positive self-adjoint
(Friedrichs) extension.  No mass gap is claimed. -/
theorem ym_fock_friedrichs_extension (e : ℕ ≃ (Fin 99 →₀ ℕ))
    (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) :
    ∃ (Dom : Submodule ℂ Fock) (A : Dom →ₗ[ℂ] Fock),
      IsPositiveSelfAdjointExtension (dGammaOp (ymFockCol e fabc)) A :=
  secondQuantization_friedrichs (coreBasis e) (ymOnePart e fabc)
    (ymHamiltonian_symmetricOn (coreRepBasis e) fabc)
    (ymHamiltonian_quadForm_nonneg (coreRepBasis e) fabc)

/-- **F.11 — the Hashimoto/SIRK algorithm selects the Friedrichs extension of the
second-quantized field-space Yang–Mills Hamiltonian.**  On the finite-occupation
states over the Gauss–polynomial core of `L²(ℝ⁹⁹)`, the second quantization
`dΓ(H₁)` of `H₁ = ½Σπ² + ½ΣB²` has a positive self-adjoint (Friedrichs)
extension `A`; for every shift `γ > 0` the shift-inverted operator
`R = (A + γ)⁻¹` is bounded by `γ⁻¹` and self-adjoint, its Galerkin truncations
converge strongly and in the resolvent sense, and `R` determines `A` uniquely.
No mass gap is claimed. -/
theorem ym_fock_hashimoto_selects (e : ℕ ≃ (Fin 99 →₀ ℕ))
    (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) (ε : ℕ ≃ Conf) {γ : ℝ} (hγ : 0 < γ) :
    ∃ (Dom : Submodule ℂ Fock) (A : Dom →ₗ[ℂ] Fock) (R : Fock →L[ℂ] Fock),
      IsPositiveSelfAdjointExtension (dGammaOpB ε (ymFockCol e fabc)) A ∧
        IsShiftInvert A γ R ∧ ‖R‖ ≤ γ⁻¹ ∧ IsSelfAdjoint R ∧
        (∀ u : Fock, Tendsto (fun k : ℕ => galerkinCompression R (fockBasisN ε) k u)
          atTop (nhds (R u))) ∧
        (∀ z : ℂ, z.im ≠ 0 → ∀ u : Fock,
          Tendsto (fun k : ℕ => resolvent (galerkinCompression R (fockBasisN ε) k) z u) atTop
            (nhds (resolvent R z u))) ∧
        (∀ (Dom' : Submodule ℂ Fock) (A' : Dom' →ₗ[ℂ] Fock), IsShiftInvert A' γ R →
          Dom' = Dom ∧ ∀ (x : Fock) (hx : x ∈ Dom) (hx' : x ∈ Dom'), A' ⟨x, hx'⟩ = A ⟨x, hx⟩) :=
  secondQuantization_hashimoto_selects ε (coreBasis e) (ymOnePart e fabc)
    (ymHamiltonian_symmetricOn (coreRepBasis e) fabc)
    (ymHamiltonian_quadForm_nonneg (coreRepBasis e) fabc) hγ

end YangMills

end

end BookProof.FockSecondQuantization
