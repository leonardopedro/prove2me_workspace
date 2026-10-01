-- Generated from ChapterFockSecondQuantization.lean — theorem BookProof.FockSecondQuantization.creVec_apply
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

import Mathlib
import BookProof.ChapterNavierStokesEsa
import BookProof.ChapterNavierStokesIkebeKato
import BookProof.ChapterFriedrichsExtension
import BookProof.ChapterYangMillsHermite

theorem BookProof.FockSecondQuantization.creVec_apply (j : ℕ) (u : FockAlg) (α : Conf) :
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
    (∑ k ∈ β.support, creVec (col k) (annA k (Finsupp.single β 1)))

/-- On a state exciting only modes in `K`, the second quantization is the finite
sum `Σ_{k ∈ K} a†(A e_k) a_k`. -/
theorem creVec_apply (v : ℕ →₀ ℂ) (x : FockAlg) :
    creVec v x = ∑ j ∈ v.support, v j • c := by sorry
