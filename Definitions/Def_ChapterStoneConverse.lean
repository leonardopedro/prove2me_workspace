import Mathlib
import Mathlib
import Definitions.Def_ChapterContinuityUnitaryInfinite
import Definitions.Def_ChapterStoneEvolution
import Definitions.Def_ChapterStoneGenerator
import Definitions.Def_ChapterStoneGroup
import Definitions.Def_ChapterStoneMeasurable
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterStoneUnitary
import Definitions.Def_ChapterUnboundedPosition
import Definitions.Def_ChapterUnitaryTransport

import Mathlib

import Mathlib

/-!
# The general Stone theorem, part VII: the generator of a unitary group

Given a weakly measurable one-parameter unitary group `U` on a *separable* Hilbert space we
already know (von Neumann's theorem, `ChapterStoneMeasurable`) that `U` is strongly
continuous.  Here we construct its **infinitesimal generator**

`A x = i (d/dt)|₀ U t x`,

defined on the domain of vectors whose orbit is differentiable at `0`, and prove that `A`
is a densely defined self-adjoint operator.
-/

open scoped InnerProductSpace
open Filter Topology MeasureTheory

namespace BookProof.ChapterStoneMeasurable
/-! ## Cross-chapter definitions from `BookProof.ChapterContinuityUnitaryInfinite` -/
theorem memℓp_two_of_summable {g : ℤ → ℂ} (h : Summable fun k => ‖g k‖ ^ 2) : Memℓp g 2 := by
  apply memℓp_gen
  simpa [show (2 : ℝ≥0∞).toReal = ((2 : ℕ) : ℝ) from by norm_num, Real.rpow_natCast] using h

/-! ## The lattice translations are unitaries -/

theorem memℓp_shift (f : L2Z) (m : ℤ) : Memℓp (fun k : ℤ => (f : ℤ → ℂ) (k + m)) 2 := by
  apply memℓp_gen
  exact ((Equiv.addRight m).summable_iff).2 ((lp.memℓp f).summable (p := 2) (by norm_num))

/-- The lattice translation `(S_m f) k = f (k + m)`, as a linear map. -/
noncomputable def shiftLin (m : ℤ) : L2Z →ₗ[ℂ] L2Z where
  toFun f := ⟨fun k => (f : ℤ → ℂ) (k + m), memℓp_shift f m⟩
  map_add' f g := by ext k; simp
  map_smul' c f := by ext k; simp

@[simp] theorem shiftLin_apply (m : ℤ) (f : L2Z) (k : ℤ) :
    ((shiftLin m f : L2Z) : ℤ → ℂ) k = (f : ℤ → ℂ) (k + m) := rfl

theorem shiftLin_norm (m : ℤ) (f : L2Z) : ‖shiftLin m f‖ = ‖f‖ := by
  have key : ‖shiftLin m f‖ ^ 2 = ‖f‖ ^ 2 := by
    rw [norm_sq_eq_tsum, norm_sq_eq_tsum]
    exact (Equiv.addRight m).tsum_eq fun k => ‖(f : ℤ → ℂ) k‖ ^ 2
  have hpow : ‖shiftLin m f‖ ^ ((2 : ℕ) : ℝ) = ‖f‖ ^ ((2 : ℕ) : ℝ) := by
    simpa only [Real.rpow_natCast] using key
  exact Real.rpow_left_injOn (x := ((2 : ℕ) : ℝ)) (by norm_num)
    (norm_nonneg _) (norm_nonneg _) hpow

/-- **The lattice translation is a unitary of `ℓ²(ℤ)`.** -/
noncomputable def shiftEquiv (m : ℤ) : L2Z ≃ₗᵢ[ℂ] L2Z where
  toLinearEquiv :=
    { shiftLin m with
      invFun := shiftLin (-m)
      left_inv := fun f => by ext k; simp
      right_inv := fun f => by ext k; simp }
  norm_map' := shiftLin_norm m

/-- The lattice translation as a bounded operator. -/
noncomputable def shiftOp (m : ℤ) : L2Z →L[ℂ] L2Z :=
  (shiftEquiv m).toLinearIsometry.toContinuousLinearMap

@[simp] theorem shiftOp_apply (m : ℤ) (f : L2Z) (k : ℤ) :
    ((shiftOp m f : L2Z) : ℤ → ℂ) k = (f : ℤ → ℂ) (k + m) := rfl

/-- Translations are adjoint to their inverses: `⟪S_m f, g⟫ = ⟪f, S_{-m} g⟫`. -/
theorem inner_shiftOp_left (m : ℤ) (f g : L2Z) :
    ⟪shiftOp m f, g⟫_ℂ = ⟪f, shiftOp (-m) g⟫_ℂ := by
  have h := (shiftEquiv m).inner_map_map f (shiftLin (-m) g)
  have hg : shiftEquiv m (shiftLin (-m) g) = g := by
    ext k
    change (g : ℤ → ℂ) (k + m + -m) = (g : ℤ → ℂ) k
    simp only [add_neg_cancel_right]
  rw [hg] at h
  exact h

/-! ## The momentum operator -/

/-- The **symmetric-difference momentum** on the infinite lattice:
`(p f) k = -(i/2) (f (k+1) - f (k-1))`. -/
noncomputable def momentum : L2Z →L[ℂ] L2Z :=
  (-Complex.I / 2) • (shiftOp 1 - shiftOp (-1))

theorem momentum_apply (f : L2Z) (k : ℤ) :
    ((momentum f : L2Z) : ℤ → ℂ) k
      = (-Complex.I / 2) * ((f : ℤ → ℂ) (k + 1) - (f : ℤ → ℂ) (k - 1)) := by
  simp only [momentum, ContinuousLinearMap.smul_apply, ContinuousLinearMap.sub_apply,
    lp.coeFn_smul, lp.coeFn_sub, Pi.smul_apply, Pi.sub_apply, smul_eq_mul, shiftOp_apply]
  congr 2

/-- **The momentum operator is self-adjoint.** -/
theorem momentum_isSymmetric : (momentum : L2Z →ₗ[ℂ] L2Z).IsSymmetric := by
  intro f g
  have h1 := inner_shiftOp_left 1 f g
  have h2 := inner_shiftOp_left (-1) f g
  simp only [momentum, ContinuousLinearMap.coe_coe, ContinuousLinearMap.smul_apply,
    ContinuousLinearMap.sub_apply, inner_smul_left, inner_smul_right, inner_sub_left,
    inner_sub_right, h1, h2, neg_neg]
  simp only [map_div₀, map_neg, Complex.conj_I, Complex.conj_ofNat]
  ring

theorem momentum_isSelfAdjoint : IsSelfAdjoint momentum :=
  ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric.2 momentum_isSymmetric

/-! ## The velocity (multiplication) operator -/

theorem velocity_bound (v : LinfZ) (k : ℤ) : |(v : ℤ → ℝ) k| ≤ ‖v‖ := by
  simpa [Real.norm_eq_abs] using lp.norm_apply_le_norm (by simp) v k

theorem memℓp_mul (v : LinfZ) (f : L2Z) :
    Memℓp (fun k : ℤ => ((v : ℤ → ℝ) k : ℂ) * (f : ℤ → ℂ) k) 2 := by
  refine memℓp_two_of_summable (Summable.of_nonneg_of_le (fun k => by positivity) (fun k => ?_)
    ((summable_normSq f).mul_left (‖v‖ ^ 2)))
  have hnorm : ‖((v : ℤ → ℝ) k : ℂ) * (f : ℤ → ℂ) k‖ = |(v : ℤ → ℝ) k| * ‖(f : ℤ → ℂ) k‖ := by
    simp [Complex.norm_real]
  rw [hnorm, mul_pow]
  have h1 : |(v : ℤ → ℝ) k| ^ 2 ≤ ‖v‖ ^ 2 := by
    nlinarith [abs_nonneg ((v : ℤ → ℝ) k), velocity_bound v k]
  nlinarith [sq_nonneg ‖(f : ℤ → ℂ) k‖]

/-- Multiplication by a bounded real velocity field, as a linear map. -/
noncomputable def velocityLin (v : LinfZ) : L2Z →ₗ[ℂ] L2Z where
  toFun f := ⟨fun k => ((v : ℤ → ℝ) k : ℂ) * (f : ℤ → ℂ) k, memℓp_mul v f⟩
  map_add' f g := by ext k; simp [mul_add]
  map_smul' c f := by
    ext k
    simp only [lp.coeFn_smul, Pi.smul_apply, smul_eq_mul, RingHom.id_apply]
    ring

@[simp] theorem velocityLin_apply (v : LinfZ) (f : L2Z) (k : ℤ) :
    ((velocityLin v f : L2Z) : ℤ → ℂ) k = ((v : ℤ → ℝ) k : ℂ) * (f : ℤ → ℂ) k := rfl

theorem velocityLin_norm_le (v : LinfZ) (f : L2Z) : ‖velocityLin v f‖ ≤ ‖v‖ * ‖f‖ := by
  refine lp.norm_le_of_tsum_le (by norm_num) (by positivity) ?_
  rw [show (2 : ℝ≥0∞).toReal = ((2 : ℕ) : ℝ) from by norm_num]
  simp only [Real.rpow_natCast]
  have hle : ∀ k : ℤ, ‖((velocityLin v f : L2Z) : ℤ → ℂ) k‖ ^ 2
      ≤ ‖v‖ ^ 2 * ‖(f : ℤ → ℂ) k‖ ^ 2 := by
    intro k
    have hnorm : ‖((velocityLin v f : L2Z) : ℤ → ℂ) k‖ = |(v : ℤ → ℝ) k| * ‖(f : ℤ → ℂ) k‖ := by
      simp [Complex.norm_real]
    rw [hnorm, mul_pow]
    have h1 : |(v : ℤ → ℝ) k| ^ 2 ≤ ‖v‖ ^ 2 := by
      nlinarith [abs_nonneg ((v : ℤ → ℝ) k), velocity_bound v k]
    nlinarith [sq_nonneg ‖(f : ℤ → ℂ) k‖]
  calc ∑' k : ℤ, ‖((velocityLin v f : L2Z) : ℤ → ℂ) k‖ ^ 2
      ≤ ∑' k : ℤ, ‖v‖ ^ 2 * ‖(f : ℤ → ℂ) k‖ ^ 2 :=
        Summable.tsum_le_tsum hle (summable_normSq _) ((summable_normSq f).mul_left _)
    _ = ‖v‖ ^ 2 * ∑' k : ℤ, ‖(f : ℤ → ℂ) k‖ ^ 2 := tsum_mul_left
    _ = (‖v‖ * ‖f‖) ^ 2 := by rw [← norm_sq_eq_tsum]; ring

/-- The **velocity operator**: multiplication by a bounded real field `v`. -/
noncomputable def velocityOp (v : LinfZ) : L2Z →L[ℂ] L2Z :=
  LinearMap.mkContinuous (velocityLin v) ‖v‖ (velocityLin_norm_le v)

@[simp] theorem velocityOp_apply (v : LinfZ) (f : L2Z) (k : ℤ) :
    ((velocityOp v f : L2Z) : ℤ → ℂ) k = ((v : ℤ → ℝ) k : ℂ) * (f : ℤ → ℂ) k := rfl

theorem velocityOp_isSymmetric (v : LinfZ) :
    (velocityOp v : L2Z →ₗ[ℂ] L2Z).IsSymmetric := by
  intro f g
  rw [lp.inner_eq_tsum, lp.inner_eq_tsum]
  refine tsum_congr fun k => ?_
  simp only [ContinuousLinearMap.coe_coe, velocityOp_apply, RCLike.inner_apply, map_mul,
    Complex.conj_ofReal]
  ring

theorem velocityOp_isSelfAdjoint (v : LinfZ) : IsSelfAdjoint (velocityOp v) :=
  ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric.2 (velocityOp_isSymmetric v)

/-! ## The Weyl-symmetrized continuity generator -/

/-- The **Weyl-symmetrized continuity generator** `H = ½ (p·v + v·p)` on
`ℓ²(ℤ)`: a bounded operator, self-adjoint precisely because of the
symmetrization. -/
noncomputable def continuityHamiltonian (v : LinfZ) : L2Z →L[ℂ] L2Z :=
  (1 / 2 : ℂ) • (momentum.comp (velocityOp v) + (velocityOp v).comp momentum)

theorem continuityHamiltonian_isSymmetric (v : LinfZ) :
    (continuityHamiltonian v : L2Z →ₗ[ℂ] L2Z).IsSymmetric := by
  intro f g
  have hp1 : ⟪momentum ((velocityOp v) f), g⟫_ℂ = ⟪(velocityOp v) f, momentum g⟫_ℂ :=
    momentum_isSymmetric _ _
  have hv1 : ⟪(velocityOp v) f, momentum g⟫_ℂ = ⟪f, (velocityOp v) (momentum g)⟫_ℂ :=
    velocityOp_isSymmetric v _ _
  have hv2 : ⟪(velocityOp v) (momentum f), g⟫_ℂ = ⟪momentum f, (velocityOp v) g⟫_ℂ :=
    velocityOp_isSymmetric v _ _
  have hp2 : ⟪momentum f, (velocityOp v) g⟫_ℂ = ⟪f, momentum ((velocityOp v) g)⟫_ℂ :=
    momentum_isSymmetric _ _
  simp only [continuityHamiltonian, ContinuousLinearMap.coe_coe,
    ContinuousLinearMap.smul_apply, ContinuousLinearMap.add_apply,
    ContinuousLinearMap.coe_comp', Function.comp_apply, inner_smul_left, inner_smul_right,
    inner_add_left, inner_add_right]
  rw [hp1, hv1, hv2, hp2]
  simp only [map_div₀, map_one, Complex.conj_ofNat]
  ring

/-- **The Weyl-symmetrized generator is self-adjoint** — the infinite-lattice
counterpart of `ChapterContinuityUnitary.continuityHamiltonian_hermitian`. -/
theorem continuityHamiltonian_isSelfAdjoint (v : LinfZ) :
    IsSelfAdjoint (continuityHamiltonian v) :=
  ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric.2 (continuityHamiltonian_isSymmetric v)

/-! ## The one-parameter unitary group -/

/-- `exp (i t A)` is unitary for a bounded self-adjoint `A` on a Hilbert space —
the operator-algebra counterpart of `ChapterContinuityUnitary.exp_smul_I_unitary`. -/
theorem exp_smul_I_unitary {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
    [CompleteSpace E] (A : E →L[ℂ] E) (hA : IsSelfAdjoint A) (t : ℝ) :
    star (NormedSpace.exp (((t : ℂ) * Complex.I) • A)) *
        NormedSpace.exp (((t : ℂ) * Complex.I) • A) = 1 ∧
      NormedSpace.exp (((t : ℂ) * Complex.I) • A) *
        star (NormedSpace.exp (((t : ℂ) * Complex.I) • A)) = 1 := by
  let +nondep : NormedAlgebra ℚ (E →L[ℂ] E) := .restrictScalars ℚ ℂ _
  set B : E →L[ℂ] E := ((t : ℂ) * Complex.I) • A with hB
  have hstar : star B = -B := by
    rw [hB, star_smul, hA.star_eq]
    simp [RCLike.star_def, ← neg_smul]
  have hexp : star (NormedSpace.exp B) = NormedSpace.exp (-B) := by
    rw [NormedSpace.star_exp, hstar]
  refine ⟨?_, ?_⟩
  · rw [hexp, ← NormedSpace.exp_add_of_commute (Commute.neg_left (Commute.refl B)),
      neg_add_cancel, NormedSpace.exp_zero]
  · rw [hexp, ← NormedSpace.exp_add_of_commute (Commute.neg_right (Commute.refl B)),
      add_neg_cancel, NormedSpace.exp_zero]

/-- The **dynamics-based unitary on the infinite lattice**: `U t = exp (i t H)`
for the continuity generator `H` of the bounded velocity field `v`. -/
noncomputable def continuityUnitary (v : LinfZ) (t : ℝ) : L2Z →L[ℂ] L2Z :=
  NormedSpace.exp (((t : ℂ) * Complex.I) • continuityHamiltonian v)

/-- **`U t` is unitary.** -/
theorem continuityUnitary_unitary (v : LinfZ) (t : ℝ) :
    star (continuityUnitary v t) * continuityUnitary v t = 1 ∧
      continuityUnitary v t * star (continuityUnitary v t) = 1 :=
  exp_smul_I_unitary _ (continuityHamiltonian_isSelfAdjoint v) t

theorem continuityUnitary_zero (v : LinfZ) : continuityUnitary v 0 = 1 := by
  simp [continuityUnitary]

/-- `U` is a one-parameter group: `U (s + t) = U s ∘ U t`. -/
theorem continuityUnitary_add (v : LinfZ) (s t : ℝ) :
    continuityUnitary v (s + t) = continuityUnitary v s * continuityUnitary v t := by
  let +nondep : NormedAlgebra ℚ (L2Z →L[ℂ] L2Z) := .restrictScalars ℚ ℂ _
  have hcomm : Commute (((s : ℂ) * Complex.I) • continuityHamiltonian v)
      (((t : ℂ) * Complex.I) • continuityHamiltonian v) := by
    simp [Commute, SemiconjBy, smul_smul, mul_comm]
  have hsum : (((s + t : ℝ) : ℂ) * Complex.I) • continuityHamiltonian v
      = ((s : ℂ) * Complex.I) • continuityHamiltonian v
        + ((t : ℂ) * Complex.I) • continuityHamiltonian v := by
    rw [← add_smul]
    push_cast
    ring_nf
  rw [continuityUnitary, hsum, NormedSpace.exp_add_of_commute hcomm]
  rfl

/-- A unitary preserves the norm — hence the total `ℓ²` mass. -/
theorem norm_of_unitary {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
    [CompleteSpace E] (U : E →L[ℂ] E) (hU : star U * U = 1) (x : E) : ‖U x‖ = ‖x‖ := by
  have hinner : ⟪U x, U x⟫_ℂ = ⟪x, x⟫_ℂ := by
    rw [← ContinuousLinearMap.adjoint_inner_left]
    rw [← ContinuousLinearMap.star_eq_adjoint]
    rw [show (star U) (U x) = ((star U) * U) x from rfl, hU]
    rfl
  have h := congrArg Complex.re hinner
  simp only [inner_self_eq_norm_sq_to_K] at h
  have h' : ‖U x‖ ^ 2 = ‖x‖ ^ 2 := by exact_mod_cast h
  nlinarith [norm_nonneg (U x), norm_nonneg x]

/-! ## Born recovery: a countably additive probability law on the lattice -/

/-- The state evolved for time `t` by the dynamics-based unitary. -/
noncomputable def evolvedState (v : LinfZ) (t : ℝ) (psi : L2Z) : L2Z :=
  continuityUnitary v t psi

/-- The Born weight of a set `B` of lattice sites in the evolved state. -/
noncomputable def bornRecover (v : LinfZ) (t : ℝ) (psi : L2Z) (B : Finset ℤ) : ℝ :=
  ∑ z ∈ B, ‖((evolvedState v t psi : L2Z) : ℤ → ℂ) z‖ ^ 2

theorem bornRecover_nonneg (v : LinfZ) (t : ℝ) (psi : L2Z) (B : Finset ℤ) :
    0 ≤ bornRecover v t psi B :=
  Finset.sum_nonneg fun _ _ => by positivity

theorem bornRecover_empty (v : LinfZ) (t : ℝ) (psi : L2Z) : bornRecover v t psi ∅ = 0 := by
  simp [bornRecover]

theorem bornRecover_union (v : LinfZ) (t : ℝ) (psi : L2Z) {B C : Finset ℤ}
    (h : Disjoint B C) :
    bornRecover v t psi (B ∪ C) = bornRecover v t psi B + bornRecover v t psi C := by
  simp [bornRecover, Finset.sum_union h]

theorem bornRecover_mono (v : LinfZ) (t : ℝ) (psi : L2Z) {B C : Finset ℤ} (h : B ⊆ C) :
    bornRecover v t psi B ≤ bornRecover v t psi C :=
  Finset.sum_le_sum_of_subset_of_nonneg h fun _ _ _ => by positivity

/-- The evolved state has the same `ℓ²` mass as the initial state. -/
theorem norm_evolvedState (v : LinfZ) (t : ℝ) (psi : L2Z) :
    ‖evolvedState v t psi‖ = ‖psi‖ :=
  norm_of_unitary _ (continuityUnitary_unitary v t).1 psi

/-- **Born recovery: the total mass is `1`.**  On the infinite lattice this is a
countable sum, and unitarity of `U t` makes it exactly `1` for a normalized
initial state. -/
theorem bornRecover_tsum_univ (v : LinfZ) (t : ℝ) (psi : L2Z) (hpsi : ‖psi‖ = 1) :
    ∑' z : ℤ, ‖((evolvedState v t psi : L2Z) : ℤ → ℂ) z‖ ^ 2 = 1 := by
  rw [← norm_sq_eq_tsum, norm_evolvedState, hpsi, one_pow]

theorem summable_bornWeight (v : LinfZ) (t : ℝ) (psi : L2Z) :
    Summable fun z : ℤ => ‖((evolvedState v t psi : L2Z) : ℤ → ℂ) z‖ ^ 2 :=
  summable_normSq _

/-- The Born weights of the evolved state, as a probability distribution on the
infinite lattice `ℤ`. -/
noncomputable def bornPMF (v : LinfZ) (t : ℝ) (psi : L2Z) (hpsi : ‖psi‖ = 1) : PMF ℤ :=
  ⟨fun z => ENNReal.ofReal (‖((evolvedState v t psi : L2Z) : ℤ → ℂ) z‖ ^ 2), by
    have hns : ∀ z : ℤ, 0 ≤ ‖((evolvedState v t psi : L2Z) : ℤ → ℂ) z‖ ^ 2 := fun _ => by positivity
    have htsum : ∑' z : ℤ, ENNReal.ofReal (‖((evolvedState v t psi : L2Z) : ℤ → ℂ) z‖ ^ 2) = 1 := by
      rw [← ENNReal.ofReal_tsum_of_nonneg hns (summable_bornWeight v t psi),
        bornRecover_tsum_univ v t psi hpsi, ENNReal.ofReal_one]
    exact htsum ▸ ENNReal.summable.hasSum⟩

@[simp] theorem bornPMF_apply (v : LinfZ) (t : ℝ) (psi : L2Z) (hpsi : ‖psi‖ = 1) (z : ℤ) :
    bornPMF v t psi hpsi z
      = ENNReal.ofReal (‖((evolvedState v t psi : L2Z) : ℤ → ℂ) z‖ ^ 2) := rfl

/-! ## The capstone -/

variable {X : Type*}

/-- **Capstone (infinite lattice).**  A family of bounded velocity fields `v x`
on `ℤ`, together with normalized initial states `psi x`, determines by the
dynamics-based unitary — and by *no* basis choice — a genuine conditional
probability law `z ↦ |Ψ_t(x, z)|²` on the infinite lattice for every input `x`:
it is a countably additive probability measure whose mass on a finite set `B` of
sites is the Born weight `bornRecover`. -/
theorem condProb_of_continuity_infinite (v : X → LinfZ) (t : ℝ) (psi : X → L2Z)
    (hpsi : ∀ x, ‖psi x‖ = 1) (x : X) :
    (∑' z : ℤ, bornPMF (v x) t (psi x) (hpsi x) z) = 1 ∧
      ∀ B : Finset ℤ,
        ∑ z ∈ B, bornPMF (v x) t (psi x) (hpsi x) z
          = ENNReal.ofReal (bornRecover (v x) t (psi x) B) := by
  refine ⟨(bornPMF (v x) t (psi x) (hpsi x)).tsum_coe, fun B => ?_⟩
  rw [bornRecover, ENNReal.ofReal_sum_of_nonneg (fun _ _ => by positivity)]
  exact Finset.sum_congr rfl fun z _ => bornPMF_apply _ _ _ _ z

end BookProof.ChapterContinuityUnitaryInfinite

theorem norm_sq_eq_tsum (f : L2Z) : ‖f‖ ^ 2 = ∑' k : ℤ, ‖(f : ℤ → ℂ) k‖ ^ 2 := by
  have h := lp.norm_rpow_eq_tsum (p := 2) (by norm_num) f
  rw [show (2 : ℝ≥0∞).toReal = ((2 : ℕ) : ℝ) from by norm_num] at h
  simpa only [Real.rpow_natCast] using h

theorem memℓp_two_of_summable {g : ℤ → ℂ} (h : Summable fun k => ‖g k‖ ^ 2) : Memℓp g 2 := by
  apply memℓp_gen
  simpa [show (2 : ℝ≥0∞).toReal = ((2 : ℕ) : ℝ) from by norm_num, Real.rpow_natCast] using h

/-! ## The lattice translations are unitaries -/

theorem memℓp_shift (f : L2Z) (m : ℤ) : Memℓp (fun k : ℤ => (f : ℤ → ℂ) (k + m)) 2 := by
  apply memℓp_gen
  exact ((Equiv.addRight m).summable_iff).2 ((lp.memℓp f).summable (p := 2) (by norm_num))

/-- The lattice translation `(S_m f) k = f (k + m)`, as a linear map. -/
noncomputable def shiftLin (m : ℤ) : L2Z →ₗ[ℂ] L2Z where
  toFun f := ⟨fun k => (f : ℤ → ℂ) (k + m), memℓp_shift f m⟩
  map_add' f g := by ext k; simp
  map_smul' c f := by ext k; simp

@[simp] theorem shiftLin_apply (m : ℤ) (f : L2Z) (k : ℤ) :
    ((shiftLin m f : L2Z) : ℤ → ℂ) k = (f : ℤ → ℂ) (k + m) := rfl

theorem shiftLin_norm (m : ℤ) (f : L2Z) : ‖shiftLin m f‖ = ‖f‖ := by
  have key : ‖shiftLin m f‖ ^ 2 = ‖f‖ ^ 2 := by
    rw [norm_sq_eq_tsum, norm_sq_eq_tsum]
    exact (Equiv.addRight m).tsum_eq fun k => ‖(f : ℤ → ℂ) k‖ ^ 2
  have hpow : ‖shiftLin m f‖ ^ ((2 : ℕ) : ℝ) = ‖f‖ ^ ((2 : ℕ) : ℝ) := by
    simpa only [Real.rpow_natCast] using key
  exact Real.rpow_left_injOn (x := ((2 : ℕ) : ℝ)) (by norm_num)
    (norm_nonneg _) (norm_nonneg _) hpow

/-- **The lattice translation is a unitary of `ℓ²(ℤ)`.** -/
noncomputable def shiftEquiv (m : ℤ) : L2Z ≃ₗᵢ[ℂ] L2Z where
  toLinearEquiv :=
    { shiftLin m with
      invFun := shiftLin (-m)
      left_inv := fun f => by ext k; simp
      right_inv := fun f => by ext k; simp }
  norm_map' := shiftLin_norm m

/-- The lattice translation as a bounded operator. -/
noncomputable def shiftOp (m : ℤ) : L2Z →L[ℂ] L2Z :=
  (shiftEquiv m).toLinearIsometry.toContinuousLinearMap

@[simp] theorem shiftOp_apply (m : ℤ) (f : L2Z) (k : ℤ) :
    ((shiftOp m f : L2Z) : ℤ → ℂ) k = (f : ℤ → ℂ) (k + m) := rfl

/-- Translations are adjoint to their inverses: `⟪S_m f, g⟫ = ⟪f, S_{-m} g⟫`. -/
theorem inner_shiftOp_left (m : ℤ) (f g : L2Z) :
    ⟪shiftOp m f, g⟫_ℂ = ⟪f, shiftOp (-m) g⟫_ℂ := by
  have h := (shiftEquiv m).inner_map_map f (shiftLin (-m) g)
  have hg : shiftEquiv m (shiftLin (-m) g) = g := by
    ext k
    change (g : ℤ → ℂ) (k + m + -m) = (g : ℤ → ℂ) k
    simp only [add_neg_cancel_right]
  rw [hg] at h
  exact h

/-! ## The momentum operator -/

/-- The **symmetric-difference momentum** on the infinite lattice:
`(p f) k = -(i/2) (f (k+1) - f (k-1))`. -/
noncomputable def momentum : L2Z →L[ℂ] L2Z :=
  (-Complex.I / 2) • (shiftOp 1 - shiftOp (-1))

theorem momentum_apply (f : L2Z) (k : ℤ) :
    ((momentum f : L2Z) : ℤ → ℂ) k
      = (-Complex.I / 2) * ((f : ℤ → ℂ) (k + 1) - (f : ℤ → ℂ) (k - 1)) := by
  simp only [momentum, ContinuousLinearMap.smul_apply, ContinuousLinearMap.sub_apply,
    lp.coeFn_smul, lp.coeFn_sub, Pi.smul_apply, Pi.sub_apply, smul_eq_mul, shiftOp_apply]
  congr 2

/-- **The momentum operator is self-adjoint.** -/
theorem momentum_isSymmetric : (momentum : L2Z →ₗ[ℂ] L2Z).IsSymmetric := by
  intro f g
  have h1 := inner_shiftOp_left 1 f g
  have h2 := inner_shiftOp_left (-1) f g
  simp only [momentum, ContinuousLinearMap.coe_coe, ContinuousLinearMap.smul_apply,
    ContinuousLinearMap.sub_apply, inner_smul_left, inner_smul_right, inner_sub_left,
    inner_sub_right, h1, h2, neg_neg]
  simp only [map_div₀, map_neg, Complex.conj_I, Complex.conj_ofNat]
  ring

theorem momentum_isSelfAdjoint : IsSelfAdjoint momentum :=
  ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric.2 momentum_isSymmetric

/-! ## The velocity (multiplication) operator -/

theorem velocity_bound (v : LinfZ) (k : ℤ) : |(v : ℤ → ℝ) k| ≤ ‖v‖ := by
  simpa [Real.norm_eq_abs] using lp.norm_apply_le_norm (by simp) v k

theorem memℓp_mul (v : LinfZ) (f : L2Z) :
    Memℓp (fun k : ℤ => ((v : ℤ → ℝ) k : ℂ) * (f : ℤ → ℂ) k) 2 := by
  refine memℓp_two_of_summable (Summable.of_nonneg_of_le (fun k => by positivity) (fun k => ?_)
    ((summable_normSq f).mul_left (‖v‖ ^ 2)))
  have hnorm : ‖((v : ℤ → ℝ) k : ℂ) * (f : ℤ → ℂ) k‖ = |(v : ℤ → ℝ) k| * ‖(f : ℤ → ℂ) k‖ := by
    simp [Complex.norm_real]
  rw [hnorm, mul_pow]
  have h1 : |(v : ℤ → ℝ) k| ^ 2 ≤ ‖v‖ ^ 2 := by
    nlinarith [abs_nonneg ((v : ℤ → ℝ) k), velocity_bound v k]
  nlinarith [sq_nonneg ‖(f : ℤ → ℂ) k‖]

/-- Multiplication by a bounded real velocity field, as a linear map. -/
noncomputable def velocityLin (v : LinfZ) : L2Z →ₗ[ℂ] L2Z where
  toFun f := ⟨fun k => ((v : ℤ → ℝ) k : ℂ) * (f : ℤ → ℂ) k, memℓp_mul v f⟩
  map_add' f g := by ext k; simp [mul_add]
  map_smul' c f := by
    ext k
    simp only [lp.coeFn_smul, Pi.smul_apply, smul_eq_mul, RingHom.id_apply]
    ring

@[simp] theorem velocityLin_apply (v : LinfZ) (f : L2Z) (k : ℤ) :
    ((velocityLin v f : L2Z) : ℤ → ℂ) k = ((v : ℤ → ℝ) k : ℂ) * (f : ℤ → ℂ) k := rfl

theorem velocityLin_norm_le (v : LinfZ) (f : L2Z) : ‖velocityLin v f‖ ≤ ‖v‖ * ‖f‖ := by
  refine lp.norm_le_of_tsum_le (by norm_num) (by positivity) ?_
  rw [show (2 : ℝ≥0∞).toReal = ((2 : ℕ) : ℝ) from by norm_num]
  simp only [Real.rpow_natCast]
  have hle : ∀ k : ℤ, ‖((velocityLin v f : L2Z) : ℤ → ℂ) k‖ ^ 2
      ≤ ‖v‖ ^ 2 * ‖(f : ℤ → ℂ) k‖ ^ 2 := by
    intro k
    have hnorm : ‖((velocityLin v f : L2Z) : ℤ → ℂ) k‖ = |(v : ℤ → ℝ) k| * ‖(f : ℤ → ℂ) k‖ := by
      simp [Complex.norm_real]
    rw [hnorm, mul_pow]
    have h1 : |(v : ℤ → ℝ) k| ^ 2 ≤ ‖v‖ ^ 2 := by
      nlinarith [abs_nonneg ((v : ℤ → ℝ) k), velocity_bound v k]
    nlinarith [sq_nonneg ‖(f : ℤ → ℂ) k‖]
  calc ∑' k : ℤ, ‖((velocityLin v f : L2Z) : ℤ → ℂ) k‖ ^ 2
      ≤ ∑' k : ℤ, ‖v‖ ^ 2 * ‖(f : ℤ → ℂ) k‖ ^ 2 :=
        Summable.tsum_le_tsum hle (summable_normSq _) ((summable_normSq f).mul_left _)
    _ = ‖v‖ ^ 2 * ∑' k : ℤ, ‖(f : ℤ → ℂ) k‖ ^ 2 := tsum_mul_left
    _ = (‖v‖ * ‖f‖) ^ 2 := by rw [← norm_sq_eq_tsum]; ring

/-- The **velocity operator**: multiplication by a bounded real field `v`. -/
noncomputable def velocityOp (v : LinfZ) : L2Z →L[ℂ] L2Z :=
  LinearMap.mkContinuous (velocityLin v) ‖v‖ (velocityLin_norm_le v)

@[simp] theorem velocityOp_apply (v : LinfZ) (f : L2Z) (k : ℤ) :
    ((velocityOp v f : L2Z) : ℤ → ℂ) k = ((v : ℤ → ℝ) k : ℂ) * (f : ℤ → ℂ) k := rfl

theorem velocityOp_isSymmetric (v : LinfZ) :
    (velocityOp v : L2Z →ₗ[ℂ] L2Z).IsSymmetric := by
  intro f g
  rw [lp.inner_eq_tsum, lp.inner_eq_tsum]
  refine tsum_congr fun k => ?_
  simp only [ContinuousLinearMap.coe_coe, velocityOp_apply, RCLike.inner_apply, map_mul,
    Complex.conj_ofReal]
  ring

theorem velocityOp_isSelfAdjoint (v : LinfZ) : IsSelfAdjoint (velocityOp v) :=
  ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric.2 (velocityOp_isSymmetric v)

/-! ## The Weyl-symmetrized continuity generator -/

/-- The **Weyl-symmetrized continuity generator** `H = ½ (p·v + v·p)` on
`ℓ²(ℤ)`: a bounded operator, self-adjoint precisely because of the
symmetrization. -/
noncomputable def continuityHamiltonian (v : LinfZ) : L2Z →L[ℂ] L2Z :=
  (1 / 2 : ℂ) • (momentum.comp (velocityOp v) + (velocityOp v).comp momentum)

theorem continuityHamiltonian_isSymmetric (v : LinfZ) :
    (continuityHamiltonian v : L2Z →ₗ[ℂ] L2Z).IsSymmetric := by
  intro f g
  have hp1 : ⟪momentum ((velocityOp v) f), g⟫_ℂ = ⟪(velocityOp v) f, momentum g⟫_ℂ :=
    momentum_isSymmetric _ _
  have hv1 : ⟪(velocityOp v) f, momentum g⟫_ℂ = ⟪f, (velocityOp v) (momentum g)⟫_ℂ :=
    velocityOp_isSymmetric v _ _
  have hv2 : ⟪(velocityOp v) (momentum f), g⟫_ℂ = ⟪momentum f, (velocityOp v) g⟫_ℂ :=
    velocityOp_isSymmetric v _ _
  have hp2 : ⟪momentum f, (velocityOp v) g⟫_ℂ = ⟪f, momentum ((velocityOp v) g)⟫_ℂ :=
    momentum_isSymmetric _ _
  simp only [continuityHamiltonian, ContinuousLinearMap.coe_coe,
    ContinuousLinearMap.smul_apply, ContinuousLinearMap.add_apply,
    ContinuousLinearMap.coe_comp', Function.comp_apply, inner_smul_left, inner_smul_right,
    inner_add_left, inner_add_right]
  rw [hp1, hv1, hv2, hp2]
  simp only [map_div₀, map_one, Complex.conj_ofNat]
  ring

/-- **The Weyl-symmetrized generator is self-adjoint** — the infinite-lattice
counterpart of `ChapterContinuityUnitary.continuityHamiltonian_hermitian`. -/
theorem continuityHamiltonian_isSelfAdjoint (v : LinfZ) :
    IsSelfAdjoint (continuityHamiltonian v) :=
  ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric.2 (continuityHamiltonian_isSymmetric v)

/-! ## The one-parameter unitary group -/

/-- `exp (i t A)` is unitary for a bounded self-adjoint `A` on a Hilbert space —
the operator-algebra counterpart of `ChapterContinuityUnitary.exp_smul_I_unitary`. -/
theorem exp_smul_I_unitary {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
    [CompleteSpace E] (A : E →L[ℂ] E) (hA : IsSelfAdjoint A) (t : ℝ) :
    star (NormedSpace.exp (((t : ℂ) * Complex.I) • A)) *
        NormedSpace.exp (((t : ℂ) * Complex.I) • A) = 1 ∧
      NormedSpace.exp (((t : ℂ) * Complex.I) • A) *
        star (NormedSpace.exp (((t : ℂ) * Complex.I) • A)) = 1 := by
  let +nondep : NormedAlgebra ℚ (E →L[ℂ] E) := .restrictScalars ℚ ℂ _
  set B : E →L[ℂ] E := ((t : ℂ) * Complex.I) • A with hB
  have hstar : star B = -B := by
    rw [hB, star_smul, hA.star_eq]
    simp [RCLike.star_def, ← neg_smul]
  have hexp : star (NormedSpace.exp B) = NormedSpace.exp (-B) := by
    rw [NormedSpace.star_exp, hstar]
  refine ⟨?_, ?_⟩
  · rw [hexp, ← NormedSpace.exp_add_of_commute (Commute.neg_left (Commute.refl B)),
      neg_add_cancel, NormedSpace.exp_zero]
  · rw [hexp, ← NormedSpace.exp_add_of_commute (Commute.neg_right (Commute.refl B)),
      add_neg_cancel, NormedSpace.exp_zero]

/-- The **dynamics-based unitary on the infinite lattice**: `U t = exp (i t H)`
for the continuity generator `H` of the bounded velocity field `v`. -/
noncomputable def continuityUnitary (v : LinfZ) (t : ℝ) : L2Z →L[ℂ] L2Z :=
  NormedSpace.exp (((t : ℂ) * Complex.I) • continuityHamiltonian v)

/-- **`U t` is unitary.** -/
theorem continuityUnitary_unitary (v : LinfZ) (t : ℝ) :
    star (continuityUnitary v t) * continuityUnitary v t = 1 ∧
      continuityUnitary v t * star (continuityUnitary v t) = 1 :=
  exp_smul_I_unitary _ (continuityHamiltonian_isSelfAdjoint v) t

theorem continuityUnitary_zero (v : LinfZ) : continuityUnitary v 0 = 1 := by
  simp [continuityUnitary]

/-- `U` is a one-parameter group: `U (s + t) = U s ∘ U t`. -/
theorem continuityUnitary_add (v : LinfZ) (s t : ℝ) :
    continuityUnitary v (s + t) = continuityUnitary v s * continuityUnitary v t := by
  let +nondep : NormedAlgebra ℚ (L2Z →L[ℂ] L2Z) := .restrictScalars ℚ ℂ _
  have hcomm : Commute (((s : ℂ) * Complex.I) • continuityHamiltonian v)
      (((t : ℂ) * Complex.I) • continuityHamiltonian v) := by
    simp [Commute, SemiconjBy, smul_smul, mul_comm]
  have hsum : (((s + t : ℝ) : ℂ) * Complex.I) • continuityHamiltonian v
      = ((s : ℂ) * Complex.I) • continuityHamiltonian v
        + ((t : ℂ) * Complex.I) • continuityHamiltonian v := by
    rw [← add_smul]
    push_cast
    ring_nf
  rw [continuityUnitary, hsum, NormedSpace.exp_add_of_commute hcomm]
  rfl

/-- A unitary preserves the norm — hence the total `ℓ²` mass. -/
theorem norm_of_unitary {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
    [CompleteSpace E] (U : E →L[ℂ] E) (hU : star U * U = 1) (x : E) : ‖U x‖ = ‖x‖ := by
  have hinner : ⟪U x, U x⟫_ℂ = ⟪x, x⟫_ℂ := by
    rw [← ContinuousLinearMap.adjoint_inner_left]
    rw [← ContinuousLinearMap.star_eq_adjoint]
    rw [show (star U) (U x) = ((star U) * U) x from rfl, hU]
    rfl
  have h := congrArg Complex.re hinner
  simp only [inner_self_eq_norm_sq_to_K] at h
  have h' : ‖U x‖ ^ 2 = ‖x‖ ^ 2 := by exact_mod_cast h
  nlinarith [norm_nonneg (U x), norm_nonneg x]

/-! ## Born recovery: a countably additive probability law on the lattice -/

/-- The state evolved for time `t` by the dynamics-based unitary. -/
noncomputable def evolvedState (v : LinfZ) (t : ℝ) (psi : L2Z) : L2Z :=
  continuityUnitary v t psi

/-- The Born weight of a set `B` of lattice sites in the evolved state. -/
noncomputable def bornRecover (v : LinfZ) (t : ℝ) (psi : L2Z) (B : Finset ℤ) : ℝ :=
  ∑ z ∈ B, ‖((evolvedState v t psi : L2Z) : ℤ → ℂ) z‖ ^ 2

theorem bornRecover_nonneg (v : LinfZ) (t : ℝ) (psi : L2Z) (B : Finset ℤ) :
    0 ≤ bornRecover v t psi B :=
  Finset.sum_nonneg fun _ _ => by positivity

theorem bornRecover_empty (v : LinfZ) (t : ℝ) (psi : L2Z) : bornRecover v t psi ∅ = 0 := by
  simp [bornRecover]

theorem bornRecover_union (v : LinfZ) (t : ℝ) (psi : L2Z) {B C : Finset ℤ}
    (h : Disjoint B C) :
    bornRecover v t psi (B ∪ C) = bornRecover v t psi B + bornRecover v t psi C := by
  simp [bornRecover, Finset.sum_union h]

theorem bornRecover_mono (v : LinfZ) (t : ℝ) (psi : L2Z) {B C : Finset ℤ} (h : B ⊆ C) :
    bornRecover v t psi B ≤ bornRecover v t psi C :=
  Finset.sum_le_sum_of_subset_of_nonneg h fun _ _ _ => by positivity

/-- The evolved state has the same `ℓ²` mass as the initial state. -/
theorem norm_evolvedState (v : LinfZ) (t : ℝ) (psi : L2Z) :
    ‖evolvedState v t psi‖ = ‖psi‖ :=
  norm_of_unitary _ (continuityUnitary_unitary v t).1 psi

/-- **Born recovery: the total mass is `1`.**  On the infinite lattice this is a
countable sum, and unitarity of `U t` makes it exactly `1` for a normalized
initial state. -/
theorem bornRecover_tsum_univ (v : LinfZ) (t : ℝ) (psi : L2Z) (hpsi : ‖psi‖ = 1) :
    ∑' z : ℤ, ‖((evolvedState v t psi : L2Z) : ℤ → ℂ) z‖ ^ 2 = 1 := by
  rw [← norm_sq_eq_tsum, norm_evolvedState, hpsi, one_pow]

theorem summable_bornWeight (v : LinfZ) (t : ℝ) (psi : L2Z) :
    Summable fun z : ℤ => ‖((evolvedState v t psi : L2Z) : ℤ → ℂ) z‖ ^ 2 :=
  summable_normSq _

/-- The Born weights of the evolved state, as a probability distribution on the
infinite lattice `ℤ`. -/
noncomputable def bornPMF (v : LinfZ) (t : ℝ) (psi : L2Z) (hpsi : ‖psi‖ = 1) : PMF ℤ :=
  ⟨fun z => ENNReal.ofReal (‖((evolvedState v t psi : L2Z) : ℤ → ℂ) z‖ ^ 2), by
    have hns : ∀ z : ℤ, 0 ≤ ‖((evolvedState v t psi : L2Z) : ℤ → ℂ) z‖ ^ 2 := fun _ => by positivity
    have htsum : ∑' z : ℤ, ENNReal.ofReal (‖((evolvedState v t psi : L2Z) : ℤ → ℂ) z‖ ^ 2) = 1 := by
      rw [← ENNReal.ofReal_tsum_of_nonneg hns (summable_bornWeight v t psi),
        bornRecover_tsum_univ v t psi hpsi, ENNReal.ofReal_one]
    exact htsum ▸ ENNReal.summable.hasSum⟩

@[simp] theorem bornPMF_apply (v : LinfZ) (t : ℝ) (psi : L2Z) (hpsi : ‖psi‖ = 1) (z : ℤ) :
    bornPMF v t psi hpsi z
      = ENNReal.ofReal (‖((evolvedState v t psi : L2Z) : ℤ → ℂ) z‖ ^ 2) := rfl

/-! ## The capstone -/

variable {X : Type*}

/-- **Capstone (infinite lattice).**  A family of bounded velocity fields `v x`
on `ℤ`, together with normalized initial states `psi x`, determines by the
dynamics-based unitary — and by *no* basis choice — a genuine conditional
probability law `z ↦ |Ψ_t(x, z)|²` on the infinite lattice for every input `x`:
it is a countably additive probability measure whose mass on a finite set `B` of
sites is the Born weight `bornRecover`. -/
theorem condProb_of_continuity_infinite (v : X → LinfZ) (t : ℝ) (psi : X → L2Z)
    (hpsi : ∀ x, ‖psi x‖ = 1) (x : X) :
    (∑' z : ℤ, bornPMF (v x) t (psi x) (hpsi x) z) = 1 ∧
      ∀ B : Finset ℤ,
        ∑ z ∈ B, bornPMF (v x) t (psi x) (hpsi x) z
          = ENNReal.ofReal (bornRecover (v x) t (psi x) B) := by
  refine ⟨(bornPMF (v x) t (psi x) (hpsi x)).tsum_coe, fun B => ?_⟩
  rw [bornRecover, ENNReal.ofReal_sum_of_nonneg (fun _ _ => by positivity)]
  exact Finset.sum_congr rfl fun z _ => bornPMF_apply _ _ _ _ z

end BookProof.ChapterContinuityUnitaryInfinite

theorem summable_normSq (f : L2Z) : Summable fun k : ℤ => ‖(f : ℤ → ℂ) k‖ ^ 2 := by
  have hsum := (lp.memℓp f).summable (p := 2) (by norm_num)
  simpa [show (2 : ℝ≥0∞).toReal = ((2 : ℕ) : ℝ) from by norm_num, Real.rpow_natCast] using hsum

/-- Parseval on `ℓ²(ℤ)`: the squared norm is the sum of the squared moduli. -/
theorem norm_sq_eq_tsum (f : L2Z) : ‖f‖ ^ 2 = ∑' k : ℤ, ‖(f : ℤ → ℂ) k‖ ^ 2 := by
  have h := lp.norm_rpow_eq_tsum (p := 2) (by norm_num) f
  rw [show (2 : ℝ≥0∞).toReal = ((2 : ℕ) : ℝ) from by norm_num] at h
  simpa only [Real.rpow_natCast] using h

theorem memℓp_two_of_summable {g : ℤ → ℂ} (h : Summable fun k => ‖g k‖ ^ 2) : Memℓp g 2 := by
  apply memℓp_gen
  simpa [show (2 : ℝ≥0∞).toReal = ((2 : ℕ) : ℝ) from by norm_num, Real.rpow_natCast] using h

/-! ## The lattice translations are unitaries -/

theorem memℓp_shift (f : L2Z) (m : ℤ) : Memℓp (fun k : ℤ => (f : ℤ → ℂ) (k + m)) 2 := by
  apply memℓp_gen
  exact ((Equiv.addRight m).summable_iff).2 ((lp.memℓp f).summable (p := 2) (by norm_num))

/-- The lattice translation `(S_m f) k = f (k + m)`, as a linear map. -/
noncomputable def shiftLin (m : ℤ) : L2Z →ₗ[ℂ] L2Z where
  toFun f := ⟨fun k => (f : ℤ → ℂ) (k + m), memℓp_shift f m⟩
  map_add' f g := by ext k; simp
  map_smul' c f := by ext k; simp

@[simp] theorem shiftLin_apply (m : ℤ) (f : L2Z) (k : ℤ) :
    ((shiftLin m f : L2Z) : ℤ → ℂ) k = (f : ℤ → ℂ) (k + m) := rfl

theorem shiftLin_norm (m : ℤ) (f : L2Z) : ‖shiftLin m f‖ = ‖f‖ := by
  have key : ‖shiftLin m f‖ ^ 2 = ‖f‖ ^ 2 := by
    rw [norm_sq_eq_tsum, norm_sq_eq_tsum]
    exact (Equiv.addRight m).tsum_eq fun k => ‖(f : ℤ → ℂ) k‖ ^ 2
  have hpow : ‖shiftLin m f‖ ^ ((2 : ℕ) : ℝ) = ‖f‖ ^ ((2 : ℕ) : ℝ) := by
    simpa only [Real.rpow_natCast] using key
  exact Real.rpow_left_injOn (x := ((2 : ℕ) : ℝ)) (by norm_num)
    (norm_nonneg _) (norm_nonneg _) hpow

/-- **The lattice translation is a unitary of `ℓ²(ℤ)`.** -/
noncomputable def shiftEquiv (m : ℤ) : L2Z ≃ₗᵢ[ℂ] L2Z where
  toLinearEquiv :=
    { shiftLin m with
      invFun := shiftLin (-m)
      left_inv := fun f => by ext k; simp
      right_inv := fun f => by ext k; simp }
  norm_map' := shiftLin_norm m

/-- The lattice translation as a bounded operator. -/
noncomputable def shiftOp (m : ℤ) : L2Z →L[ℂ] L2Z :=
  (shiftEquiv m).toLinearIsometry.toContinuousLinearMap

@[simp] theorem shiftOp_apply (m : ℤ) (f : L2Z) (k : ℤ) :
    ((shiftOp m f : L2Z) : ℤ → ℂ) k = (f : ℤ → ℂ) (k + m) := rfl

/-- Translations are adjoint to their inverses: `⟪S_m f, g⟫ = ⟪f, S_{-m} g⟫`. -/
theorem inner_shiftOp_left (m : ℤ) (f g : L2Z) :
    ⟪shiftOp m f, g⟫_ℂ = ⟪f, shiftOp (-m) g⟫_ℂ := by
  have h := (shiftEquiv m).inner_map_map f (shiftLin (-m) g)
  have hg : shiftEquiv m (shiftLin (-m) g) = g := by
    ext k
    change (g : ℤ → ℂ) (k + m + -m) = (g : ℤ → ℂ) k
    simp only [add_neg_cancel_right]
  rw [hg] at h
  exact h

/-! ## The momentum operator -/

/-- The **symmetric-difference momentum** on the infinite lattice:
`(p f) k = -(i/2) (f (k+1) - f (k-1))`. -/
noncomputable def momentum : L2Z →L[ℂ] L2Z :=
  (-Complex.I / 2) • (shiftOp 1 - shiftOp (-1))

theorem momentum_apply (f : L2Z) (k : ℤ) :
    ((momentum f : L2Z) : ℤ → ℂ) k
      = (-Complex.I / 2) * ((f : ℤ → ℂ) (k + 1) - (f : ℤ → ℂ) (k - 1)) := by
  simp only [momentum, ContinuousLinearMap.smul_apply, ContinuousLinearMap.sub_apply,
    lp.coeFn_smul, lp.coeFn_sub, Pi.smul_apply, Pi.sub_apply, smul_eq_mul, shiftOp_apply]
  congr 2

/-- **The momentum operator is self-adjoint.** -/
theorem momentum_isSymmetric : (momentum : L2Z →ₗ[ℂ] L2Z).IsSymmetric := by
  intro f g
  have h1 := inner_shiftOp_left 1 f g
  have h2 := inner_shiftOp_left (-1) f g
  simp only [momentum, ContinuousLinearMap.coe_coe, ContinuousLinearMap.smul_apply,
    ContinuousLinearMap.sub_apply, inner_smul_left, inner_smul_right, inner_sub_left,
    inner_sub_right, h1, h2, neg_neg]
  simp only [map_div₀, map_neg, Complex.conj_I, Complex.conj_ofNat]
  ring

theorem momentum_isSelfAdjoint : IsSelfAdjoint momentum :=
  ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric.2 momentum_isSymmetric

/-! ## The velocity (multiplication) operator -/

theorem velocity_bound (v : LinfZ) (k : ℤ) : |(v : ℤ → ℝ) k| ≤ ‖v‖ := by
  simpa [Real.norm_eq_abs] using lp.norm_apply_le_norm (by simp) v k

theorem memℓp_mul (v : LinfZ) (f : L2Z) :
    Memℓp (fun k : ℤ => ((v : ℤ → ℝ) k : ℂ) * (f : ℤ → ℂ) k) 2 := by
  refine memℓp_two_of_summable (Summable.of_nonneg_of_le (fun k => by positivity) (fun k => ?_)
    ((summable_normSq f).mul_left (‖v‖ ^ 2)))
  have hnorm : ‖((v : ℤ → ℝ) k : ℂ) * (f : ℤ → ℂ) k‖ = |(v : ℤ → ℝ) k| * ‖(f : ℤ → ℂ) k‖ := by
    simp [Complex.norm_real]
  rw [hnorm, mul_pow]
  have h1 : |(v : ℤ → ℝ) k| ^ 2 ≤ ‖v‖ ^ 2 := by
    nlinarith [abs_nonneg ((v : ℤ → ℝ) k), velocity_bound v k]
  nlinarith [sq_nonneg ‖(f : ℤ → ℂ) k‖]

/-- Multiplication by a bounded real velocity field, as a linear map. -/
noncomputable def velocityLin (v : LinfZ) : L2Z →ₗ[ℂ] L2Z where
  toFun f := ⟨fun k => ((v : ℤ → ℝ) k : ℂ) * (f : ℤ → ℂ) k, memℓp_mul v f⟩
  map_add' f g := by ext k; simp [mul_add]
  map_smul' c f := by
    ext k
    simp only [lp.coeFn_smul, Pi.smul_apply, smul_eq_mul, RingHom.id_apply]
    ring

@[simp] theorem velocityLin_apply (v : LinfZ) (f : L2Z) (k : ℤ) :
    ((velocityLin v f : L2Z) : ℤ → ℂ) k = ((v : ℤ → ℝ) k : ℂ) * (f : ℤ → ℂ) k := rfl

theorem velocityLin_norm_le (v : LinfZ) (f : L2Z) : ‖velocityLin v f‖ ≤ ‖v‖ * ‖f‖ := by
  refine lp.norm_le_of_tsum_le (by norm_num) (by positivity) ?_
  rw [show (2 : ℝ≥0∞).toReal = ((2 : ℕ) : ℝ) from by norm_num]
  simp only [Real.rpow_natCast]
  have hle : ∀ k : ℤ, ‖((velocityLin v f : L2Z) : ℤ → ℂ) k‖ ^ 2
      ≤ ‖v‖ ^ 2 * ‖(f : ℤ → ℂ) k‖ ^ 2 := by
    intro k
    have hnorm : ‖((velocityLin v f : L2Z) : ℤ → ℂ) k‖ = |(v : ℤ → ℝ) k| * ‖(f : ℤ → ℂ) k‖ := by
      simp [Complex.norm_real]
    rw [hnorm, mul_pow]
    have h1 : |(v : ℤ → ℝ) k| ^ 2 ≤ ‖v‖ ^ 2 := by
      nlinarith [abs_nonneg ((v : ℤ → ℝ) k), velocity_bound v k]
    nlinarith [sq_nonneg ‖(f : ℤ → ℂ) k‖]
  calc ∑' k : ℤ, ‖((velocityLin v f : L2Z) : ℤ → ℂ) k‖ ^ 2
      ≤ ∑' k : ℤ, ‖v‖ ^ 2 * ‖(f : ℤ → ℂ) k‖ ^ 2 :=
        Summable.tsum_le_tsum hle (summable_normSq _) ((summable_normSq f).mul_left _)
    _ = ‖v‖ ^ 2 * ∑' k : ℤ, ‖(f : ℤ → ℂ) k‖ ^ 2 := tsum_mul_left
    _ = (‖v‖ * ‖f‖) ^ 2 := by rw [← norm_sq_eq_tsum]; ring

/-- The **velocity operator**: multiplication by a bounded real field `v`. -/
noncomputable def velocityOp (v : LinfZ) : L2Z →L[ℂ] L2Z :=
  LinearMap.mkContinuous (velocityLin v) ‖v‖ (velocityLin_norm_le v)

@[simp] theorem velocityOp_apply (v : LinfZ) (f : L2Z) (k : ℤ) :
    ((velocityOp v f : L2Z) : ℤ → ℂ) k = ((v : ℤ → ℝ) k : ℂ) * (f : ℤ → ℂ) k := rfl

theorem velocityOp_isSymmetric (v : LinfZ) :
    (velocityOp v : L2Z →ₗ[ℂ] L2Z).IsSymmetric := by
  intro f g
  rw [lp.inner_eq_tsum, lp.inner_eq_tsum]
  refine tsum_congr fun k => ?_
  simp only [ContinuousLinearMap.coe_coe, velocityOp_apply, RCLike.inner_apply, map_mul,
    Complex.conj_ofReal]
  ring

theorem velocityOp_isSelfAdjoint (v : LinfZ) : IsSelfAdjoint (velocityOp v) :=
  ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric.2 (velocityOp_isSymmetric v)

/-! ## The Weyl-symmetrized continuity generator -/

/-- The **Weyl-symmetrized continuity generator** `H = ½ (p·v + v·p)` on
`ℓ²(ℤ)`: a bounded operator, self-adjoint precisely because of the
symmetrization. -/
noncomputable def continuityHamiltonian (v : LinfZ) : L2Z →L[ℂ] L2Z :=
  (1 / 2 : ℂ) • (momentum.comp (velocityOp v) + (velocityOp v).comp momentum)

theorem continuityHamiltonian_isSymmetric (v : LinfZ) :
    (continuityHamiltonian v : L2Z →ₗ[ℂ] L2Z).IsSymmetric := by
  intro f g
  have hp1 : ⟪momentum ((velocityOp v) f), g⟫_ℂ = ⟪(velocityOp v) f, momentum g⟫_ℂ :=
    momentum_isSymmetric _ _
  have hv1 : ⟪(velocityOp v) f, momentum g⟫_ℂ = ⟪f, (velocityOp v) (momentum g)⟫_ℂ :=
    velocityOp_isSymmetric v _ _
  have hv2 : ⟪(velocityOp v) (momentum f), g⟫_ℂ = ⟪momentum f, (velocityOp v) g⟫_ℂ :=
    velocityOp_isSymmetric v _ _
  have hp2 : ⟪momentum f, (velocityOp v) g⟫_ℂ = ⟪f, momentum ((velocityOp v) g)⟫_ℂ :=
    momentum_isSymmetric _ _
  simp only [continuityHamiltonian, ContinuousLinearMap.coe_coe,
    ContinuousLinearMap.smul_apply, ContinuousLinearMap.add_apply,
    ContinuousLinearMap.coe_comp', Function.comp_apply, inner_smul_left, inner_smul_right,
    inner_add_left, inner_add_right]
  rw [hp1, hv1, hv2, hp2]
  simp only [map_div₀, map_one, Complex.conj_ofNat]
  ring

/-- **The Weyl-symmetrized generator is self-adjoint** — the infinite-lattice
counterpart of `ChapterContinuityUnitary.continuityHamiltonian_hermitian`. -/
theorem continuityHamiltonian_isSelfAdjoint (v : LinfZ) :
    IsSelfAdjoint (continuityHamiltonian v) :=
  ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric.2 (continuityHamiltonian_isSymmetric v)

/-! ## The one-parameter unitary group -/

/-- `exp (i t A)` is unitary for a bounded self-adjoint `A` on a Hilbert space —
the operator-algebra counterpart of `ChapterContinuityUnitary.exp_smul_I_unitary`. -/
theorem exp_smul_I_unitary {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
    [CompleteSpace E] (A : E →L[ℂ] E) (hA : IsSelfAdjoint A) (t : ℝ) :
    star (NormedSpace.exp (((t : ℂ) * Complex.I) • A)) *
        NormedSpace.exp (((t : ℂ) * Complex.I) • A) = 1 ∧
      NormedSpace.exp (((t : ℂ) * Complex.I) • A) *
        star (NormedSpace.exp (((t : ℂ) * Complex.I) • A)) = 1 := by
  let +nondep : NormedAlgebra ℚ (E →L[ℂ] E) := .restrictScalars ℚ ℂ _
  set B : E →L[ℂ] E := ((t : ℂ) * Complex.I) • A with hB
  have hstar : star B = -B := by
    rw [hB, star_smul, hA.star_eq]
    simp [RCLike.star_def, ← neg_smul]
  have hexp : star (NormedSpace.exp B) = NormedSpace.exp (-B) := by
    rw [NormedSpace.star_exp, hstar]
  refine ⟨?_, ?_⟩
  · rw [hexp, ← NormedSpace.exp_add_of_commute (Commute.neg_left (Commute.refl B)),
      neg_add_cancel, NormedSpace.exp_zero]
  · rw [hexp, ← NormedSpace.exp_add_of_commute (Commute.neg_right (Commute.refl B)),
      add_neg_cancel, NormedSpace.exp_zero]

/-- The **dynamics-based unitary on the infinite lattice**: `U t = exp (i t H)`
for the continuity generator `H` of the bounded velocity field `v`. -/
noncomputable def continuityUnitary (v : LinfZ) (t : ℝ) : L2Z →L[ℂ] L2Z :=
  NormedSpace.exp (((t : ℂ) * Complex.I) • continuityHamiltonian v)

/-- **`U t` is unitary.** -/
theorem continuityUnitary_unitary (v : LinfZ) (t : ℝ) :
    star (continuityUnitary v t) * continuityUnitary v t = 1 ∧
      continuityUnitary v t * star (continuityUnitary v t) = 1 :=
  exp_smul_I_unitary _ (continuityHamiltonian_isSelfAdjoint v) t

theorem continuityUnitary_zero (v : LinfZ) : continuityUnitary v 0 = 1 := by
  simp [continuityUnitary]

/-- `U` is a one-parameter group: `U (s + t) = U s ∘ U t`. -/
theorem continuityUnitary_add (v : LinfZ) (s t : ℝ) :
    continuityUnitary v (s + t) = continuityUnitary v s * continuityUnitary v t := by
  let +nondep : NormedAlgebra ℚ (L2Z →L[ℂ] L2Z) := .restrictScalars ℚ ℂ _
  have hcomm : Commute (((s : ℂ) * Complex.I) • continuityHamiltonian v)
      (((t : ℂ) * Complex.I) • continuityHamiltonian v) := by
    simp [Commute, SemiconjBy, smul_smul, mul_comm]
  have hsum : (((s + t : ℝ) : ℂ) * Complex.I) • continuityHamiltonian v
      = ((s : ℂ) * Complex.I) • continuityHamiltonian v
        + ((t : ℂ) * Complex.I) • continuityHamiltonian v := by
    rw [← add_smul]
    push_cast
    ring_nf
  rw [continuityUnitary, hsum, NormedSpace.exp_add_of_commute hcomm]
  rfl

/-- A unitary preserves the norm — hence the total `ℓ²` mass. -/
theorem norm_of_unitary {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
    [CompleteSpace E] (U : E →L[ℂ] E) (hU : star U * U = 1) (x : E) : ‖U x‖ = ‖x‖ := by
  have hinner : ⟪U x, U x⟫_ℂ = ⟪x, x⟫_ℂ := by
    rw [← ContinuousLinearMap.adjoint_inner_left]
    rw [← ContinuousLinearMap.star_eq_adjoint]
    rw [show (star U) (U x) = ((star U) * U) x from rfl, hU]
    rfl
  have h := congrArg Complex.re hinner
  simp only [inner_self_eq_norm_sq_to_K] at h
  have h' : ‖U x‖ ^ 2 = ‖x‖ ^ 2 := by exact_mod_cast h
  nlinarith [norm_nonneg (U x), norm_nonneg x]

/-! ## Born recovery: a countably additive probability law on the lattice -/

/-- The state evolved for time `t` by the dynamics-based unitary. -/
noncomputable def evolvedState (v : LinfZ) (t : ℝ) (psi : L2Z) : L2Z :=
  continuityUnitary v t psi

/-- The Born weight of a set `B` of lattice sites in the evolved state. -/
noncomputable def bornRecover (v : LinfZ) (t : ℝ) (psi : L2Z) (B : Finset ℤ) : ℝ :=
  ∑ z ∈ B, ‖((evolvedState v t psi : L2Z) : ℤ → ℂ) z‖ ^ 2

theorem bornRecover_nonneg (v : LinfZ) (t : ℝ) (psi : L2Z) (B : Finset ℤ) :
    0 ≤ bornRecover v t psi B :=
  Finset.sum_nonneg fun _ _ => by positivity

theorem bornRecover_empty (v : LinfZ) (t : ℝ) (psi : L2Z) : bornRecover v t psi ∅ = 0 := by
  simp [bornRecover]

theorem bornRecover_union (v : LinfZ) (t : ℝ) (psi : L2Z) {B C : Finset ℤ}
    (h : Disjoint B C) :
    bornRecover v t psi (B ∪ C) = bornRecover v t psi B + bornRecover v t psi C := by
  simp [bornRecover, Finset.sum_union h]

theorem bornRecover_mono (v : LinfZ) (t : ℝ) (psi : L2Z) {B C : Finset ℤ} (h : B ⊆ C) :
    bornRecover v t psi B ≤ bornRecover v t psi C :=
  Finset.sum_le_sum_of_subset_of_nonneg h fun _ _ _ => by positivity

/-- The evolved state has the same `ℓ²` mass as the initial state. -/
theorem norm_evolvedState (v : LinfZ) (t : ℝ) (psi : L2Z) :
    ‖evolvedState v t psi‖ = ‖psi‖ :=
  norm_of_unitary _ (continuityUnitary_unitary v t).1 psi

/-- **Born recovery: the total mass is `1`.**  On the infinite lattice this is a
countable sum, and unitarity of `U t` makes it exactly `1` for a normalized
initial state. -/
theorem bornRecover_tsum_univ (v : LinfZ) (t : ℝ) (psi : L2Z) (hpsi : ‖psi‖ = 1) :
    ∑' z : ℤ, ‖((evolvedState v t psi : L2Z) : ℤ → ℂ) z‖ ^ 2 = 1 := by
  rw [← norm_sq_eq_tsum, norm_evolvedState, hpsi, one_pow]

theorem summable_bornWeight (v : LinfZ) (t : ℝ) (psi : L2Z) :
    Summable fun z : ℤ => ‖((evolvedState v t psi : L2Z) : ℤ → ℂ) z‖ ^ 2 :=
  summable_normSq _

/-- The Born weights of the evolved state, as a probability distribution on the
infinite lattice `ℤ`. -/
noncomputable def bornPMF (v : LinfZ) (t : ℝ) (psi : L2Z) (hpsi : ‖psi‖ = 1) : PMF ℤ :=
  ⟨fun z => ENNReal.ofReal (‖((evolvedState v t psi : L2Z) : ℤ → ℂ) z‖ ^ 2), by
    have hns : ∀ z : ℤ, 0 ≤ ‖((evolvedState v t psi : L2Z) : ℤ → ℂ) z‖ ^ 2 := fun _ => by positivity
    have htsum : ∑' z : ℤ, ENNReal.ofReal (‖((evolvedState v t psi : L2Z) : ℤ → ℂ) z‖ ^ 2) = 1 := by
      rw [← ENNReal.ofReal_tsum_of_nonneg hns (summable_bornWeight v t psi),
        bornRecover_tsum_univ v t psi hpsi, ENNReal.ofReal_one]
    exact htsum ▸ ENNReal.summable.hasSum⟩

@[simp] theorem bornPMF_apply (v : LinfZ) (t : ℝ) (psi : L2Z) (hpsi : ‖psi‖ = 1) (z : ℤ) :
    bornPMF v t psi hpsi z
      = ENNReal.ofReal (‖((evolvedState v t psi : L2Z) : ℤ → ℂ) z‖ ^ 2) := rfl

/-! ## The capstone -/

variable {X : Type*}

/-- **Capstone (infinite lattice).**  A family of bounded velocity fields `v x`
on `ℤ`, together with normalized initial states `psi x`, determines by the
dynamics-based unitary — and by *no* basis choice — a genuine conditional
probability law `z ↦ |Ψ_t(x, z)|²` on the infinite lattice for every input `x`:
it is a countably additive probability measure whose mass on a finite set `B` of
sites is the Born weight `bornRecover`. -/
theorem condProb_of_continuity_infinite (v : X → LinfZ) (t : ℝ) (psi : X → L2Z)
    (hpsi : ∀ x, ‖psi x‖ = 1) (x : X) :
    (∑' z : ℤ, bornPMF (v x) t (psi x) (hpsi x) z) = 1 ∧
      ∀ B : Finset ℤ,
        ∑ z ∈ B, bornPMF (v x) t (psi x) (hpsi x) z
          = ENNReal.ofReal (bornRecover (v x) t (psi x) B) := by
  refine ⟨(bornPMF (v x) t (psi x) (hpsi x)).tsum_coe, fun B => ?_⟩
  rw [bornRecover, ENNReal.ofReal_sum_of_nonneg (fun _ _ => by positivity)]
  exact Finset.sum_congr rfl fun z _ => bornPMF_apply _ _ _ _ z

end BookProof.ChapterContinuityUnitaryInfinite

/-! ## Cross-chapter definitions from `BookProof.ChapterUnboundedPosition` -/
def adjointDomain (f : ℤ → ℝ) : Set L2Z :=
  {phi | ∃ eta : L2Z, ∀ psi : mulDomain f, ⟪mulOp f psi, phi⟫_ℂ = ⟪(psi : L2Z), eta⟫_ℂ}

/-- **The maximal multiplication operator is self-adjoint**: the adjoint domain is
exactly the natural domain.  In particular the lattice position operator — densely
defined, symmetric and unbounded — is a *self-adjoint* observable, not merely a
symmetric one. -/
theorem adjointDomain_eq_mulDomain (f : ℤ → ℝ) :
    adjointDomain f = ((mulDomain f : Submodule ℂ L2Z) : Set L2Z) := by
  ext phi
  constructor
  · rintro ⟨eta, h⟩
    exact (mulOp_adjoint_apply f h).2
  · intro hphi
    exact ⟨mulOp f ⟨phi, hphi⟩, fun psi => mulOp_symmetric f psi ⟨phi, hphi⟩⟩

/-- ... and on that domain the adjoint *is* the operator: any `η` implementing the
adjoint pairing equals `f·φ`. -/
theorem adjoint_eq_mulOp (f : ℤ → ℝ) {phi eta : L2Z} (hphi : phi ∈ mulDomain f)
    (h : ∀ psi : mulDomain f, ⟪mulOp f psi, phi⟫_ℂ = ⟪(psi : L2Z), eta⟫_ℂ) :
    eta = mulOp f ⟨phi, hphi⟩ := by
  refine lp.ext (funext fun k => ?_)
  exact ((mulOp_adjoint_apply f h).1 k).symm

/-- The position operator is not the restriction of any bounded operator on
`ℓ²(ℤ)`: a bounded operator would supply exactly the constant that
`position_unbounded` forbids. -/
theorem position_not_boundedOperator :
    ¬ ∃ T : L2Z →L[ℂ] L2Z, ∀ psi : mulDomain positionField,
      mulOp positionField psi = T (psi : L2Z) := by
  rintro ⟨T, hT⟩
  refine position_unbounded ⟨‖T‖, fun psi => ?_⟩
  rw [hT psi]
  exact T.le_opNorm _

/-! ## The unitary group generated by the multiplication operator -/

/-- The phase `e^{i t f k}` of the group generated by multiplication by `f`. -/
noncomputable def phase (f : ℤ → ℝ) (t : ℝ) (k : ℤ) : ℂ :=
  Complex.exp (Complex.I * ((t * f k : ℝ) : ℂ))

theorem norm_phase (f : ℤ → ℝ) (t : ℝ) (k : ℤ) : ‖phase f t k‖ = 1 :=
  Complex.norm_exp_I_mul_ofReal _

theorem continuous_phase (f : ℤ → ℝ) (k : ℤ) : Continuous fun t : ℝ => phase f t k := by
  unfold phase
  fun_prop

theorem memℓp_phase (f : ℤ → ℝ) (t : ℝ) (psi : L2Z) :
    Memℓp (fun k => phase f t k * (psi : ℤ → ℂ) k) 2 := by
  refine BookProof.ChapterContinuityUnitaryInfinite.memℓp_two_of_summable ?_
  have h : ∀ k : ℤ, ‖phase f t k * (psi : ℤ → ℂ) k‖ ^ 2 = ‖(psi : ℤ → ℂ) k‖ ^ 2 := by
    intro k
    rw [norm_mul, norm_phase, one_mul]
  simpa only [h] using BookProof.ChapterContinuityUnitaryInfinite.summable_normSq psi

/-- Multiplication by the phase `e^{i t f}`, as a linear map. -/
noncomputable def phaseLin (f : ℤ → ℝ) (t : ℝ) : L2Z →ₗ[ℂ] L2Z where
  toFun psi := ⟨fun k => phase f t k * (psi : ℤ → ℂ) k, memℓp_phase f t psi⟩
  map_add' a b := by ext k; simp [mul_add]
  map_smul' c a := by
    ext k
    simp only [lp.coeFn_smul, Pi.smul_apply, smul_eq_mul, RingHom.id_apply]
    ring

@[simp] theorem phaseLin_apply (f : ℤ → ℝ) (t : ℝ) (psi : L2Z) (k : ℤ) :
    ((phaseLin f t psi : L2Z) : ℤ → ℂ) k = phase f t k * (psi : ℤ → ℂ) k := rfl

theorem phaseLin_add (f : ℤ → ℝ) (s t : ℝ) (psi : L2Z) :
    phaseLin f s (phaseLin f t psi) = phaseLin f (s + t) psi := by
  ext k
  simp only [phaseLin_apply, phase, ← mul_assoc, ← Complex.exp_add]
  congr 2
  push_cast
  ring

theorem phaseLin_zero (f : ℤ → ℝ) (psi : L2Z) : phaseLin f 0 psi = psi := by
  ext k
  simp [phase]

theorem phaseLin_norm (f : ℤ → ℝ) (t : ℝ) (psi : L2Z) : ‖phaseLin f t psi‖ = ‖psi‖ := by
  have key : ‖phaseLin f t psi‖ ^ 2 = ‖psi‖ ^ 2 := by
    rw [BookProof.ChapterContinuityUnitaryInfinite.norm_sq_eq_tsum,
      BookProof.ChapterContinuityUnitaryInfinite.norm_sq_eq_tsum]
    refine tsum_congr fun k => ?_
    rw [phaseLin_apply, norm_mul, norm_phase, one_mul]
  have hpow : ‖phaseLin f t psi‖ ^ ((2 : ℕ) : ℝ) = ‖psi‖ ^ ((2 : ℕ) : ℝ) := by
    simpa only [Real.rpow_natCast] using key
  exact Real.rpow_left_injOn (x := ((2 : ℕ) : ℝ)) (by norm_num)
    (norm_nonneg _) (norm_nonneg _) hpow

/-- **The unitary group `U t = e^{i t f}` generated by multiplication by `f`.**
Every `U t` is a unitary of `ℓ²(ℤ)` — for the position field this is the group
generated by an *unbounded* self-adjoint observable. -/
noncomputable def phaseUnitary (f : ℤ → ℝ) (t : ℝ) : L2Z ≃ₗᵢ[ℂ] L2Z where
  toLinearEquiv :=
    { phaseLin f t with
      invFun := phaseLin f (-t)
      left_inv := fun psi => by
        change phaseLin f (-t) (phaseLin f t psi) = psi
        rw [phaseLin_add, neg_add_cancel, phaseLin_zero]
      right_inv := fun psi => by
        change phaseLin f t (phaseLin f (-t) psi) = psi
        rw [phaseLin_add, add_neg_cancel, phaseLin_zero] }
  norm_map' := phaseLin_norm f t

@[simp] theorem phaseUnitary_apply (f : ℤ → ℝ) (t : ℝ) (psi : L2Z) :
    phaseUnitary f t psi = phaseLin f t psi := rfl

theorem phaseUnitary_zero (f : ℤ → ℝ) (psi : L2Z) : phaseUnitary f 0 psi = psi :=
  phaseLin_zero f psi

/-- The one-parameter group law. -/
theorem phaseUnitary_add (f : ℤ → ℝ) (s t : ℝ) (psi : L2Z) :
    phaseUnitary f (s + t) psi = phaseUnitary f s (phaseUnitary f t psi) :=
  (phaseLin_add f s t psi).symm

/-- **Strong continuity at `0`.**  Although the generator is unbounded, the group
is strongly continuous: `U t ψ → ψ` in `ℓ²(ℤ)` as `t → 0`, for *every* state — no
domain hypothesis. -/
theorem tendsto_phaseUnitary (f : ℤ → ℝ) (psi : L2Z) :
    Filter.Tendsto (fun t : ℝ => phaseUnitary f t psi) (nhds 0) (nhds psi) := by
  rw [tendsto_iff_norm_sub_tendsto_zero]
  have hsq : ∀ t : ℝ, ‖phaseUnitary f t psi - psi‖ ^ 2
      = ∑' k : ℤ, ‖(phase f t k - 1) * (psi : ℤ → ℂ) k‖ ^ 2 := by
    intro t
    rw [BookProof.ChapterContinuityUnitaryInfinite.norm_sq_eq_tsum]
    refine tsum_congr fun k => ?_
    congr 1
    simp [sub_mul]
  have hbound : Summable fun k : ℤ => 4 * ‖(psi : ℤ → ℂ) k‖ ^ 2 :=
    (BookProof.ChapterContinuityUnitaryInfinite.summable_normSq psi).mul_left 4
  have hpt : ∀ k : ℤ, Filter.Tendsto
      (fun t : ℝ => ‖(phase f t k - 1) * (psi : ℤ → ℂ) k‖ ^ 2) (nhds 0) (nhds 0) := by
    intro k
    have hc : Continuous fun t : ℝ => ‖(phase f t k - 1) * (psi : ℤ → ℂ) k‖ ^ 2 :=
      (((continuous_phase f k).sub continuous_const).mul continuous_const).norm.pow 2
    simpa [phase] using hc.tendsto 0
  have hdom : ∀ t : ℝ, ∀ k : ℤ,
      ‖‖(phase f t k - 1) * (psi : ℤ → ℂ) k‖ ^ 2‖ ≤ 4 * ‖(psi : ℤ → ℂ) k‖ ^ 2 := by
    intro t k
    have h1 : ‖phase f t k - 1‖ ≤ 2 := by
      calc ‖phase f t k - 1‖ ≤ ‖phase f t k‖ + ‖(1 : ℂ)‖ := norm_sub_le _ _
        _ = 2 := by rw [norm_phase]; norm_num
    have h2 : ‖(phase f t k - 1) * (psi : ℤ → ℂ) k‖ ≤ 2 * ‖(psi : ℤ → ℂ) k‖ := by
      rw [norm_mul]
      exact mul_le_mul_of_nonneg_right h1 (norm_nonneg _)
    rw [Real.norm_eq_abs, abs_of_nonneg (by positivity)]
    nlinarith [norm_nonneg ((phase f t k - 1) * (psi : ℤ → ℂ) k), norm_nonneg ((psi : ℤ → ℂ) k)]
  have htsum := tendsto_tsum_of_dominated_convergence hbound hpt
    (Filter.Eventually.of_forall hdom)
  rw [tsum_zero] at htsum
  have hsqrt : Filter.Tendsto
      (fun t : ℝ => Real.sqrt (∑' k : ℤ, ‖(phase f t k - 1) * (psi : ℤ → ℂ) k‖ ^ 2))
      (nhds 0) (nhds 0) := by
    simpa using (Real.continuous_sqrt.tendsto 0).comp htsum
  refine hsqrt.congr fun t => ?_
  rw [← hsq t, Real.sqrt_sq (norm_nonneg _)]

/-- The phase has the expected derivative in `t`. -/
theorem hasDerivAt_phase (f : ℤ → ℝ) (k : ℤ) :
    HasDerivAt (fun t : ℝ => phase f t k) (Complex.I * f k) 0 := by
  have h1 : HasDerivAt (fun t : ℝ => Complex.I * ((t * f k : ℝ) : ℂ)) (Complex.I * f k) 0 := by
    have h0 : HasDerivAt (fun t : ℝ => ((t * f k : ℝ) : ℂ)) ((f k : ℂ)) 0 := by
      simpa using ((hasDerivAt_id (0 : ℝ)).mul_const (f k)).ofReal_comp
    simpa [mul_comm] using h0.const_mul Complex.I
  simpa [phase] using h1.cexp

theorem tendsto_slope_phase (f : ℤ → ℝ) (k : ℤ) :
    Filter.Tendsto (fun t : ℝ => (t⁻¹ : ℝ) • (phase f t k - 1)) (nhdsWithin 0 {0}ᶜ)
      (nhds (Complex.I * f k)) := by
  have h := hasDerivAt_iff_tendsto_slope.1 (hasDerivAt_phase f k)
  refine h.congr fun t => ?_
  simp [slope, vsub_eq_sub, phase]

/-- **The multiplication operator is the generator of its phase group.**  For a
state in the natural domain the difference quotient of `U t ψ` converges *in
`ℓ²(ℤ)`* to `i·f·ψ` — Stone's relation `dU/dt|₀ = iA`, here for an unbounded
self-adjoint `A`. -/
theorem tendsto_slope_phaseUnitary (f : ℤ → ℝ) (psi : mulDomain f) :
    Filter.Tendsto (fun t : ℝ => (t⁻¹ : ℝ) • (phaseUnitary f t (psi : L2Z) - (psi : L2Z)))
      (nhdsWithin 0 {0}ᶜ) (nhds (Complex.I • mulOp f psi)) := by
  rw [tendsto_iff_norm_sub_tendsto_zero]
  set g : ℤ → ℂ := fun k => (psi : L2Z) k with hg
  have hsq : ∀ t : ℝ,
      ‖(t⁻¹ : ℝ) • (phaseUnitary f t (psi : L2Z) - (psi : L2Z)) - Complex.I • mulOp f psi‖ ^ 2
        = ∑' k : ℤ, ‖((t⁻¹ : ℝ) • (phase f t k - 1)) * g k - Complex.I * (f k : ℂ) * g k‖ ^ 2 := by
    intro t
    rw [BookProof.ChapterContinuityUnitaryInfinite.norm_sq_eq_tsum]
    refine tsum_congr fun k => ?_
    congr 1
    simp only [lp.coeFn_sub, lp.coeFn_smul, Pi.sub_apply, Pi.smul_apply, smul_eq_mul,
      phaseUnitary_apply, phaseLin_apply, mulOp_apply, Complex.real_smul, hg]
    ring
  have hfpsi : Summable fun k : ℤ => ‖(f k : ℂ) * g k‖ ^ 2 := by
    simpa [hg] using
      BookProof.ChapterContinuityUnitaryInfinite.summable_normSq (mulOp f psi)
  have hbound : Summable fun k : ℤ => 4 * ‖(f k : ℂ) * g k‖ ^ 2 := hfpsi.mul_left 4
  have hpt : ∀ k : ℤ, Filter.Tendsto
      (fun t : ℝ => ‖((t⁻¹ : ℝ) • (phase f t k - 1)) * g k - Complex.I * (f k : ℂ) * g k‖ ^ 2)
      (nhdsWithin 0 {0}ᶜ) (nhds 0) := by
    intro k
    have h1 := (tendsto_slope_phase f k).mul_const (g k)
    have h2 : Filter.Tendsto
        (fun t : ℝ => ((t⁻¹ : ℝ) • (phase f t k - 1)) * g k - Complex.I * (f k : ℂ) * g k)
        (nhdsWithin 0 {0}ᶜ) (nhds 0) := by
      have := h1.sub_const (Complex.I * (f k : ℂ) * g k)
      simpa [mul_assoc] using this
    simpa using (h2.norm.pow 2)
  have hdom : ∀ t : ℝ, ∀ k : ℤ,
      ‖‖((t⁻¹ : ℝ) • (phase f t k - 1)) * g k - Complex.I * (f k : ℂ) * g k‖ ^ 2‖
        ≤ 4 * ‖(f k : ℂ) * g k‖ ^ 2 := by
    intro t k
    have hph : ‖((t⁻¹ : ℝ) • (phase f t k - 1))‖ ≤ |f k| := by
      rcases eq_or_ne t 0 with rfl | ht
      · simp
      · have hbase : ‖phase f t k - 1‖ ≤ |t * f k| := by
          simpa [phase, Real.norm_eq_abs] using
            (Real.norm_exp_I_mul_ofReal_sub_one_le (x := t * f k))
        rw [norm_smul, Real.norm_eq_abs, abs_inv]
        calc |t|⁻¹ * ‖phase f t k - 1‖ ≤ |t|⁻¹ * |t * f k| :=
              mul_le_mul_of_nonneg_left hbase (by positivity)
          _ = |f k| := by
              rw [abs_mul, ← mul_assoc, inv_mul_cancel₀ (abs_ne_zero.2 ht), one_mul]
    have h1 : ‖((t⁻¹ : ℝ) • (phase f t k - 1)) * g k - Complex.I * (f k : ℂ) * g k‖
        ≤ 2 * ‖(f k : ℂ) * g k‖ := by
      have e1 : ‖((t⁻¹ : ℝ) • (phase f t k - 1)) * g k‖ ≤ |f k| * ‖g k‖ := by
        rw [norm_mul]
        exact mul_le_mul_of_nonneg_right hph (norm_nonneg _)
      have e2 : ‖Complex.I * (f k : ℂ) * g k‖ = |f k| * ‖g k‖ := by
        simp [Complex.norm_real, Real.norm_eq_abs, mul_assoc]
      have e3 : ‖(f k : ℂ) * g k‖ = |f k| * ‖g k‖ := by
        simp [Complex.norm_real, Real.norm_eq_abs]
      calc ‖((t⁻¹ : ℝ) • (phase f t k - 1)) * g k - Complex.I * (f k : ℂ) * g k‖
          ≤ ‖((t⁻¹ : ℝ) • (phase f t k - 1)) * g k‖ + ‖Complex.I * (f k : ℂ) * g k‖ :=
            norm_sub_le _ _
        _ ≤ |f k| * ‖g k‖ + |f k| * ‖g k‖ := by rw [e2]; linarith
        _ = 2 * ‖(f k : ℂ) * g k‖ := by rw [e3]; ring
    rw [Real.norm_eq_abs, abs_of_nonneg (by positivity)]
    nlinarith [norm_nonneg (((t⁻¹ : ℝ) • (phase f t k - 1)) * g k -
      Complex.I * (f k : ℂ) * g k), norm_nonneg ((f k : ℂ) * g k)]
  have htsum := tendsto_tsum_of_dominated_convergence hbound hpt
    (Filter.Eventually.of_forall hdom)
  rw [tsum_zero] at htsum
  have hsqrt : Filter.Tendsto
      (fun t : ℝ => Real.sqrt (∑' k : ℤ,
        ‖((t⁻¹ : ℝ) • (phase f t k - 1)) * g k - Complex.I * (f k : ℂ) * g k‖ ^ 2))
      (nhdsWithin 0 {0}ᶜ) (nhds 0) := by
    simpa using (Real.continuous_sqrt.tendsto 0).comp htsum
  refine hsqrt.congr fun t => ?_
  rw [← hsq t, Real.sqrt_sq (norm_nonneg _)]

end BookProof.ChapterUnboundedPosition

/-! ## Cross-chapter definitions from `BookProof.ChapterUnitaryTransport` -/
def IsSelfAdjointOn (D : Submodule ℂ H) (A : D →ₗ[ℂ] H) : Prop :=
  adjointDomain D A = (D : Set H)

theorem inner_map_symm (W : H ≃ₗᵢ[ℂ] K) (x : H) (y : K) :
    ⟪W x, y⟫_ℂ = ⟪x, W.symm y⟫_ℂ := by
  conv_lhs => rw [← W.apply_symm_apply y]
  exact W.inner_map_map _ _

theorem map_real_smul (W : H ≃ₗᵢ[ℂ] K) (r : ℝ) (x : H) : W (r • x) = r • W x := by
  rw [← Complex.coe_smul, ← Complex.coe_smul, map_smul]

/-! ## Transporting the domain and the operator -/

/-- The transported domain `W(D) ⊆ K`. -/
def transportDomain (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) : Submodule ℂ K :=
  D.map (W.toLinearEquiv : H →ₗ[ℂ] K)

theorem coe_transportDomain (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) :
    ((transportDomain W D : Submodule ℂ K) : Set K) = W '' (D : Set H) := rfl

/-- `W` restricts to a linear equivalence `D ≃ W(D)`. -/
noncomputable def transportEquiv (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) :
    D ≃ₗ[ℂ] transportDomain W D :=
  W.toLinearEquiv.submoduleMap D

@[simp] theorem transportEquiv_coe (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (x : D) :
    ((transportEquiv W D x : transportDomain W D) : K) = W (x : H) := rfl

/-- The **transported operator** `W A W⁻¹`, defined on `W(D)`. -/
noncomputable def transportOp (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H) :
    transportDomain W D →ₗ[ℂ] K :=
  (W.toLinearEquiv : H →ₗ[ℂ] K) ∘ₗ A ∘ₗ ((transportEquiv W D).symm : transportDomain W D →ₗ[ℂ] D)

theorem transportOp_apply (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H) (x : D) :
    transportOp W D A (transportEquiv W D x) = W (A x) := by
  simp [transportOp]

/-! ## The structural properties transport -/

/-- A unitary carries a dense domain to a dense domain. -/
theorem transportDomain_dense (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H)
    (hD : Dense ((D : Submodule ℂ H) : Set H)) :
    Dense ((transportDomain W D : Submodule ℂ K) : Set K) := by
  rw [coe_transportDomain]
  exact W.toHomeomorph.isDenseEmbedding.dense_image.2 hD

/-- Symmetry transports. -/
theorem transportOp_symmetric (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H)
    (hA : IsSymmetricOn D A) : IsSymmetricOn (transportDomain W D) (transportOp W D A) := by
  intro y z
  obtain ⟨a, rfl⟩ := (transportEquiv W D).surjective y
  obtain ⟨b, rfl⟩ := (transportEquiv W D).surjective z
  rw [transportOp_apply, transportOp_apply]
  simpa using hA a b

/-- The adjoint domain of the transported operator is the image of the adjoint
domain — the key step, since self-adjointness is an equality of domains. -/
theorem transport_adjointDomain (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H) :
    adjointDomain (transportDomain W D) (transportOp W D A) = W '' adjointDomain D A := by
  ext phi'
  constructor
  · rintro ⟨eta', h⟩
    refine ⟨W.symm phi', ⟨W.symm eta', fun psi => ?_⟩, by simp⟩
    have hkey := h (transportEquiv W D psi)
    rw [transportOp_apply, inner_map_symm] at hkey
    rw [hkey, transportEquiv_coe, inner_map_symm]
  · rintro ⟨phi, ⟨eta, h⟩, rfl⟩
    refine ⟨W eta, fun y => ?_⟩
    obtain ⟨a, rfl⟩ := (transportEquiv W D).surjective y
    rw [transportOp_apply, transportEquiv_coe, W.inner_map_map, W.inner_map_map]
    exact h a

/-- **Self-adjointness transports along a unitary.** -/
theorem transport_isSelfAdjointOn (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H)
    (hA : IsSelfAdjointOn D A) :
    IsSelfAdjointOn (transportDomain W D) (transportOp W D A) := by
  rw [IsSelfAdjointOn, transport_adjointDomain, hA, coe_transportDomain]

/-! ## The unitary group transports -/

/-- The transported unitary `W U W⁻¹`. -/
noncomputable def transportUnitary (W : H ≃ₗᵢ[ℂ] K) (U : H ≃ₗᵢ[ℂ] H) : K ≃ₗᵢ[ℂ] K :=
  (W.symm.trans U).trans W

@[simp] theorem transportUnitary_apply (W : H ≃ₗᵢ[ℂ] K) (U : H ≃ₗᵢ[ℂ] H) (y : K) :
    transportUnitary W U y = W (U (W.symm y)) := rfl

/-- The one-parameter group law transports. -/
theorem transportUnitary_add (W : H ≃ₗᵢ[ℂ] K) (U : ℝ → H ≃ₗᵢ[ℂ] H)
    (h : ∀ s t : ℝ, ∀ x : H, U (s + t) x = U s (U t x)) (s t : ℝ) (y : K) :
    transportUnitary W (U (s + t)) y
      = transportUnitary W (U s) (transportUnitary W (U t) y) := by
  simp [h]

/-- `V 0 = 1` transports. -/
theorem transportUnitary_zero (W : H ≃ₗᵢ[ℂ] K) (U : H ≃ₗᵢ[ℂ] H) (h : ∀ x : H, U x = x)
    (y : K) : transportUnitary W U y = y := by
  simp [h]

/-- **Strong continuity transports.** -/
theorem tendsto_transportUnitary (W : H ≃ₗᵢ[ℂ] K) (U : ℝ → H ≃ₗᵢ[ℂ] H)
    (h : ∀ x : H, Filter.Tendsto (fun t : ℝ => U t x) (nhds 0) (nhds x)) (y : K) :
    Filter.Tendsto (fun t : ℝ => transportUnitary W (U t) y) (nhds 0) (nhds y) := by
  have := (W.continuous.tendsto (W.symm y)).comp (h (W.symm y))
  simpa [Function.comp] using this

/-- **Stone's relation transports**: if `A` generates `U` on `D`, then `W A W⁻¹`
generates `W U W⁻¹` on `W(D)`. -/
theorem tendsto_slope_transportUnitary (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H)
    (U : ℝ → H ≃ₗᵢ[ℂ] H)
    (h : ∀ x : D, Filter.Tendsto (fun t : ℝ => (t⁻¹ : ℝ) • (U t (x : H) - (x : H)))
      (nhdsWithin 0 {0}ᶜ) (nhds (Complex.I • A x)))
    (y : transportDomain W D) :
    Filter.Tendsto (fun t : ℝ => (t⁻¹ : ℝ) • (transportUnitary W (U t) (y : K) - (y : K)))
      (nhdsWithin 0 {0}ᶜ) (nhds (Complex.I • transportOp W D A y)) := by
  obtain ⟨a, rfl⟩ := (transportEquiv W D).surjective y
  rw [transportOp_apply]
  have hW := (W.continuous.tendsto (Complex.I • A a)).comp (h a)
  have hlim : Filter.Tendsto
      (fun t : ℝ => W ((t⁻¹ : ℝ) • (U t (a : H) - (a : H))))
      (nhdsWithin 0 {0}ᶜ) (nhds (W (Complex.I • A a))) := by
    simpa [Function.comp] using hW
  rw [map_smul] at hlim
  refine hlim.congr fun t => ?_
  rw [map_real_smul, map_sub, transportUnitary_apply, transportEquiv_coe,
    LinearIsometryEquiv.symm_apply_apply]

/-! ## Consequence: everything unitarily equivalent to lattice multiplication -/

open BookProof.ChapterUnboundedPosition
open BookProof.ChapterContinuityUnitaryInfinite (L2Z)

/-- The concrete `adjointDomain` of `ChapterUnboundedPosition` is the abstract one. -/
theorem adjointDomain_mulOp (f : ℤ → ℝ) :
    adjointDomain (mulDomain f) (mulOp f) = BookProof.ChapterUnboundedPosition.adjointDomain f :=
  rfl

/-- Lattice multiplication is self-adjoint in the abstract sense. -/
theorem mulOp_isSelfAdjointOn (f : ℤ → ℝ) : IsSelfAdjointOn (mulDomain f) (mulOp f) := by
  rw [IsSelfAdjointOn, adjointDomain_mulOp]
  exact adjointDomain_eq_mulDomain f

/-- **Any operator unitarily equivalent to a lattice multiplication operator is
self-adjoint on its (dense) domain.** -/
theorem transported_position_isSelfAdjointOn (f : ℤ → ℝ) (W : L2Z ≃ₗᵢ[ℂ] K) :
    IsSelfAdjointOn (transportDomain W (mulDomain f)) (transportOp W (mulDomain f) (mulOp f)) :=
  transport_isSelfAdjointOn W _ _ (mulOp_isSelfAdjointOn f)

/-- ... on a dense domain. -/
theorem transported_position_domain_dense (f : ℤ → ℝ) (W : L2Z ≃ₗᵢ[ℂ] K) :
    Dense ((transportDomain W (mulDomain f) : Submodule ℂ K) : Set K) :=
  transportDomain_dense W _ (mulDomain_dense f)

/-- ... and it carries a one-parameter unitary group. -/
theorem transported_position_group (f : ℤ → ℝ) (W : L2Z ≃ₗᵢ[ℂ] K) (s t : ℝ) (y : K) :
    transportUnitary W (phaseUnitary f (s + t)) y
      = transportUnitary W (phaseUnitary f s) (transportUnitary W (phaseUnitary f t) y) :=
  transportUnitary_add W (phaseUnitary f) (fun s t x => phaseUnitary_add f s t x) s t y

/-- ... strongly continuous at `0`. -/
theorem tendsto_transported_position_unitary (f : ℤ → ℝ) (W : L2Z ≃ₗᵢ[ℂ] K) (y : K) :
    Filter.Tendsto (fun t : ℝ => transportUnitary W (phaseUnitary f t) y) (nhds 0) (nhds y) :=
  tendsto_transportUnitary W (phaseUnitary f) (tendsto_phaseUnitary f) y

/-- ... with the transported operator as its generator: **Stone's relation** holds
for every operator unitarily equivalent to lattice multiplication. -/
theorem tendsto_slope_transported_position (f : ℤ → ℝ) (W : L2Z ≃ₗᵢ[ℂ] K)
    (y : transportDomain W (mulDomain f)) :
    Filter.Tendsto
      (fun t : ℝ => (t⁻¹ : ℝ) • (transportUnitary W (phaseUnitary f t) (y : K) - (y : K)))
      (nhdsWithin 0 {0}ᶜ) (nhds (Complex.I • transportOp W (mulDomain f) (mulOp f) y)) :=
  tendsto_slope_transportUnitary W _ _ (phaseUnitary f) (tendsto_slope_phaseUnitary f) y

end BookProof.ChapterUnitaryTransport

def IsSymmetricOn (D : Submodule ℂ H) (A : D →ₗ[ℂ] H) : Prop :=
  ∀ psi phi : D, ⟪A psi, (phi : H)⟫_ℂ = ⟪(psi : H), A phi⟫_ℂ

/-- `A` is **self-adjoint** on its domain: the adjoint domain is not merely
contained in but *equal* to `D`. -/
def IsSelfAdjointOn (D : Submodule ℂ H) (A : D →ₗ[ℂ] H) : Prop :=
  adjointDomain D A = (D : Set H)

theorem inner_map_symm (W : H ≃ₗᵢ[ℂ] K) (x : H) (y : K) :
    ⟪W x, y⟫_ℂ = ⟪x, W.symm y⟫_ℂ := by
  conv_lhs => rw [← W.apply_symm_apply y]
  exact W.inner_map_map _ _

theorem map_real_smul (W : H ≃ₗᵢ[ℂ] K) (r : ℝ) (x : H) : W (r • x) = r • W x := by
  rw [← Complex.coe_smul, ← Complex.coe_smul, map_smul]

/-! ## Transporting the domain and the operator -/

/-- The transported domain `W(D) ⊆ K`. -/
def transportDomain (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) : Submodule ℂ K :=
  D.map (W.toLinearEquiv : H →ₗ[ℂ] K)

theorem coe_transportDomain (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) :
    ((transportDomain W D : Submodule ℂ K) : Set K) = W '' (D : Set H) := rfl

/-- `W` restricts to a linear equivalence `D ≃ W(D)`. -/
noncomputable def transportEquiv (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) :
    D ≃ₗ[ℂ] transportDomain W D :=
  W.toLinearEquiv.submoduleMap D

@[simp] theorem transportEquiv_coe (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (x : D) :
    ((transportEquiv W D x : transportDomain W D) : K) = W (x : H) := rfl

/-- The **transported operator** `W A W⁻¹`, defined on `W(D)`. -/
noncomputable def transportOp (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H) :
    transportDomain W D →ₗ[ℂ] K :=
  (W.toLinearEquiv : H →ₗ[ℂ] K) ∘ₗ A ∘ₗ ((transportEquiv W D).symm : transportDomain W D →ₗ[ℂ] D)

theorem transportOp_apply (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H) (x : D) :
    transportOp W D A (transportEquiv W D x) = W (A x) := by
  simp [transportOp]

/-! ## The structural properties transport -/

/-- A unitary carries a dense domain to a dense domain. -/
theorem transportDomain_dense (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H)
    (hD : Dense ((D : Submodule ℂ H) : Set H)) :
    Dense ((transportDomain W D : Submodule ℂ K) : Set K) := by
  rw [coe_transportDomain]
  exact W.toHomeomorph.isDenseEmbedding.dense_image.2 hD

/-- Symmetry transports. -/
theorem transportOp_symmetric (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H)
    (hA : IsSymmetricOn D A) : IsSymmetricOn (transportDomain W D) (transportOp W D A) := by
  intro y z
  obtain ⟨a, rfl⟩ := (transportEquiv W D).surjective y
  obtain ⟨b, rfl⟩ := (transportEquiv W D).surjective z
  rw [transportOp_apply, transportOp_apply]
  simpa using hA a b

/-- The adjoint domain of the transported operator is the image of the adjoint
domain — the key step, since self-adjointness is an equality of domains. -/
theorem transport_adjointDomain (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H) :
    adjointDomain (transportDomain W D) (transportOp W D A) = W '' adjointDomain D A := by
  ext phi'
  constructor
  · rintro ⟨eta', h⟩
    refine ⟨W.symm phi', ⟨W.symm eta', fun psi => ?_⟩, by simp⟩
    have hkey := h (transportEquiv W D psi)
    rw [transportOp_apply, inner_map_symm] at hkey
    rw [hkey, transportEquiv_coe, inner_map_symm]
  · rintro ⟨phi, ⟨eta, h⟩, rfl⟩
    refine ⟨W eta, fun y => ?_⟩
    obtain ⟨a, rfl⟩ := (transportEquiv W D).surjective y
    rw [transportOp_apply, transportEquiv_coe, W.inner_map_map, W.inner_map_map]
    exact h a

/-- **Self-adjointness transports along a unitary.** -/
theorem transport_isSelfAdjointOn (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H)
    (hA : IsSelfAdjointOn D A) :
    IsSelfAdjointOn (transportDomain W D) (transportOp W D A) := by
  rw [IsSelfAdjointOn, transport_adjointDomain, hA, coe_transportDomain]

/-! ## The unitary group transports -/

/-- The transported unitary `W U W⁻¹`. -/
noncomputable def transportUnitary (W : H ≃ₗᵢ[ℂ] K) (U : H ≃ₗᵢ[ℂ] H) : K ≃ₗᵢ[ℂ] K :=
  (W.symm.trans U).trans W

@[simp] theorem transportUnitary_apply (W : H ≃ₗᵢ[ℂ] K) (U : H ≃ₗᵢ[ℂ] H) (y : K) :
    transportUnitary W U y = W (U (W.symm y)) := rfl

/-- The one-parameter group law transports. -/
theorem transportUnitary_add (W : H ≃ₗᵢ[ℂ] K) (U : ℝ → H ≃ₗᵢ[ℂ] H)
    (h : ∀ s t : ℝ, ∀ x : H, U (s + t) x = U s (U t x)) (s t : ℝ) (y : K) :
    transportUnitary W (U (s + t)) y
      = transportUnitary W (U s) (transportUnitary W (U t) y) := by
  simp [h]

/-- `V 0 = 1` transports. -/
theorem transportUnitary_zero (W : H ≃ₗᵢ[ℂ] K) (U : H ≃ₗᵢ[ℂ] H) (h : ∀ x : H, U x = x)
    (y : K) : transportUnitary W U y = y := by
  simp [h]

/-- **Strong continuity transports.** -/
theorem tendsto_transportUnitary (W : H ≃ₗᵢ[ℂ] K) (U : ℝ → H ≃ₗᵢ[ℂ] H)
    (h : ∀ x : H, Filter.Tendsto (fun t : ℝ => U t x) (nhds 0) (nhds x)) (y : K) :
    Filter.Tendsto (fun t : ℝ => transportUnitary W (U t) y) (nhds 0) (nhds y) := by
  have := (W.continuous.tendsto (W.symm y)).comp (h (W.symm y))
  simpa [Function.comp] using this

/-- **Stone's relation transports**: if `A` generates `U` on `D`, then `W A W⁻¹`
generates `W U W⁻¹` on `W(D)`. -/
theorem tendsto_slope_transportUnitary (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H)
    (U : ℝ → H ≃ₗᵢ[ℂ] H)
    (h : ∀ x : D, Filter.Tendsto (fun t : ℝ => (t⁻¹ : ℝ) • (U t (x : H) - (x : H)))
      (nhdsWithin 0 {0}ᶜ) (nhds (Complex.I • A x)))
    (y : transportDomain W D) :
    Filter.Tendsto (fun t : ℝ => (t⁻¹ : ℝ) • (transportUnitary W (U t) (y : K) - (y : K)))
      (nhdsWithin 0 {0}ᶜ) (nhds (Complex.I • transportOp W D A y)) := by
  obtain ⟨a, rfl⟩ := (transportEquiv W D).surjective y
  rw [transportOp_apply]
  have hW := (W.continuous.tendsto (Complex.I • A a)).comp (h a)
  have hlim : Filter.Tendsto
      (fun t : ℝ => W ((t⁻¹ : ℝ) • (U t (a : H) - (a : H))))
      (nhdsWithin 0 {0}ᶜ) (nhds (W (Complex.I • A a))) := by
    simpa [Function.comp] using hW
  rw [map_smul] at hlim
  refine hlim.congr fun t => ?_
  rw [map_real_smul, map_sub, transportUnitary_apply, transportEquiv_coe,
    LinearIsometryEquiv.symm_apply_apply]

/-! ## Consequence: everything unitarily equivalent to lattice multiplication -/

open BookProof.ChapterUnboundedPosition
open BookProof.ChapterContinuityUnitaryInfinite (L2Z)

/-- The concrete `adjointDomain` of `ChapterUnboundedPosition` is the abstract one. -/
theorem adjointDomain_mulOp (f : ℤ → ℝ) :
    adjointDomain (mulDomain f) (mulOp f) = BookProof.ChapterUnboundedPosition.adjointDomain f :=
  rfl

/-- Lattice multiplication is self-adjoint in the abstract sense. -/
theorem mulOp_isSelfAdjointOn (f : ℤ → ℝ) : IsSelfAdjointOn (mulDomain f) (mulOp f) := by
  rw [IsSelfAdjointOn, adjointDomain_mulOp]
  exact adjointDomain_eq_mulDomain f

/-- **Any operator unitarily equivalent to a lattice multiplication operator is
self-adjoint on its (dense) domain.** -/
theorem transported_position_isSelfAdjointOn (f : ℤ → ℝ) (W : L2Z ≃ₗᵢ[ℂ] K) :
    IsSelfAdjointOn (transportDomain W (mulDomain f)) (transportOp W (mulDomain f) (mulOp f)) :=
  transport_isSelfAdjointOn W _ _ (mulOp_isSelfAdjointOn f)

/-- ... on a dense domain. -/
theorem transported_position_domain_dense (f : ℤ → ℝ) (W : L2Z ≃ₗᵢ[ℂ] K) :
    Dense ((transportDomain W (mulDomain f) : Submodule ℂ K) : Set K) :=
  transportDomain_dense W _ (mulDomain_dense f)

/-- ... and it carries a one-parameter unitary group. -/
theorem transported_position_group (f : ℤ → ℝ) (W : L2Z ≃ₗᵢ[ℂ] K) (s t : ℝ) (y : K) :
    transportUnitary W (phaseUnitary f (s + t)) y
      = transportUnitary W (phaseUnitary f s) (transportUnitary W (phaseUnitary f t) y) :=
  transportUnitary_add W (phaseUnitary f) (fun s t x => phaseUnitary_add f s t x) s t y

/-- ... strongly continuous at `0`. -/
theorem tendsto_transported_position_unitary (f : ℤ → ℝ) (W : L2Z ≃ₗᵢ[ℂ] K) (y : K) :
    Filter.Tendsto (fun t : ℝ => transportUnitary W (phaseUnitary f t) y) (nhds 0) (nhds y) :=
  tendsto_transportUnitary W (phaseUnitary f) (tendsto_phaseUnitary f) y

/-- ... with the transported operator as its generator: **Stone's relation** holds
for every operator unitarily equivalent to lattice multiplication. -/
theorem tendsto_slope_transported_position (f : ℤ → ℝ) (W : L2Z ≃ₗᵢ[ℂ] K)
    (y : transportDomain W (mulDomain f)) :
    Filter.Tendsto
      (fun t : ℝ => (t⁻¹ : ℝ) • (transportUnitary W (phaseUnitary f t) (y : K) - (y : K)))
      (nhdsWithin 0 {0}ᶜ) (nhds (Complex.I • transportOp W (mulDomain f) (mulOp f) y)) :=
  tendsto_slope_transportUnitary W _ _ (phaseUnitary f) (tendsto_slope_phaseUnitary f) y

end BookProof.ChapterUnitaryTransport
/-! ## Cross-chapter definitions from `BookProof.ChapterContinuityUnitaryInfinite` -/
theorem memℓp_two_of_summable {g : ℤ → ℂ} (h : Summable fun k => ‖g k‖ ^ 2) : Memℓp g 2 := by
  apply memℓp_gen
  simpa [show (2 : ℝ≥0∞).toReal = ((2 : ℕ) : ℝ) from by norm_num, Real.rpow_natCast] using h

/-! ## The lattice translations are unitaries -/

theorem memℓp_shift (f : L2Z) (m : ℤ) : Memℓp (fun k : ℤ => (f : ℤ → ℂ) (k + m)) 2 := by
  apply memℓp_gen
  exact ((Equiv.addRight m).summable_iff).2 ((lp.memℓp f).summable (p := 2) (by norm_num))

/-- The lattice translation `(S_m f) k = f (k + m)`, as a linear map. -/
noncomputable def shiftLin (m : ℤ) : L2Z →ₗ[ℂ] L2Z where
  toFun f := ⟨fun k => (f : ℤ → ℂ) (k + m), memℓp_shift f m⟩
  map_add' f g := by ext k; simp
  map_smul' c f := by ext k; simp

@[simp] theorem shiftLin_apply (m : ℤ) (f : L2Z) (k : ℤ) :
    ((shiftLin m f : L2Z) : ℤ → ℂ) k = (f : ℤ → ℂ) (k + m) := rfl

theorem shiftLin_norm (m : ℤ) (f : L2Z) : ‖shiftLin m f‖ = ‖f‖ := by
  have key : ‖shiftLin m f‖ ^ 2 = ‖f‖ ^ 2 := by
    rw [norm_sq_eq_tsum, norm_sq_eq_tsum]
    exact (Equiv.addRight m).tsum_eq fun k => ‖(f : ℤ → ℂ) k‖ ^ 2
  have hpow : ‖shiftLin m f‖ ^ ((2 : ℕ) : ℝ) = ‖f‖ ^ ((2 : ℕ) : ℝ) := by
    simpa only [Real.rpow_natCast] using key
  exact Real.rpow_left_injOn (x := ((2 : ℕ) : ℝ)) (by norm_num)
    (norm_nonneg _) (norm_nonneg _) hpow

/-- **The lattice translation is a unitary of `ℓ²(ℤ)`.** -/
noncomputable def shiftEquiv (m : ℤ) : L2Z ≃ₗᵢ[ℂ] L2Z where
  toLinearEquiv :=
    { shiftLin m with
      invFun := shiftLin (-m)
      left_inv := fun f => by ext k; simp
      right_inv := fun f => by ext k; simp }
  norm_map' := shiftLin_norm m

/-- The lattice translation as a bounded operator. -/
noncomputable def shiftOp (m : ℤ) : L2Z →L[ℂ] L2Z :=
  (shiftEquiv m).toLinearIsometry.toContinuousLinearMap

@[simp] theorem shiftOp_apply (m : ℤ) (f : L2Z) (k : ℤ) :
    ((shiftOp m f : L2Z) : ℤ → ℂ) k = (f : ℤ → ℂ) (k + m) := rfl

/-- Translations are adjoint to their inverses: `⟪S_m f, g⟫ = ⟪f, S_{-m} g⟫`. -/
theorem inner_shiftOp_left (m : ℤ) (f g : L2Z) :
    ⟪shiftOp m f, g⟫_ℂ = ⟪f, shiftOp (-m) g⟫_ℂ := by
  have h := (shiftEquiv m).inner_map_map f (shiftLin (-m) g)
  have hg : shiftEquiv m (shiftLin (-m) g) = g := by
    ext k
    change (g : ℤ → ℂ) (k + m + -m) = (g : ℤ → ℂ) k
    simp only [add_neg_cancel_right]
  rw [hg] at h
  exact h

/-! ## The momentum operator -/

/-- The **symmetric-difference momentum** on the infinite lattice:
`(p f) k = -(i/2) (f (k+1) - f (k-1))`. -/
noncomputable def momentum : L2Z →L[ℂ] L2Z :=
  (-Complex.I / 2) • (shiftOp 1 - shiftOp (-1))

theorem momentum_apply (f : L2Z) (k : ℤ) :
    ((momentum f : L2Z) : ℤ → ℂ) k
      = (-Complex.I / 2) * ((f : ℤ → ℂ) (k + 1) - (f : ℤ → ℂ) (k - 1)) := by
  simp only [momentum, ContinuousLinearMap.smul_apply, ContinuousLinearMap.sub_apply,
    lp.coeFn_smul, lp.coeFn_sub, Pi.smul_apply, Pi.sub_apply, smul_eq_mul, shiftOp_apply]
  congr 2

/-- **The momentum operator is self-adjoint.** -/
theorem momentum_isSymmetric : (momentum : L2Z →ₗ[ℂ] L2Z).IsSymmetric := by
  intro f g
  have h1 := inner_shiftOp_left 1 f g
  have h2 := inner_shiftOp_left (-1) f g
  simp only [momentum, ContinuousLinearMap.coe_coe, ContinuousLinearMap.smul_apply,
    ContinuousLinearMap.sub_apply, inner_smul_left, inner_smul_right, inner_sub_left,
    inner_sub_right, h1, h2, neg_neg]
  simp only [map_div₀, map_neg, Complex.conj_I, Complex.conj_ofNat]
  ring

theorem momentum_isSelfAdjoint : IsSelfAdjoint momentum :=
  ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric.2 momentum_isSymmetric

/-! ## The velocity (multiplication) operator -/

theorem velocity_bound (v : LinfZ) (k : ℤ) : |(v : ℤ → ℝ) k| ≤ ‖v‖ := by
  simpa [Real.norm_eq_abs] using lp.norm_apply_le_norm (by simp) v k

theorem memℓp_mul (v : LinfZ) (f : L2Z) :
    Memℓp (fun k : ℤ => ((v : ℤ → ℝ) k : ℂ) * (f : ℤ → ℂ) k) 2 := by
  refine memℓp_two_of_summable (Summable.of_nonneg_of_le (fun k => by positivity) (fun k => ?_)
    ((summable_normSq f).mul_left (‖v‖ ^ 2)))
  have hnorm : ‖((v : ℤ → ℝ) k : ℂ) * (f : ℤ → ℂ) k‖ = |(v : ℤ → ℝ) k| * ‖(f : ℤ → ℂ) k‖ := by
    simp [Complex.norm_real]
  rw [hnorm, mul_pow]
  have h1 : |(v : ℤ → ℝ) k| ^ 2 ≤ ‖v‖ ^ 2 := by
    nlinarith [abs_nonneg ((v : ℤ → ℝ) k), velocity_bound v k]
  nlinarith [sq_nonneg ‖(f : ℤ → ℂ) k‖]

/-- Multiplication by a bounded real velocity field, as a linear map. -/
noncomputable def velocityLin (v : LinfZ) : L2Z →ₗ[ℂ] L2Z where
  toFun f := ⟨fun k => ((v : ℤ → ℝ) k : ℂ) * (f : ℤ → ℂ) k, memℓp_mul v f⟩
  map_add' f g := by ext k; simp [mul_add]
  map_smul' c f := by
    ext k
    simp only [lp.coeFn_smul, Pi.smul_apply, smul_eq_mul, RingHom.id_apply]
    ring

@[simp] theorem velocityLin_apply (v : LinfZ) (f : L2Z) (k : ℤ) :
    ((velocityLin v f : L2Z) : ℤ → ℂ) k = ((v : ℤ → ℝ) k : ℂ) * (f : ℤ → ℂ) k := rfl

theorem velocityLin_norm_le (v : LinfZ) (f : L2Z) : ‖velocityLin v f‖ ≤ ‖v‖ * ‖f‖ := by
  refine lp.norm_le_of_tsum_le (by norm_num) (by positivity) ?_
  rw [show (2 : ℝ≥0∞).toReal = ((2 : ℕ) : ℝ) from by norm_num]
  simp only [Real.rpow_natCast]
  have hle : ∀ k : ℤ, ‖((velocityLin v f : L2Z) : ℤ → ℂ) k‖ ^ 2
      ≤ ‖v‖ ^ 2 * ‖(f : ℤ → ℂ) k‖ ^ 2 := by
    intro k
    have hnorm : ‖((velocityLin v f : L2Z) : ℤ → ℂ) k‖ = |(v : ℤ → ℝ) k| * ‖(f : ℤ → ℂ) k‖ := by
      simp [Complex.norm_real]
    rw [hnorm, mul_pow]
    have h1 : |(v : ℤ → ℝ) k| ^ 2 ≤ ‖v‖ ^ 2 := by
      nlinarith [abs_nonneg ((v : ℤ → ℝ) k), velocity_bound v k]
    nlinarith [sq_nonneg ‖(f : ℤ → ℂ) k‖]
  calc ∑' k : ℤ, ‖((velocityLin v f : L2Z) : ℤ → ℂ) k‖ ^ 2
      ≤ ∑' k : ℤ, ‖v‖ ^ 2 * ‖(f : ℤ → ℂ) k‖ ^ 2 :=
        Summable.tsum_le_tsum hle (summable_normSq _) ((summable_normSq f).mul_left _)
    _ = ‖v‖ ^ 2 * ∑' k : ℤ, ‖(f : ℤ → ℂ) k‖ ^ 2 := tsum_mul_left
    _ = (‖v‖ * ‖f‖) ^ 2 := by rw [← norm_sq_eq_tsum]; ring

/-- The **velocity operator**: multiplication by a bounded real field `v`. -/
noncomputable def velocityOp (v : LinfZ) : L2Z →L[ℂ] L2Z :=
  LinearMap.mkContinuous (velocityLin v) ‖v‖ (velocityLin_norm_le v)

@[simp] theorem velocityOp_apply (v : LinfZ) (f : L2Z) (k : ℤ) :
    ((velocityOp v f : L2Z) : ℤ → ℂ) k = ((v : ℤ → ℝ) k : ℂ) * (f : ℤ → ℂ) k := rfl

theorem velocityOp_isSymmetric (v : LinfZ) :
    (velocityOp v : L2Z →ₗ[ℂ] L2Z).IsSymmetric := by
  intro f g
  rw [lp.inner_eq_tsum, lp.inner_eq_tsum]
  refine tsum_congr fun k => ?_
  simp only [ContinuousLinearMap.coe_coe, velocityOp_apply, RCLike.inner_apply, map_mul,
    Complex.conj_ofReal]
  ring

theorem velocityOp_isSelfAdjoint (v : LinfZ) : IsSelfAdjoint (velocityOp v) :=
  ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric.2 (velocityOp_isSymmetric v)

/-! ## The Weyl-symmetrized continuity generator -/

/-- The **Weyl-symmetrized continuity generator** `H = ½ (p·v + v·p)` on
`ℓ²(ℤ)`: a bounded operator, self-adjoint precisely because of the
symmetrization. -/
noncomputable def continuityHamiltonian (v : LinfZ) : L2Z →L[ℂ] L2Z :=
  (1 / 2 : ℂ) • (momentum.comp (velocityOp v) + (velocityOp v).comp momentum)

theorem continuityHamiltonian_isSymmetric (v : LinfZ) :
    (continuityHamiltonian v : L2Z →ₗ[ℂ] L2Z).IsSymmetric := by
  intro f g
  have hp1 : ⟪momentum ((velocityOp v) f), g⟫_ℂ = ⟪(velocityOp v) f, momentum g⟫_ℂ :=
    momentum_isSymmetric _ _
  have hv1 : ⟪(velocityOp v) f, momentum g⟫_ℂ = ⟪f, (velocityOp v) (momentum g)⟫_ℂ :=
    velocityOp_isSymmetric v _ _
  have hv2 : ⟪(velocityOp v) (momentum f), g⟫_ℂ = ⟪momentum f, (velocityOp v) g⟫_ℂ :=
    velocityOp_isSymmetric v _ _
  have hp2 : ⟪momentum f, (velocityOp v) g⟫_ℂ = ⟪f, momentum ((velocityOp v) g)⟫_ℂ :=
    momentum_isSymmetric _ _
  simp only [continuityHamiltonian, ContinuousLinearMap.coe_coe,
    ContinuousLinearMap.smul_apply, ContinuousLinearMap.add_apply,
    ContinuousLinearMap.coe_comp', Function.comp_apply, inner_smul_left, inner_smul_right,
    inner_add_left, inner_add_right]
  rw [hp1, hv1, hv2, hp2]
  simp only [map_div₀, map_one, Complex.conj_ofNat]
  ring

/-- **The Weyl-symmetrized generator is self-adjoint** — the infinite-lattice
counterpart of `ChapterContinuityUnitary.continuityHamiltonian_hermitian`. -/
theorem continuityHamiltonian_isSelfAdjoint (v : LinfZ) :
    IsSelfAdjoint (continuityHamiltonian v) :=
  ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric.2 (continuityHamiltonian_isSymmetric v)

/-! ## The one-parameter unitary group -/

/-- `exp (i t A)` is unitary for a bounded self-adjoint `A` on a Hilbert space —
the operator-algebra counterpart of `ChapterContinuityUnitary.exp_smul_I_unitary`. -/
theorem exp_smul_I_unitary {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
    [CompleteSpace E] (A : E →L[ℂ] E) (hA : IsSelfAdjoint A) (t : ℝ) :
    star (NormedSpace.exp (((t : ℂ) * Complex.I) • A)) *
        NormedSpace.exp (((t : ℂ) * Complex.I) • A) = 1 ∧
      NormedSpace.exp (((t : ℂ) * Complex.I) • A) *
        star (NormedSpace.exp (((t : ℂ) * Complex.I) • A)) = 1 := by
  let +nondep : NormedAlgebra ℚ (E →L[ℂ] E) := .restrictScalars ℚ ℂ _
  set B : E →L[ℂ] E := ((t : ℂ) * Complex.I) • A with hB
  have hstar : star B = -B := by
    rw [hB, star_smul, hA.star_eq]
    simp [RCLike.star_def, ← neg_smul]
  have hexp : star (NormedSpace.exp B) = NormedSpace.exp (-B) := by
    rw [NormedSpace.star_exp, hstar]
  refine ⟨?_, ?_⟩
  · rw [hexp, ← NormedSpace.exp_add_of_commute (Commute.neg_left (Commute.refl B)),
      neg_add_cancel, NormedSpace.exp_zero]
  · rw [hexp, ← NormedSpace.exp_add_of_commute (Commute.neg_right (Commute.refl B)),
      add_neg_cancel, NormedSpace.exp_zero]

/-- The **dynamics-based unitary on the infinite lattice**: `U t = exp (i t H)`
for the continuity generator `H` of the bounded velocity field `v`. -/
noncomputable def continuityUnitary (v : LinfZ) (t : ℝ) : L2Z →L[ℂ] L2Z :=
  NormedSpace.exp (((t : ℂ) * Complex.I) • continuityHamiltonian v)

/-- **`U t` is unitary.** -/
theorem continuityUnitary_unitary (v : LinfZ) (t : ℝ) :
    star (continuityUnitary v t) * continuityUnitary v t = 1 ∧
      continuityUnitary v t * star (continuityUnitary v t) = 1 :=
  exp_smul_I_unitary _ (continuityHamiltonian_isSelfAdjoint v) t

theorem continuityUnitary_zero (v : LinfZ) : continuityUnitary v 0 = 1 := by
  simp [continuityUnitary]

/-- `U` is a one-parameter group: `U (s + t) = U s ∘ U t`. -/
theorem continuityUnitary_add (v : LinfZ) (s t : ℝ) :
    continuityUnitary v (s + t) = continuityUnitary v s * continuityUnitary v t := by
  let +nondep : NormedAlgebra ℚ (L2Z →L[ℂ] L2Z) := .restrictScalars ℚ ℂ _
  have hcomm : Commute (((s : ℂ) * Complex.I) • continuityHamiltonian v)
      (((t : ℂ) * Complex.I) • continuityHamiltonian v) := by
    simp [Commute, SemiconjBy, smul_smul, mul_comm]
  have hsum : (((s + t : ℝ) : ℂ) * Complex.I) • continuityHamiltonian v
      = ((s : ℂ) * Complex.I) • continuityHamiltonian v
        + ((t : ℂ) * Complex.I) • continuityHamiltonian v := by
    rw [← add_smul]
    push_cast
    ring_nf
  rw [continuityUnitary, hsum, NormedSpace.exp_add_of_commute hcomm]
  rfl

/-- A unitary preserves the norm — hence the total `ℓ²` mass. -/
theorem norm_of_unitary {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
    [CompleteSpace E] (U : E →L[ℂ] E) (hU : star U * U = 1) (x : E) : ‖U x‖ = ‖x‖ := by
  have hinner : ⟪U x, U x⟫_ℂ = ⟪x, x⟫_ℂ := by
    rw [← ContinuousLinearMap.adjoint_inner_left]
    rw [← ContinuousLinearMap.star_eq_adjoint]
    rw [show (star U) (U x) = ((star U) * U) x from rfl, hU]
    rfl
  have h := congrArg Complex.re hinner
  simp only [inner_self_eq_norm_sq_to_K] at h
  have h' : ‖U x‖ ^ 2 = ‖x‖ ^ 2 := by exact_mod_cast h
  nlinarith [norm_nonneg (U x), norm_nonneg x]

/-! ## Born recovery: a countably additive probability law on the lattice -/

/-- The state evolved for time `t` by the dynamics-based unitary. -/
noncomputable def evolvedState (v : LinfZ) (t : ℝ) (psi : L2Z) : L2Z :=
  continuityUnitary v t psi

/-- The Born weight of a set `B` of lattice sites in the evolved state. -/
noncomputable def bornRecover (v : LinfZ) (t : ℝ) (psi : L2Z) (B : Finset ℤ) : ℝ :=
  ∑ z ∈ B, ‖((evolvedState v t psi : L2Z) : ℤ → ℂ) z‖ ^ 2

theorem bornRecover_nonneg (v : LinfZ) (t : ℝ) (psi : L2Z) (B : Finset ℤ) :
    0 ≤ bornRecover v t psi B :=
  Finset.sum_nonneg fun _ _ => by positivity

theorem bornRecover_empty (v : LinfZ) (t : ℝ) (psi : L2Z) : bornRecover v t psi ∅ = 0 := by
  simp [bornRecover]

theorem bornRecover_union (v : LinfZ) (t : ℝ) (psi : L2Z) {B C : Finset ℤ}
    (h : Disjoint B C) :
    bornRecover v t psi (B ∪ C) = bornRecover v t psi B + bornRecover v t psi C := by
  simp [bornRecover, Finset.sum_union h]

theorem bornRecover_mono (v : LinfZ) (t : ℝ) (psi : L2Z) {B C : Finset ℤ} (h : B ⊆ C) :
    bornRecover v t psi B ≤ bornRecover v t psi C :=
  Finset.sum_le_sum_of_subset_of_nonneg h fun _ _ _ => by positivity

/-- The evolved state has the same `ℓ²` mass as the initial state. -/
theorem norm_evolvedState (v : LinfZ) (t : ℝ) (psi : L2Z) :
    ‖evolvedState v t psi‖ = ‖psi‖ :=
  norm_of_unitary _ (continuityUnitary_unitary v t).1 psi

/-- **Born recovery: the total mass is `1`.**  On the infinite lattice this is a
countable sum, and unitarity of `U t` makes it exactly `1` for a normalized
initial state. -/
theorem bornRecover_tsum_univ (v : LinfZ) (t : ℝ) (psi : L2Z) (hpsi : ‖psi‖ = 1) :
    ∑' z : ℤ, ‖((evolvedState v t psi : L2Z) : ℤ → ℂ) z‖ ^ 2 = 1 := by
  rw [← norm_sq_eq_tsum, norm_evolvedState, hpsi, one_pow]

theorem summable_bornWeight (v : LinfZ) (t : ℝ) (psi : L2Z) :
    Summable fun z : ℤ => ‖((evolvedState v t psi : L2Z) : ℤ → ℂ) z‖ ^ 2 :=
  summable_normSq _

/-- The Born weights of the evolved state, as a probability distribution on the
infinite lattice `ℤ`. -/
noncomputable def bornPMF (v : LinfZ) (t : ℝ) (psi : L2Z) (hpsi : ‖psi‖ = 1) : PMF ℤ :=
  ⟨fun z => ENNReal.ofReal (‖((evolvedState v t psi : L2Z) : ℤ → ℂ) z‖ ^ 2), by
    have hns : ∀ z : ℤ, 0 ≤ ‖((evolvedState v t psi : L2Z) : ℤ → ℂ) z‖ ^ 2 := fun _ => by positivity
    have htsum : ∑' z : ℤ, ENNReal.ofReal (‖((evolvedState v t psi : L2Z) : ℤ → ℂ) z‖ ^ 2) = 1 := by
      rw [← ENNReal.ofReal_tsum_of_nonneg hns (summable_bornWeight v t psi),
        bornRecover_tsum_univ v t psi hpsi, ENNReal.ofReal_one]
    exact htsum ▸ ENNReal.summable.hasSum⟩

@[simp] theorem bornPMF_apply (v : LinfZ) (t : ℝ) (psi : L2Z) (hpsi : ‖psi‖ = 1) (z : ℤ) :
    bornPMF v t psi hpsi z
      = ENNReal.ofReal (‖((evolvedState v t psi : L2Z) : ℤ → ℂ) z‖ ^ 2) := rfl

/-! ## The capstone -/

variable {X : Type*}

/-- **Capstone (infinite lattice).**  A family of bounded velocity fields `v x`
on `ℤ`, together with normalized initial states `psi x`, determines by the
dynamics-based unitary — and by *no* basis choice — a genuine conditional
probability law `z ↦ |Ψ_t(x, z)|²` on the infinite lattice for every input `x`:
it is a countably additive probability measure whose mass on a finite set `B` of
sites is the Born weight `bornRecover`. -/
theorem condProb_of_continuity_infinite (v : X → LinfZ) (t : ℝ) (psi : X → L2Z)
    (hpsi : ∀ x, ‖psi x‖ = 1) (x : X) :
    (∑' z : ℤ, bornPMF (v x) t (psi x) (hpsi x) z) = 1 ∧
      ∀ B : Finset ℤ,
        ∑ z ∈ B, bornPMF (v x) t (psi x) (hpsi x) z
          = ENNReal.ofReal (bornRecover (v x) t (psi x) B) := by
  refine ⟨(bornPMF (v x) t (psi x) (hpsi x)).tsum_coe, fun B => ?_⟩
  rw [bornRecover, ENNReal.ofReal_sum_of_nonneg (fun _ _ => by positivity)]
  exact Finset.sum_congr rfl fun z _ => bornPMF_apply _ _ _ _ z

end BookProof.ChapterContinuityUnitaryInfinite

theorem norm_sq_eq_tsum (f : L2Z) : ‖f‖ ^ 2 = ∑' k : ℤ, ‖(f : ℤ → ℂ) k‖ ^ 2 := by
  have h := lp.norm_rpow_eq_tsum (p := 2) (by norm_num) f
  rw [show (2 : ℝ≥0∞).toReal = ((2 : ℕ) : ℝ) from by norm_num] at h
  simpa only [Real.rpow_natCast] using h

theorem memℓp_two_of_summable {g : ℤ → ℂ} (h : Summable fun k => ‖g k‖ ^ 2) : Memℓp g 2 := by
  apply memℓp_gen
  simpa [show (2 : ℝ≥0∞).toReal = ((2 : ℕ) : ℝ) from by norm_num, Real.rpow_natCast] using h

/-! ## The lattice translations are unitaries -/

theorem memℓp_shift (f : L2Z) (m : ℤ) : Memℓp (fun k : ℤ => (f : ℤ → ℂ) (k + m)) 2 := by
  apply memℓp_gen
  exact ((Equiv.addRight m).summable_iff).2 ((lp.memℓp f).summable (p := 2) (by norm_num))

/-- The lattice translation `(S_m f) k = f (k + m)`, as a linear map. -/
noncomputable def shiftLin (m : ℤ) : L2Z →ₗ[ℂ] L2Z where
  toFun f := ⟨fun k => (f : ℤ → ℂ) (k + m), memℓp_shift f m⟩
  map_add' f g := by ext k; simp
  map_smul' c f := by ext k; simp

@[simp] theorem shiftLin_apply (m : ℤ) (f : L2Z) (k : ℤ) :
    ((shiftLin m f : L2Z) : ℤ → ℂ) k = (f : ℤ → ℂ) (k + m) := rfl

theorem shiftLin_norm (m : ℤ) (f : L2Z) : ‖shiftLin m f‖ = ‖f‖ := by
  have key : ‖shiftLin m f‖ ^ 2 = ‖f‖ ^ 2 := by
    rw [norm_sq_eq_tsum, norm_sq_eq_tsum]
    exact (Equiv.addRight m).tsum_eq fun k => ‖(f : ℤ → ℂ) k‖ ^ 2
  have hpow : ‖shiftLin m f‖ ^ ((2 : ℕ) : ℝ) = ‖f‖ ^ ((2 : ℕ) : ℝ) := by
    simpa only [Real.rpow_natCast] using key
  exact Real.rpow_left_injOn (x := ((2 : ℕ) : ℝ)) (by norm_num)
    (norm_nonneg _) (norm_nonneg _) hpow

/-- **The lattice translation is a unitary of `ℓ²(ℤ)`.** -/
noncomputable def shiftEquiv (m : ℤ) : L2Z ≃ₗᵢ[ℂ] L2Z where
  toLinearEquiv :=
    { shiftLin m with
      invFun := shiftLin (-m)
      left_inv := fun f => by ext k; simp
      right_inv := fun f => by ext k; simp }
  norm_map' := shiftLin_norm m

/-- The lattice translation as a bounded operator. -/
noncomputable def shiftOp (m : ℤ) : L2Z →L[ℂ] L2Z :=
  (shiftEquiv m).toLinearIsometry.toContinuousLinearMap

@[simp] theorem shiftOp_apply (m : ℤ) (f : L2Z) (k : ℤ) :
    ((shiftOp m f : L2Z) : ℤ → ℂ) k = (f : ℤ → ℂ) (k + m) := rfl

/-- Translations are adjoint to their inverses: `⟪S_m f, g⟫ = ⟪f, S_{-m} g⟫`. -/
theorem inner_shiftOp_left (m : ℤ) (f g : L2Z) :
    ⟪shiftOp m f, g⟫_ℂ = ⟪f, shiftOp (-m) g⟫_ℂ := by
  have h := (shiftEquiv m).inner_map_map f (shiftLin (-m) g)
  have hg : shiftEquiv m (shiftLin (-m) g) = g := by
    ext k
    change (g : ℤ → ℂ) (k + m + -m) = (g : ℤ → ℂ) k
    simp only [add_neg_cancel_right]
  rw [hg] at h
  exact h

/-! ## The momentum operator -/

/-- The **symmetric-difference momentum** on the infinite lattice:
`(p f) k = -(i/2) (f (k+1) - f (k-1))`. -/
noncomputable def momentum : L2Z →L[ℂ] L2Z :=
  (-Complex.I / 2) • (shiftOp 1 - shiftOp (-1))

theorem momentum_apply (f : L2Z) (k : ℤ) :
    ((momentum f : L2Z) : ℤ → ℂ) k
      = (-Complex.I / 2) * ((f : ℤ → ℂ) (k + 1) - (f : ℤ → ℂ) (k - 1)) := by
  simp only [momentum, ContinuousLinearMap.smul_apply, ContinuousLinearMap.sub_apply,
    lp.coeFn_smul, lp.coeFn_sub, Pi.smul_apply, Pi.sub_apply, smul_eq_mul, shiftOp_apply]
  congr 2

/-- **The momentum operator is self-adjoint.** -/
theorem momentum_isSymmetric : (momentum : L2Z →ₗ[ℂ] L2Z).IsSymmetric := by
  intro f g
  have h1 := inner_shiftOp_left 1 f g
  have h2 := inner_shiftOp_left (-1) f g
  simp only [momentum, ContinuousLinearMap.coe_coe, ContinuousLinearMap.smul_apply,
    ContinuousLinearMap.sub_apply, inner_smul_left, inner_smul_right, inner_sub_left,
    inner_sub_right, h1, h2, neg_neg]
  simp only [map_div₀, map_neg, Complex.conj_I, Complex.conj_ofNat]
  ring

theorem momentum_isSelfAdjoint : IsSelfAdjoint momentum :=
  ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric.2 momentum_isSymmetric

/-! ## The velocity (multiplication) operator -/

theorem velocity_bound (v : LinfZ) (k : ℤ) : |(v : ℤ → ℝ) k| ≤ ‖v‖ := by
  simpa [Real.norm_eq_abs] using lp.norm_apply_le_norm (by simp) v k

theorem memℓp_mul (v : LinfZ) (f : L2Z) :
    Memℓp (fun k : ℤ => ((v : ℤ → ℝ) k : ℂ) * (f : ℤ → ℂ) k) 2 := by
  refine memℓp_two_of_summable (Summable.of_nonneg_of_le (fun k => by positivity) (fun k => ?_)
    ((summable_normSq f).mul_left (‖v‖ ^ 2)))
  have hnorm : ‖((v : ℤ → ℝ) k : ℂ) * (f : ℤ → ℂ) k‖ = |(v : ℤ → ℝ) k| * ‖(f : ℤ → ℂ) k‖ := by
    simp [Complex.norm_real]
  rw [hnorm, mul_pow]
  have h1 : |(v : ℤ → ℝ) k| ^ 2 ≤ ‖v‖ ^ 2 := by
    nlinarith [abs_nonneg ((v : ℤ → ℝ) k), velocity_bound v k]
  nlinarith [sq_nonneg ‖(f : ℤ → ℂ) k‖]

/-- Multiplication by a bounded real velocity field, as a linear map. -/
noncomputable def velocityLin (v : LinfZ) : L2Z →ₗ[ℂ] L2Z where
  toFun f := ⟨fun k => ((v : ℤ → ℝ) k : ℂ) * (f : ℤ → ℂ) k, memℓp_mul v f⟩
  map_add' f g := by ext k; simp [mul_add]
  map_smul' c f := by
    ext k
    simp only [lp.coeFn_smul, Pi.smul_apply, smul_eq_mul, RingHom.id_apply]
    ring

@[simp] theorem velocityLin_apply (v : LinfZ) (f : L2Z) (k : ℤ) :
    ((velocityLin v f : L2Z) : ℤ → ℂ) k = ((v : ℤ → ℝ) k : ℂ) * (f : ℤ → ℂ) k := rfl

theorem velocityLin_norm_le (v : LinfZ) (f : L2Z) : ‖velocityLin v f‖ ≤ ‖v‖ * ‖f‖ := by
  refine lp.norm_le_of_tsum_le (by norm_num) (by positivity) ?_
  rw [show (2 : ℝ≥0∞).toReal = ((2 : ℕ) : ℝ) from by norm_num]
  simp only [Real.rpow_natCast]
  have hle : ∀ k : ℤ, ‖((velocityLin v f : L2Z) : ℤ → ℂ) k‖ ^ 2
      ≤ ‖v‖ ^ 2 * ‖(f : ℤ → ℂ) k‖ ^ 2 := by
    intro k
    have hnorm : ‖((velocityLin v f : L2Z) : ℤ → ℂ) k‖ = |(v : ℤ → ℝ) k| * ‖(f : ℤ → ℂ) k‖ := by
      simp [Complex.norm_real]
    rw [hnorm, mul_pow]
    have h1 : |(v : ℤ → ℝ) k| ^ 2 ≤ ‖v‖ ^ 2 := by
      nlinarith [abs_nonneg ((v : ℤ → ℝ) k), velocity_bound v k]
    nlinarith [sq_nonneg ‖(f : ℤ → ℂ) k‖]
  calc ∑' k : ℤ, ‖((velocityLin v f : L2Z) : ℤ → ℂ) k‖ ^ 2
      ≤ ∑' k : ℤ, ‖v‖ ^ 2 * ‖(f : ℤ → ℂ) k‖ ^ 2 :=
        Summable.tsum_le_tsum hle (summable_normSq _) ((summable_normSq f).mul_left _)
    _ = ‖v‖ ^ 2 * ∑' k : ℤ, ‖(f : ℤ → ℂ) k‖ ^ 2 := tsum_mul_left
    _ = (‖v‖ * ‖f‖) ^ 2 := by rw [← norm_sq_eq_tsum]; ring

/-- The **velocity operator**: multiplication by a bounded real field `v`. -/
noncomputable def velocityOp (v : LinfZ) : L2Z →L[ℂ] L2Z :=
  LinearMap.mkContinuous (velocityLin v) ‖v‖ (velocityLin_norm_le v)

@[simp] theorem velocityOp_apply (v : LinfZ) (f : L2Z) (k : ℤ) :
    ((velocityOp v f : L2Z) : ℤ → ℂ) k = ((v : ℤ → ℝ) k : ℂ) * (f : ℤ → ℂ) k := rfl

theorem velocityOp_isSymmetric (v : LinfZ) :
    (velocityOp v : L2Z →ₗ[ℂ] L2Z).IsSymmetric := by
  intro f g
  rw [lp.inner_eq_tsum, lp.inner_eq_tsum]
  refine tsum_congr fun k => ?_
  simp only [ContinuousLinearMap.coe_coe, velocityOp_apply, RCLike.inner_apply, map_mul,
    Complex.conj_ofReal]
  ring

theorem velocityOp_isSelfAdjoint (v : LinfZ) : IsSelfAdjoint (velocityOp v) :=
  ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric.2 (velocityOp_isSymmetric v)

/-! ## The Weyl-symmetrized continuity generator -/

/-- The **Weyl-symmetrized continuity generator** `H = ½ (p·v + v·p)` on
`ℓ²(ℤ)`: a bounded operator, self-adjoint precisely because of the
symmetrization. -/
noncomputable def continuityHamiltonian (v : LinfZ) : L2Z →L[ℂ] L2Z :=
  (1 / 2 : ℂ) • (momentum.comp (velocityOp v) + (velocityOp v).comp momentum)

theorem continuityHamiltonian_isSymmetric (v : LinfZ) :
    (continuityHamiltonian v : L2Z →ₗ[ℂ] L2Z).IsSymmetric := by
  intro f g
  have hp1 : ⟪momentum ((velocityOp v) f), g⟫_ℂ = ⟪(velocityOp v) f, momentum g⟫_ℂ :=
    momentum_isSymmetric _ _
  have hv1 : ⟪(velocityOp v) f, momentum g⟫_ℂ = ⟪f, (velocityOp v) (momentum g)⟫_ℂ :=
    velocityOp_isSymmetric v _ _
  have hv2 : ⟪(velocityOp v) (momentum f), g⟫_ℂ = ⟪momentum f, (velocityOp v) g⟫_ℂ :=
    velocityOp_isSymmetric v _ _
  have hp2 : ⟪momentum f, (velocityOp v) g⟫_ℂ = ⟪f, momentum ((velocityOp v) g)⟫_ℂ :=
    momentum_isSymmetric _ _
  simp only [continuityHamiltonian, ContinuousLinearMap.coe_coe,
    ContinuousLinearMap.smul_apply, ContinuousLinearMap.add_apply,
    ContinuousLinearMap.coe_comp', Function.comp_apply, inner_smul_left, inner_smul_right,
    inner_add_left, inner_add_right]
  rw [hp1, hv1, hv2, hp2]
  simp only [map_div₀, map_one, Complex.conj_ofNat]
  ring

/-- **The Weyl-symmetrized generator is self-adjoint** — the infinite-lattice
counterpart of `ChapterContinuityUnitary.continuityHamiltonian_hermitian`. -/
theorem continuityHamiltonian_isSelfAdjoint (v : LinfZ) :
    IsSelfAdjoint (continuityHamiltonian v) :=
  ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric.2 (continuityHamiltonian_isSymmetric v)

/-! ## The one-parameter unitary group -/

/-- `exp (i t A)` is unitary for a bounded self-adjoint `A` on a Hilbert space —
the operator-algebra counterpart of `ChapterContinuityUnitary.exp_smul_I_unitary`. -/
theorem exp_smul_I_unitary {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
    [CompleteSpace E] (A : E →L[ℂ] E) (hA : IsSelfAdjoint A) (t : ℝ) :
    star (NormedSpace.exp (((t : ℂ) * Complex.I) • A)) *
        NormedSpace.exp (((t : ℂ) * Complex.I) • A) = 1 ∧
      NormedSpace.exp (((t : ℂ) * Complex.I) • A) *
        star (NormedSpace.exp (((t : ℂ) * Complex.I) • A)) = 1 := by
  let +nondep : NormedAlgebra ℚ (E →L[ℂ] E) := .restrictScalars ℚ ℂ _
  set B : E →L[ℂ] E := ((t : ℂ) * Complex.I) • A with hB
  have hstar : star B = -B := by
    rw [hB, star_smul, hA.star_eq]
    simp [RCLike.star_def, ← neg_smul]
  have hexp : star (NormedSpace.exp B) = NormedSpace.exp (-B) := by
    rw [NormedSpace.star_exp, hstar]
  refine ⟨?_, ?_⟩
  · rw [hexp, ← NormedSpace.exp_add_of_commute (Commute.neg_left (Commute.refl B)),
      neg_add_cancel, NormedSpace.exp_zero]
  · rw [hexp, ← NormedSpace.exp_add_of_commute (Commute.neg_right (Commute.refl B)),
      add_neg_cancel, NormedSpace.exp_zero]

/-- The **dynamics-based unitary on the infinite lattice**: `U t = exp (i t H)`
for the continuity generator `H` of the bounded velocity field `v`. -/
noncomputable def continuityUnitary (v : LinfZ) (t : ℝ) : L2Z →L[ℂ] L2Z :=
  NormedSpace.exp (((t : ℂ) * Complex.I) • continuityHamiltonian v)

/-- **`U t` is unitary.** -/
theorem continuityUnitary_unitary (v : LinfZ) (t : ℝ) :
    star (continuityUnitary v t) * continuityUnitary v t = 1 ∧
      continuityUnitary v t * star (continuityUnitary v t) = 1 :=
  exp_smul_I_unitary _ (continuityHamiltonian_isSelfAdjoint v) t

theorem continuityUnitary_zero (v : LinfZ) : continuityUnitary v 0 = 1 := by
  simp [continuityUnitary]

/-- `U` is a one-parameter group: `U (s + t) = U s ∘ U t`. -/
theorem continuityUnitary_add (v : LinfZ) (s t : ℝ) :
    continuityUnitary v (s + t) = continuityUnitary v s * continuityUnitary v t := by
  let +nondep : NormedAlgebra ℚ (L2Z →L[ℂ] L2Z) := .restrictScalars ℚ ℂ _
  have hcomm : Commute (((s : ℂ) * Complex.I) • continuityHamiltonian v)
      (((t : ℂ) * Complex.I) • continuityHamiltonian v) := by
    simp [Commute, SemiconjBy, smul_smul, mul_comm]
  have hsum : (((s + t : ℝ) : ℂ) * Complex.I) • continuityHamiltonian v
      = ((s : ℂ) * Complex.I) • continuityHamiltonian v
        + ((t : ℂ) * Complex.I) • continuityHamiltonian v := by
    rw [← add_smul]
    push_cast
    ring_nf
  rw [continuityUnitary, hsum, NormedSpace.exp_add_of_commute hcomm]
  rfl

/-- A unitary preserves the norm — hence the total `ℓ²` mass. -/
theorem norm_of_unitary {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
    [CompleteSpace E] (U : E →L[ℂ] E) (hU : star U * U = 1) (x : E) : ‖U x‖ = ‖x‖ := by
  have hinner : ⟪U x, U x⟫_ℂ = ⟪x, x⟫_ℂ := by
    rw [← ContinuousLinearMap.adjoint_inner_left]
    rw [← ContinuousLinearMap.star_eq_adjoint]
    rw [show (star U) (U x) = ((star U) * U) x from rfl, hU]
    rfl
  have h := congrArg Complex.re hinner
  simp only [inner_self_eq_norm_sq_to_K] at h
  have h' : ‖U x‖ ^ 2 = ‖x‖ ^ 2 := by exact_mod_cast h
  nlinarith [norm_nonneg (U x), norm_nonneg x]

/-! ## Born recovery: a countably additive probability law on the lattice -/

/-- The state evolved for time `t` by the dynamics-based unitary. -/
noncomputable def evolvedState (v : LinfZ) (t : ℝ) (psi : L2Z) : L2Z :=
  continuityUnitary v t psi

/-- The Born weight of a set `B` of lattice sites in the evolved state. -/
noncomputable def bornRecover (v : LinfZ) (t : ℝ) (psi : L2Z) (B : Finset ℤ) : ℝ :=
  ∑ z ∈ B, ‖((evolvedState v t psi : L2Z) : ℤ → ℂ) z‖ ^ 2

theorem bornRecover_nonneg (v : LinfZ) (t : ℝ) (psi : L2Z) (B : Finset ℤ) :
    0 ≤ bornRecover v t psi B :=
  Finset.sum_nonneg fun _ _ => by positivity

theorem bornRecover_empty (v : LinfZ) (t : ℝ) (psi : L2Z) : bornRecover v t psi ∅ = 0 := by
  simp [bornRecover]

theorem bornRecover_union (v : LinfZ) (t : ℝ) (psi : L2Z) {B C : Finset ℤ}
    (h : Disjoint B C) :
    bornRecover v t psi (B ∪ C) = bornRecover v t psi B + bornRecover v t psi C := by
  simp [bornRecover, Finset.sum_union h]

theorem bornRecover_mono (v : LinfZ) (t : ℝ) (psi : L2Z) {B C : Finset ℤ} (h : B ⊆ C) :
    bornRecover v t psi B ≤ bornRecover v t psi C :=
  Finset.sum_le_sum_of_subset_of_nonneg h fun _ _ _ => by positivity

/-- The evolved state has the same `ℓ²` mass as the initial state. -/
theorem norm_evolvedState (v : LinfZ) (t : ℝ) (psi : L2Z) :
    ‖evolvedState v t psi‖ = ‖psi‖ :=
  norm_of_unitary _ (continuityUnitary_unitary v t).1 psi

/-- **Born recovery: the total mass is `1`.**  On the infinite lattice this is a
countable sum, and unitarity of `U t` makes it exactly `1` for a normalized
initial state. -/
theorem bornRecover_tsum_univ (v : LinfZ) (t : ℝ) (psi : L2Z) (hpsi : ‖psi‖ = 1) :
    ∑' z : ℤ, ‖((evolvedState v t psi : L2Z) : ℤ → ℂ) z‖ ^ 2 = 1 := by
  rw [← norm_sq_eq_tsum, norm_evolvedState, hpsi, one_pow]

theorem summable_bornWeight (v : LinfZ) (t : ℝ) (psi : L2Z) :
    Summable fun z : ℤ => ‖((evolvedState v t psi : L2Z) : ℤ → ℂ) z‖ ^ 2 :=
  summable_normSq _

/-- The Born weights of the evolved state, as a probability distribution on the
infinite lattice `ℤ`. -/
noncomputable def bornPMF (v : LinfZ) (t : ℝ) (psi : L2Z) (hpsi : ‖psi‖ = 1) : PMF ℤ :=
  ⟨fun z => ENNReal.ofReal (‖((evolvedState v t psi : L2Z) : ℤ → ℂ) z‖ ^ 2), by
    have hns : ∀ z : ℤ, 0 ≤ ‖((evolvedState v t psi : L2Z) : ℤ → ℂ) z‖ ^ 2 := fun _ => by positivity
    have htsum : ∑' z : ℤ, ENNReal.ofReal (‖((evolvedState v t psi : L2Z) : ℤ → ℂ) z‖ ^ 2) = 1 := by
      rw [← ENNReal.ofReal_tsum_of_nonneg hns (summable_bornWeight v t psi),
        bornRecover_tsum_univ v t psi hpsi, ENNReal.ofReal_one]
    exact htsum ▸ ENNReal.summable.hasSum⟩

@[simp] theorem bornPMF_apply (v : LinfZ) (t : ℝ) (psi : L2Z) (hpsi : ‖psi‖ = 1) (z : ℤ) :
    bornPMF v t psi hpsi z
      = ENNReal.ofReal (‖((evolvedState v t psi : L2Z) : ℤ → ℂ) z‖ ^ 2) := rfl

/-! ## The capstone -/

variable {X : Type*}

/-- **Capstone (infinite lattice).**  A family of bounded velocity fields `v x`
on `ℤ`, together with normalized initial states `psi x`, determines by the
dynamics-based unitary — and by *no* basis choice — a genuine conditional
probability law `z ↦ |Ψ_t(x, z)|²` on the infinite lattice for every input `x`:
it is a countably additive probability measure whose mass on a finite set `B` of
sites is the Born weight `bornRecover`. -/
theorem condProb_of_continuity_infinite (v : X → LinfZ) (t : ℝ) (psi : X → L2Z)
    (hpsi : ∀ x, ‖psi x‖ = 1) (x : X) :
    (∑' z : ℤ, bornPMF (v x) t (psi x) (hpsi x) z) = 1 ∧
      ∀ B : Finset ℤ,
        ∑ z ∈ B, bornPMF (v x) t (psi x) (hpsi x) z
          = ENNReal.ofReal (bornRecover (v x) t (psi x) B) := by
  refine ⟨(bornPMF (v x) t (psi x) (hpsi x)).tsum_coe, fun B => ?_⟩
  rw [bornRecover, ENNReal.ofReal_sum_of_nonneg (fun _ _ => by positivity)]
  exact Finset.sum_congr rfl fun z _ => bornPMF_apply _ _ _ _ z

end BookProof.ChapterContinuityUnitaryInfinite

theorem summable_normSq (f : L2Z) : Summable fun k : ℤ => ‖(f : ℤ → ℂ) k‖ ^ 2 := by
  have hsum := (lp.memℓp f).summable (p := 2) (by norm_num)
  simpa [show (2 : ℝ≥0∞).toReal = ((2 : ℕ) : ℝ) from by norm_num, Real.rpow_natCast] using hsum

/-- Parseval on `ℓ²(ℤ)`: the squared norm is the sum of the squared moduli. -/
theorem norm_sq_eq_tsum (f : L2Z) : ‖f‖ ^ 2 = ∑' k : ℤ, ‖(f : ℤ → ℂ) k‖ ^ 2 := by
  have h := lp.norm_rpow_eq_tsum (p := 2) (by norm_num) f
  rw [show (2 : ℝ≥0∞).toReal = ((2 : ℕ) : ℝ) from by norm_num] at h
  simpa only [Real.rpow_natCast] using h

theorem memℓp_two_of_summable {g : ℤ → ℂ} (h : Summable fun k => ‖g k‖ ^ 2) : Memℓp g 2 := by
  apply memℓp_gen
  simpa [show (2 : ℝ≥0∞).toReal = ((2 : ℕ) : ℝ) from by norm_num, Real.rpow_natCast] using h

/-! ## The lattice translations are unitaries -/

theorem memℓp_shift (f : L2Z) (m : ℤ) : Memℓp (fun k : ℤ => (f : ℤ → ℂ) (k + m)) 2 := by
  apply memℓp_gen
  exact ((Equiv.addRight m).summable_iff).2 ((lp.memℓp f).summable (p := 2) (by norm_num))

/-- The lattice translation `(S_m f) k = f (k + m)`, as a linear map. -/
noncomputable def shiftLin (m : ℤ) : L2Z →ₗ[ℂ] L2Z where
  toFun f := ⟨fun k => (f : ℤ → ℂ) (k + m), memℓp_shift f m⟩
  map_add' f g := by ext k; simp
  map_smul' c f := by ext k; simp

@[simp] theorem shiftLin_apply (m : ℤ) (f : L2Z) (k : ℤ) :
    ((shiftLin m f : L2Z) : ℤ → ℂ) k = (f : ℤ → ℂ) (k + m) := rfl

theorem shiftLin_norm (m : ℤ) (f : L2Z) : ‖shiftLin m f‖ = ‖f‖ := by
  have key : ‖shiftLin m f‖ ^ 2 = ‖f‖ ^ 2 := by
    rw [norm_sq_eq_tsum, norm_sq_eq_tsum]
    exact (Equiv.addRight m).tsum_eq fun k => ‖(f : ℤ → ℂ) k‖ ^ 2
  have hpow : ‖shiftLin m f‖ ^ ((2 : ℕ) : ℝ) = ‖f‖ ^ ((2 : ℕ) : ℝ) := by
    simpa only [Real.rpow_natCast] using key
  exact Real.rpow_left_injOn (x := ((2 : ℕ) : ℝ)) (by norm_num)
    (norm_nonneg _) (norm_nonneg _) hpow

/-- **The lattice translation is a unitary of `ℓ²(ℤ)`.** -/
noncomputable def shiftEquiv (m : ℤ) : L2Z ≃ₗᵢ[ℂ] L2Z where
  toLinearEquiv :=
    { shiftLin m with
      invFun := shiftLin (-m)
      left_inv := fun f => by ext k; simp
      right_inv := fun f => by ext k; simp }
  norm_map' := shiftLin_norm m

/-- The lattice translation as a bounded operator. -/
noncomputable def shiftOp (m : ℤ) : L2Z →L[ℂ] L2Z :=
  (shiftEquiv m).toLinearIsometry.toContinuousLinearMap

@[simp] theorem shiftOp_apply (m : ℤ) (f : L2Z) (k : ℤ) :
    ((shiftOp m f : L2Z) : ℤ → ℂ) k = (f : ℤ → ℂ) (k + m) := rfl

/-- Translations are adjoint to their inverses: `⟪S_m f, g⟫ = ⟪f, S_{-m} g⟫`. -/
theorem inner_shiftOp_left (m : ℤ) (f g : L2Z) :
    ⟪shiftOp m f, g⟫_ℂ = ⟪f, shiftOp (-m) g⟫_ℂ := by
  have h := (shiftEquiv m).inner_map_map f (shiftLin (-m) g)
  have hg : shiftEquiv m (shiftLin (-m) g) = g := by
    ext k
    change (g : ℤ → ℂ) (k + m + -m) = (g : ℤ → ℂ) k
    simp only [add_neg_cancel_right]
  rw [hg] at h
  exact h

/-! ## The momentum operator -/

/-- The **symmetric-difference momentum** on the infinite lattice:
`(p f) k = -(i/2) (f (k+1) - f (k-1))`. -/
noncomputable def momentum : L2Z →L[ℂ] L2Z :=
  (-Complex.I / 2) • (shiftOp 1 - shiftOp (-1))

theorem momentum_apply (f : L2Z) (k : ℤ) :
    ((momentum f : L2Z) : ℤ → ℂ) k
      = (-Complex.I / 2) * ((f : ℤ → ℂ) (k + 1) - (f : ℤ → ℂ) (k - 1)) := by
  simp only [momentum, ContinuousLinearMap.smul_apply, ContinuousLinearMap.sub_apply,
    lp.coeFn_smul, lp.coeFn_sub, Pi.smul_apply, Pi.sub_apply, smul_eq_mul, shiftOp_apply]
  congr 2

/-- **The momentum operator is self-adjoint.** -/
theorem momentum_isSymmetric : (momentum : L2Z →ₗ[ℂ] L2Z).IsSymmetric := by
  intro f g
  have h1 := inner_shiftOp_left 1 f g
  have h2 := inner_shiftOp_left (-1) f g
  simp only [momentum, ContinuousLinearMap.coe_coe, ContinuousLinearMap.smul_apply,
    ContinuousLinearMap.sub_apply, inner_smul_left, inner_smul_right, inner_sub_left,
    inner_sub_right, h1, h2, neg_neg]
  simp only [map_div₀, map_neg, Complex.conj_I, Complex.conj_ofNat]
  ring

theorem momentum_isSelfAdjoint : IsSelfAdjoint momentum :=
  ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric.2 momentum_isSymmetric

/-! ## The velocity (multiplication) operator -/

theorem velocity_bound (v : LinfZ) (k : ℤ) : |(v : ℤ → ℝ) k| ≤ ‖v‖ := by
  simpa [Real.norm_eq_abs] using lp.norm_apply_le_norm (by simp) v k

theorem memℓp_mul (v : LinfZ) (f : L2Z) :
    Memℓp (fun k : ℤ => ((v : ℤ → ℝ) k : ℂ) * (f : ℤ → ℂ) k) 2 := by
  refine memℓp_two_of_summable (Summable.of_nonneg_of_le (fun k => by positivity) (fun k => ?_)
    ((summable_normSq f).mul_left (‖v‖ ^ 2)))
  have hnorm : ‖((v : ℤ → ℝ) k : ℂ) * (f : ℤ → ℂ) k‖ = |(v : ℤ → ℝ) k| * ‖(f : ℤ → ℂ) k‖ := by
    simp [Complex.norm_real]
  rw [hnorm, mul_pow]
  have h1 : |(v : ℤ → ℝ) k| ^ 2 ≤ ‖v‖ ^ 2 := by
    nlinarith [abs_nonneg ((v : ℤ → ℝ) k), velocity_bound v k]
  nlinarith [sq_nonneg ‖(f : ℤ → ℂ) k‖]

/-- Multiplication by a bounded real velocity field, as a linear map. -/
noncomputable def velocityLin (v : LinfZ) : L2Z →ₗ[ℂ] L2Z where
  toFun f := ⟨fun k => ((v : ℤ → ℝ) k : ℂ) * (f : ℤ → ℂ) k, memℓp_mul v f⟩
  map_add' f g := by ext k; simp [mul_add]
  map_smul' c f := by
    ext k
    simp only [lp.coeFn_smul, Pi.smul_apply, smul_eq_mul, RingHom.id_apply]
    ring

@[simp] theorem velocityLin_apply (v : LinfZ) (f : L2Z) (k : ℤ) :
    ((velocityLin v f : L2Z) : ℤ → ℂ) k = ((v : ℤ → ℝ) k : ℂ) * (f : ℤ → ℂ) k := rfl

theorem velocityLin_norm_le (v : LinfZ) (f : L2Z) : ‖velocityLin v f‖ ≤ ‖v‖ * ‖f‖ := by
  refine lp.norm_le_of_tsum_le (by norm_num) (by positivity) ?_
  rw [show (2 : ℝ≥0∞).toReal = ((2 : ℕ) : ℝ) from by norm_num]
  simp only [Real.rpow_natCast]
  have hle : ∀ k : ℤ, ‖((velocityLin v f : L2Z) : ℤ → ℂ) k‖ ^ 2
      ≤ ‖v‖ ^ 2 * ‖(f : ℤ → ℂ) k‖ ^ 2 := by
    intro k
    have hnorm : ‖((velocityLin v f : L2Z) : ℤ → ℂ) k‖ = |(v : ℤ → ℝ) k| * ‖(f : ℤ → ℂ) k‖ := by
      simp [Complex.norm_real]
    rw [hnorm, mul_pow]
    have h1 : |(v : ℤ → ℝ) k| ^ 2 ≤ ‖v‖ ^ 2 := by
      nlinarith [abs_nonneg ((v : ℤ → ℝ) k), velocity_bound v k]
    nlinarith [sq_nonneg ‖(f : ℤ → ℂ) k‖]
  calc ∑' k : ℤ, ‖((velocityLin v f : L2Z) : ℤ → ℂ) k‖ ^ 2
      ≤ ∑' k : ℤ, ‖v‖ ^ 2 * ‖(f : ℤ → ℂ) k‖ ^ 2 :=
        Summable.tsum_le_tsum hle (summable_normSq _) ((summable_normSq f).mul_left _)
    _ = ‖v‖ ^ 2 * ∑' k : ℤ, ‖(f : ℤ → ℂ) k‖ ^ 2 := tsum_mul_left
    _ = (‖v‖ * ‖f‖) ^ 2 := by rw [← norm_sq_eq_tsum]; ring

/-- The **velocity operator**: multiplication by a bounded real field `v`. -/
noncomputable def velocityOp (v : LinfZ) : L2Z →L[ℂ] L2Z :=
  LinearMap.mkContinuous (velocityLin v) ‖v‖ (velocityLin_norm_le v)

@[simp] theorem velocityOp_apply (v : LinfZ) (f : L2Z) (k : ℤ) :
    ((velocityOp v f : L2Z) : ℤ → ℂ) k = ((v : ℤ → ℝ) k : ℂ) * (f : ℤ → ℂ) k := rfl

theorem velocityOp_isSymmetric (v : LinfZ) :
    (velocityOp v : L2Z →ₗ[ℂ] L2Z).IsSymmetric := by
  intro f g
  rw [lp.inner_eq_tsum, lp.inner_eq_tsum]
  refine tsum_congr fun k => ?_
  simp only [ContinuousLinearMap.coe_coe, velocityOp_apply, RCLike.inner_apply, map_mul,
    Complex.conj_ofReal]
  ring

theorem velocityOp_isSelfAdjoint (v : LinfZ) : IsSelfAdjoint (velocityOp v) :=
  ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric.2 (velocityOp_isSymmetric v)

/-! ## The Weyl-symmetrized continuity generator -/

/-- The **Weyl-symmetrized continuity generator** `H = ½ (p·v + v·p)` on
`ℓ²(ℤ)`: a bounded operator, self-adjoint precisely because of the
symmetrization. -/
noncomputable def continuityHamiltonian (v : LinfZ) : L2Z →L[ℂ] L2Z :=
  (1 / 2 : ℂ) • (momentum.comp (velocityOp v) + (velocityOp v).comp momentum)

theorem continuityHamiltonian_isSymmetric (v : LinfZ) :
    (continuityHamiltonian v : L2Z →ₗ[ℂ] L2Z).IsSymmetric := by
  intro f g
  have hp1 : ⟪momentum ((velocityOp v) f), g⟫_ℂ = ⟪(velocityOp v) f, momentum g⟫_ℂ :=
    momentum_isSymmetric _ _
  have hv1 : ⟪(velocityOp v) f, momentum g⟫_ℂ = ⟪f, (velocityOp v) (momentum g)⟫_ℂ :=
    velocityOp_isSymmetric v _ _
  have hv2 : ⟪(velocityOp v) (momentum f), g⟫_ℂ = ⟪momentum f, (velocityOp v) g⟫_ℂ :=
    velocityOp_isSymmetric v _ _
  have hp2 : ⟪momentum f, (velocityOp v) g⟫_ℂ = ⟪f, momentum ((velocityOp v) g)⟫_ℂ :=
    momentum_isSymmetric _ _
  simp only [continuityHamiltonian, ContinuousLinearMap.coe_coe,
    ContinuousLinearMap.smul_apply, ContinuousLinearMap.add_apply,
    ContinuousLinearMap.coe_comp', Function.comp_apply, inner_smul_left, inner_smul_right,
    inner_add_left, inner_add_right]
  rw [hp1, hv1, hv2, hp2]
  simp only [map_div₀, map_one, Complex.conj_ofNat]
  ring

/-- **The Weyl-symmetrized generator is self-adjoint** — the infinite-lattice
counterpart of `ChapterContinuityUnitary.continuityHamiltonian_hermitian`. -/
theorem continuityHamiltonian_isSelfAdjoint (v : LinfZ) :
    IsSelfAdjoint (continuityHamiltonian v) :=
  ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric.2 (continuityHamiltonian_isSymmetric v)

/-! ## The one-parameter unitary group -/

/-- `exp (i t A)` is unitary for a bounded self-adjoint `A` on a Hilbert space —
the operator-algebra counterpart of `ChapterContinuityUnitary.exp_smul_I_unitary`. -/
theorem exp_smul_I_unitary {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
    [CompleteSpace E] (A : E →L[ℂ] E) (hA : IsSelfAdjoint A) (t : ℝ) :
    star (NormedSpace.exp (((t : ℂ) * Complex.I) • A)) *
        NormedSpace.exp (((t : ℂ) * Complex.I) • A) = 1 ∧
      NormedSpace.exp (((t : ℂ) * Complex.I) • A) *
        star (NormedSpace.exp (((t : ℂ) * Complex.I) • A)) = 1 := by
  let +nondep : NormedAlgebra ℚ (E →L[ℂ] E) := .restrictScalars ℚ ℂ _
  set B : E →L[ℂ] E := ((t : ℂ) * Complex.I) • A with hB
  have hstar : star B = -B := by
    rw [hB, star_smul, hA.star_eq]
    simp [RCLike.star_def, ← neg_smul]
  have hexp : star (NormedSpace.exp B) = NormedSpace.exp (-B) := by
    rw [NormedSpace.star_exp, hstar]
  refine ⟨?_, ?_⟩
  · rw [hexp, ← NormedSpace.exp_add_of_commute (Commute.neg_left (Commute.refl B)),
      neg_add_cancel, NormedSpace.exp_zero]
  · rw [hexp, ← NormedSpace.exp_add_of_commute (Commute.neg_right (Commute.refl B)),
      add_neg_cancel, NormedSpace.exp_zero]

/-- The **dynamics-based unitary on the infinite lattice**: `U t = exp (i t H)`
for the continuity generator `H` of the bounded velocity field `v`. -/
noncomputable def continuityUnitary (v : LinfZ) (t : ℝ) : L2Z →L[ℂ] L2Z :=
  NormedSpace.exp (((t : ℂ) * Complex.I) • continuityHamiltonian v)

/-- **`U t` is unitary.** -/
theorem continuityUnitary_unitary (v : LinfZ) (t : ℝ) :
    star (continuityUnitary v t) * continuityUnitary v t = 1 ∧
      continuityUnitary v t * star (continuityUnitary v t) = 1 :=
  exp_smul_I_unitary _ (continuityHamiltonian_isSelfAdjoint v) t

theorem continuityUnitary_zero (v : LinfZ) : continuityUnitary v 0 = 1 := by
  simp [continuityUnitary]

/-- `U` is a one-parameter group: `U (s + t) = U s ∘ U t`. -/
theorem continuityUnitary_add (v : LinfZ) (s t : ℝ) :
    continuityUnitary v (s + t) = continuityUnitary v s * continuityUnitary v t := by
  let +nondep : NormedAlgebra ℚ (L2Z →L[ℂ] L2Z) := .restrictScalars ℚ ℂ _
  have hcomm : Commute (((s : ℂ) * Complex.I) • continuityHamiltonian v)
      (((t : ℂ) * Complex.I) • continuityHamiltonian v) := by
    simp [Commute, SemiconjBy, smul_smul, mul_comm]
  have hsum : (((s + t : ℝ) : ℂ) * Complex.I) • continuityHamiltonian v
      = ((s : ℂ) * Complex.I) • continuityHamiltonian v
        + ((t : ℂ) * Complex.I) • continuityHamiltonian v := by
    rw [← add_smul]
    push_cast
    ring_nf
  rw [continuityUnitary, hsum, NormedSpace.exp_add_of_commute hcomm]
  rfl

/-- A unitary preserves the norm — hence the total `ℓ²` mass. -/
theorem norm_of_unitary {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
    [CompleteSpace E] (U : E →L[ℂ] E) (hU : star U * U = 1) (x : E) : ‖U x‖ = ‖x‖ := by
  have hinner : ⟪U x, U x⟫_ℂ = ⟪x, x⟫_ℂ := by
    rw [← ContinuousLinearMap.adjoint_inner_left]
    rw [← ContinuousLinearMap.star_eq_adjoint]
    rw [show (star U) (U x) = ((star U) * U) x from rfl, hU]
    rfl
  have h := congrArg Complex.re hinner
  simp only [inner_self_eq_norm_sq_to_K] at h
  have h' : ‖U x‖ ^ 2 = ‖x‖ ^ 2 := by exact_mod_cast h
  nlinarith [norm_nonneg (U x), norm_nonneg x]

/-! ## Born recovery: a countably additive probability law on the lattice -/

/-- The state evolved for time `t` by the dynamics-based unitary. -/
noncomputable def evolvedState (v : LinfZ) (t : ℝ) (psi : L2Z) : L2Z :=
  continuityUnitary v t psi

/-- The Born weight of a set `B` of lattice sites in the evolved state. -/
noncomputable def bornRecover (v : LinfZ) (t : ℝ) (psi : L2Z) (B : Finset ℤ) : ℝ :=
  ∑ z ∈ B, ‖((evolvedState v t psi : L2Z) : ℤ → ℂ) z‖ ^ 2

theorem bornRecover_nonneg (v : LinfZ) (t : ℝ) (psi : L2Z) (B : Finset ℤ) :
    0 ≤ bornRecover v t psi B :=
  Finset.sum_nonneg fun _ _ => by positivity

theorem bornRecover_empty (v : LinfZ) (t : ℝ) (psi : L2Z) : bornRecover v t psi ∅ = 0 := by
  simp [bornRecover]

theorem bornRecover_union (v : LinfZ) (t : ℝ) (psi : L2Z) {B C : Finset ℤ}
    (h : Disjoint B C) :
    bornRecover v t psi (B ∪ C) = bornRecover v t psi B + bornRecover v t psi C := by
  simp [bornRecover, Finset.sum_union h]

theorem bornRecover_mono (v : LinfZ) (t : ℝ) (psi : L2Z) {B C : Finset ℤ} (h : B ⊆ C) :
    bornRecover v t psi B ≤ bornRecover v t psi C :=
  Finset.sum_le_sum_of_subset_of_nonneg h fun _ _ _ => by positivity

/-- The evolved state has the same `ℓ²` mass as the initial state. -/
theorem norm_evolvedState (v : LinfZ) (t : ℝ) (psi : L2Z) :
    ‖evolvedState v t psi‖ = ‖psi‖ :=
  norm_of_unitary _ (continuityUnitary_unitary v t).1 psi

/-- **Born recovery: the total mass is `1`.**  On the infinite lattice this is a
countable sum, and unitarity of `U t` makes it exactly `1` for a normalized
initial state. -/
theorem bornRecover_tsum_univ (v : LinfZ) (t : ℝ) (psi : L2Z) (hpsi : ‖psi‖ = 1) :
    ∑' z : ℤ, ‖((evolvedState v t psi : L2Z) : ℤ → ℂ) z‖ ^ 2 = 1 := by
  rw [← norm_sq_eq_tsum, norm_evolvedState, hpsi, one_pow]

theorem summable_bornWeight (v : LinfZ) (t : ℝ) (psi : L2Z) :
    Summable fun z : ℤ => ‖((evolvedState v t psi : L2Z) : ℤ → ℂ) z‖ ^ 2 :=
  summable_normSq _

/-- The Born weights of the evolved state, as a probability distribution on the
infinite lattice `ℤ`. -/
noncomputable def bornPMF (v : LinfZ) (t : ℝ) (psi : L2Z) (hpsi : ‖psi‖ = 1) : PMF ℤ :=
  ⟨fun z => ENNReal.ofReal (‖((evolvedState v t psi : L2Z) : ℤ → ℂ) z‖ ^ 2), by
    have hns : ∀ z : ℤ, 0 ≤ ‖((evolvedState v t psi : L2Z) : ℤ → ℂ) z‖ ^ 2 := fun _ => by positivity
    have htsum : ∑' z : ℤ, ENNReal.ofReal (‖((evolvedState v t psi : L2Z) : ℤ → ℂ) z‖ ^ 2) = 1 := by
      rw [← ENNReal.ofReal_tsum_of_nonneg hns (summable_bornWeight v t psi),
        bornRecover_tsum_univ v t psi hpsi, ENNReal.ofReal_one]
    exact htsum ▸ ENNReal.summable.hasSum⟩

@[simp] theorem bornPMF_apply (v : LinfZ) (t : ℝ) (psi : L2Z) (hpsi : ‖psi‖ = 1) (z : ℤ) :
    bornPMF v t psi hpsi z
      = ENNReal.ofReal (‖((evolvedState v t psi : L2Z) : ℤ → ℂ) z‖ ^ 2) := rfl

/-! ## The capstone -/

variable {X : Type*}

/-- **Capstone (infinite lattice).**  A family of bounded velocity fields `v x`
on `ℤ`, together with normalized initial states `psi x`, determines by the
dynamics-based unitary — and by *no* basis choice — a genuine conditional
probability law `z ↦ |Ψ_t(x, z)|²` on the infinite lattice for every input `x`:
it is a countably additive probability measure whose mass on a finite set `B` of
sites is the Born weight `bornRecover`. -/
theorem condProb_of_continuity_infinite (v : X → LinfZ) (t : ℝ) (psi : X → L2Z)
    (hpsi : ∀ x, ‖psi x‖ = 1) (x : X) :
    (∑' z : ℤ, bornPMF (v x) t (psi x) (hpsi x) z) = 1 ∧
      ∀ B : Finset ℤ,
        ∑ z ∈ B, bornPMF (v x) t (psi x) (hpsi x) z
          = ENNReal.ofReal (bornRecover (v x) t (psi x) B) := by
  refine ⟨(bornPMF (v x) t (psi x) (hpsi x)).tsum_coe, fun B => ?_⟩
  rw [bornRecover, ENNReal.ofReal_sum_of_nonneg (fun _ _ => by positivity)]
  exact Finset.sum_congr rfl fun z _ => bornPMF_apply _ _ _ _ z

end BookProof.ChapterContinuityUnitaryInfinite

/-! ## Cross-chapter definitions from `BookProof.ChapterUnboundedPosition` -/
def adjointDomain (f : ℤ → ℝ) : Set L2Z :=
  {phi | ∃ eta : L2Z, ∀ psi : mulDomain f, ⟪mulOp f psi, phi⟫_ℂ = ⟪(psi : L2Z), eta⟫_ℂ}

/-- **The maximal multiplication operator is self-adjoint**: the adjoint domain is
exactly the natural domain.  In particular the lattice position operator — densely
defined, symmetric and unbounded — is a *self-adjoint* observable, not merely a
symmetric one. -/
theorem adjointDomain_eq_mulDomain (f : ℤ → ℝ) :
    adjointDomain f = ((mulDomain f : Submodule ℂ L2Z) : Set L2Z) := by
  ext phi
  constructor
  · rintro ⟨eta, h⟩
    exact (mulOp_adjoint_apply f h).2
  · intro hphi
    exact ⟨mulOp f ⟨phi, hphi⟩, fun psi => mulOp_symmetric f psi ⟨phi, hphi⟩⟩

/-- ... and on that domain the adjoint *is* the operator: any `η` implementing the
adjoint pairing equals `f·φ`. -/
theorem adjoint_eq_mulOp (f : ℤ → ℝ) {phi eta : L2Z} (hphi : phi ∈ mulDomain f)
    (h : ∀ psi : mulDomain f, ⟪mulOp f psi, phi⟫_ℂ = ⟪(psi : L2Z), eta⟫_ℂ) :
    eta = mulOp f ⟨phi, hphi⟩ := by
  refine lp.ext (funext fun k => ?_)
  exact ((mulOp_adjoint_apply f h).1 k).symm

/-- The position operator is not the restriction of any bounded operator on
`ℓ²(ℤ)`: a bounded operator would supply exactly the constant that
`position_unbounded` forbids. -/
theorem position_not_boundedOperator :
    ¬ ∃ T : L2Z →L[ℂ] L2Z, ∀ psi : mulDomain positionField,
      mulOp positionField psi = T (psi : L2Z) := by
  rintro ⟨T, hT⟩
  refine position_unbounded ⟨‖T‖, fun psi => ?_⟩
  rw [hT psi]
  exact T.le_opNorm _

/-! ## The unitary group generated by the multiplication operator -/

/-- The phase `e^{i t f k}` of the group generated by multiplication by `f`. -/
noncomputable def phase (f : ℤ → ℝ) (t : ℝ) (k : ℤ) : ℂ :=
  Complex.exp (Complex.I * ((t * f k : ℝ) : ℂ))

theorem norm_phase (f : ℤ → ℝ) (t : ℝ) (k : ℤ) : ‖phase f t k‖ = 1 :=
  Complex.norm_exp_I_mul_ofReal _

theorem continuous_phase (f : ℤ → ℝ) (k : ℤ) : Continuous fun t : ℝ => phase f t k := by
  unfold phase
  fun_prop

theorem memℓp_phase (f : ℤ → ℝ) (t : ℝ) (psi : L2Z) :
    Memℓp (fun k => phase f t k * (psi : ℤ → ℂ) k) 2 := by
  refine BookProof.ChapterContinuityUnitaryInfinite.memℓp_two_of_summable ?_
  have h : ∀ k : ℤ, ‖phase f t k * (psi : ℤ → ℂ) k‖ ^ 2 = ‖(psi : ℤ → ℂ) k‖ ^ 2 := by
    intro k
    rw [norm_mul, norm_phase, one_mul]
  simpa only [h] using BookProof.ChapterContinuityUnitaryInfinite.summable_normSq psi

/-- Multiplication by the phase `e^{i t f}`, as a linear map. -/
noncomputable def phaseLin (f : ℤ → ℝ) (t : ℝ) : L2Z →ₗ[ℂ] L2Z where
  toFun psi := ⟨fun k => phase f t k * (psi : ℤ → ℂ) k, memℓp_phase f t psi⟩
  map_add' a b := by ext k; simp [mul_add]
  map_smul' c a := by
    ext k
    simp only [lp.coeFn_smul, Pi.smul_apply, smul_eq_mul, RingHom.id_apply]
    ring

@[simp] theorem phaseLin_apply (f : ℤ → ℝ) (t : ℝ) (psi : L2Z) (k : ℤ) :
    ((phaseLin f t psi : L2Z) : ℤ → ℂ) k = phase f t k * (psi : ℤ → ℂ) k := rfl

theorem phaseLin_add (f : ℤ → ℝ) (s t : ℝ) (psi : L2Z) :
    phaseLin f s (phaseLin f t psi) = phaseLin f (s + t) psi := by
  ext k
  simp only [phaseLin_apply, phase, ← mul_assoc, ← Complex.exp_add]
  congr 2
  push_cast
  ring

theorem phaseLin_zero (f : ℤ → ℝ) (psi : L2Z) : phaseLin f 0 psi = psi := by
  ext k
  simp [phase]

theorem phaseLin_norm (f : ℤ → ℝ) (t : ℝ) (psi : L2Z) : ‖phaseLin f t psi‖ = ‖psi‖ := by
  have key : ‖phaseLin f t psi‖ ^ 2 = ‖psi‖ ^ 2 := by
    rw [BookProof.ChapterContinuityUnitaryInfinite.norm_sq_eq_tsum,
      BookProof.ChapterContinuityUnitaryInfinite.norm_sq_eq_tsum]
    refine tsum_congr fun k => ?_
    rw [phaseLin_apply, norm_mul, norm_phase, one_mul]
  have hpow : ‖phaseLin f t psi‖ ^ ((2 : ℕ) : ℝ) = ‖psi‖ ^ ((2 : ℕ) : ℝ) := by
    simpa only [Real.rpow_natCast] using key
  exact Real.rpow_left_injOn (x := ((2 : ℕ) : ℝ)) (by norm_num)
    (norm_nonneg _) (norm_nonneg _) hpow

/-- **The unitary group `U t = e^{i t f}` generated by multiplication by `f`.**
Every `U t` is a unitary of `ℓ²(ℤ)` — for the position field this is the group
generated by an *unbounded* self-adjoint observable. -/
noncomputable def phaseUnitary (f : ℤ → ℝ) (t : ℝ) : L2Z ≃ₗᵢ[ℂ] L2Z where
  toLinearEquiv :=
    { phaseLin f t with
      invFun := phaseLin f (-t)
      left_inv := fun psi => by
        change phaseLin f (-t) (phaseLin f t psi) = psi
        rw [phaseLin_add, neg_add_cancel, phaseLin_zero]
      right_inv := fun psi => by
        change phaseLin f t (phaseLin f (-t) psi) = psi
        rw [phaseLin_add, add_neg_cancel, phaseLin_zero] }
  norm_map' := phaseLin_norm f t

@[simp] theorem phaseUnitary_apply (f : ℤ → ℝ) (t : ℝ) (psi : L2Z) :
    phaseUnitary f t psi = phaseLin f t psi := rfl

theorem phaseUnitary_zero (f : ℤ → ℝ) (psi : L2Z) : phaseUnitary f 0 psi = psi :=
  phaseLin_zero f psi

/-- The one-parameter group law. -/
theorem phaseUnitary_add (f : ℤ → ℝ) (s t : ℝ) (psi : L2Z) :
    phaseUnitary f (s + t) psi = phaseUnitary f s (phaseUnitary f t psi) :=
  (phaseLin_add f s t psi).symm

/-- **Strong continuity at `0`.**  Although the generator is unbounded, the group
is strongly continuous: `U t ψ → ψ` in `ℓ²(ℤ)` as `t → 0`, for *every* state — no
domain hypothesis. -/
theorem tendsto_phaseUnitary (f : ℤ → ℝ) (psi : L2Z) :
    Filter.Tendsto (fun t : ℝ => phaseUnitary f t psi) (nhds 0) (nhds psi) := by
  rw [tendsto_iff_norm_sub_tendsto_zero]
  have hsq : ∀ t : ℝ, ‖phaseUnitary f t psi - psi‖ ^ 2
      = ∑' k : ℤ, ‖(phase f t k - 1) * (psi : ℤ → ℂ) k‖ ^ 2 := by
    intro t
    rw [BookProof.ChapterContinuityUnitaryInfinite.norm_sq_eq_tsum]
    refine tsum_congr fun k => ?_
    congr 1
    simp [sub_mul]
  have hbound : Summable fun k : ℤ => 4 * ‖(psi : ℤ → ℂ) k‖ ^ 2 :=
    (BookProof.ChapterContinuityUnitaryInfinite.summable_normSq psi).mul_left 4
  have hpt : ∀ k : ℤ, Filter.Tendsto
      (fun t : ℝ => ‖(phase f t k - 1) * (psi : ℤ → ℂ) k‖ ^ 2) (nhds 0) (nhds 0) := by
    intro k
    have hc : Continuous fun t : ℝ => ‖(phase f t k - 1) * (psi : ℤ → ℂ) k‖ ^ 2 :=
      (((continuous_phase f k).sub continuous_const).mul continuous_const).norm.pow 2
    simpa [phase] using hc.tendsto 0
  have hdom : ∀ t : ℝ, ∀ k : ℤ,
      ‖‖(phase f t k - 1) * (psi : ℤ → ℂ) k‖ ^ 2‖ ≤ 4 * ‖(psi : ℤ → ℂ) k‖ ^ 2 := by
    intro t k
    have h1 : ‖phase f t k - 1‖ ≤ 2 := by
      calc ‖phase f t k - 1‖ ≤ ‖phase f t k‖ + ‖(1 : ℂ)‖ := norm_sub_le _ _
        _ = 2 := by rw [norm_phase]; norm_num
    have h2 : ‖(phase f t k - 1) * (psi : ℤ → ℂ) k‖ ≤ 2 * ‖(psi : ℤ → ℂ) k‖ := by
      rw [norm_mul]
      exact mul_le_mul_of_nonneg_right h1 (norm_nonneg _)
    rw [Real.norm_eq_abs, abs_of_nonneg (by positivity)]
    nlinarith [norm_nonneg ((phase f t k - 1) * (psi : ℤ → ℂ) k), norm_nonneg ((psi : ℤ → ℂ) k)]
  have htsum := tendsto_tsum_of_dominated_convergence hbound hpt
    (Filter.Eventually.of_forall hdom)
  rw [tsum_zero] at htsum
  have hsqrt : Filter.Tendsto
      (fun t : ℝ => Real.sqrt (∑' k : ℤ, ‖(phase f t k - 1) * (psi : ℤ → ℂ) k‖ ^ 2))
      (nhds 0) (nhds 0) := by
    simpa using (Real.continuous_sqrt.tendsto 0).comp htsum
  refine hsqrt.congr fun t => ?_
  rw [← hsq t, Real.sqrt_sq (norm_nonneg _)]

/-- The phase has the expected derivative in `t`. -/
theorem hasDerivAt_phase (f : ℤ → ℝ) (k : ℤ) :
    HasDerivAt (fun t : ℝ => phase f t k) (Complex.I * f k) 0 := by
  have h1 : HasDerivAt (fun t : ℝ => Complex.I * ((t * f k : ℝ) : ℂ)) (Complex.I * f k) 0 := by
    have h0 : HasDerivAt (fun t : ℝ => ((t * f k : ℝ) : ℂ)) ((f k : ℂ)) 0 := by
      simpa using ((hasDerivAt_id (0 : ℝ)).mul_const (f k)).ofReal_comp
    simpa [mul_comm] using h0.const_mul Complex.I
  simpa [phase] using h1.cexp

theorem tendsto_slope_phase (f : ℤ → ℝ) (k : ℤ) :
    Filter.Tendsto (fun t : ℝ => (t⁻¹ : ℝ) • (phase f t k - 1)) (nhdsWithin 0 {0}ᶜ)
      (nhds (Complex.I * f k)) := by
  have h := hasDerivAt_iff_tendsto_slope.1 (hasDerivAt_phase f k)
  refine h.congr fun t => ?_
  simp [slope, vsub_eq_sub, phase]

/-- **The multiplication operator is the generator of its phase group.**  For a
state in the natural domain the difference quotient of `U t ψ` converges *in
`ℓ²(ℤ)`* to `i·f·ψ` — Stone's relation `dU/dt|₀ = iA`, here for an unbounded
self-adjoint `A`. -/
theorem tendsto_slope_phaseUnitary (f : ℤ → ℝ) (psi : mulDomain f) :
    Filter.Tendsto (fun t : ℝ => (t⁻¹ : ℝ) • (phaseUnitary f t (psi : L2Z) - (psi : L2Z)))
      (nhdsWithin 0 {0}ᶜ) (nhds (Complex.I • mulOp f psi)) := by
  rw [tendsto_iff_norm_sub_tendsto_zero]
  set g : ℤ → ℂ := fun k => (psi : L2Z) k with hg
  have hsq : ∀ t : ℝ,
      ‖(t⁻¹ : ℝ) • (phaseUnitary f t (psi : L2Z) - (psi : L2Z)) - Complex.I • mulOp f psi‖ ^ 2
        = ∑' k : ℤ, ‖((t⁻¹ : ℝ) • (phase f t k - 1)) * g k - Complex.I * (f k : ℂ) * g k‖ ^ 2 := by
    intro t
    rw [BookProof.ChapterContinuityUnitaryInfinite.norm_sq_eq_tsum]
    refine tsum_congr fun k => ?_
    congr 1
    simp only [lp.coeFn_sub, lp.coeFn_smul, Pi.sub_apply, Pi.smul_apply, smul_eq_mul,
      phaseUnitary_apply, phaseLin_apply, mulOp_apply, Complex.real_smul, hg]
    ring
  have hfpsi : Summable fun k : ℤ => ‖(f k : ℂ) * g k‖ ^ 2 := by
    simpa [hg] using
      BookProof.ChapterContinuityUnitaryInfinite.summable_normSq (mulOp f psi)
  have hbound : Summable fun k : ℤ => 4 * ‖(f k : ℂ) * g k‖ ^ 2 := hfpsi.mul_left 4
  have hpt : ∀ k : ℤ, Filter.Tendsto
      (fun t : ℝ => ‖((t⁻¹ : ℝ) • (phase f t k - 1)) * g k - Complex.I * (f k : ℂ) * g k‖ ^ 2)
      (nhdsWithin 0 {0}ᶜ) (nhds 0) := by
    intro k
    have h1 := (tendsto_slope_phase f k).mul_const (g k)
    have h2 : Filter.Tendsto
        (fun t : ℝ => ((t⁻¹ : ℝ) • (phase f t k - 1)) * g k - Complex.I * (f k : ℂ) * g k)
        (nhdsWithin 0 {0}ᶜ) (nhds 0) := by
      have := h1.sub_const (Complex.I * (f k : ℂ) * g k)
      simpa [mul_assoc] using this
    simpa using (h2.norm.pow 2)
  have hdom : ∀ t : ℝ, ∀ k : ℤ,
      ‖‖((t⁻¹ : ℝ) • (phase f t k - 1)) * g k - Complex.I * (f k : ℂ) * g k‖ ^ 2‖
        ≤ 4 * ‖(f k : ℂ) * g k‖ ^ 2 := by
    intro t k
    have hph : ‖((t⁻¹ : ℝ) • (phase f t k - 1))‖ ≤ |f k| := by
      rcases eq_or_ne t 0 with rfl | ht
      · simp
      · have hbase : ‖phase f t k - 1‖ ≤ |t * f k| := by
          simpa [phase, Real.norm_eq_abs] using
            (Real.norm_exp_I_mul_ofReal_sub_one_le (x := t * f k))
        rw [norm_smul, Real.norm_eq_abs, abs_inv]
        calc |t|⁻¹ * ‖phase f t k - 1‖ ≤ |t|⁻¹ * |t * f k| :=
              mul_le_mul_of_nonneg_left hbase (by positivity)
          _ = |f k| := by
              rw [abs_mul, ← mul_assoc, inv_mul_cancel₀ (abs_ne_zero.2 ht), one_mul]
    have h1 : ‖((t⁻¹ : ℝ) • (phase f t k - 1)) * g k - Complex.I * (f k : ℂ) * g k‖
        ≤ 2 * ‖(f k : ℂ) * g k‖ := by
      have e1 : ‖((t⁻¹ : ℝ) • (phase f t k - 1)) * g k‖ ≤ |f k| * ‖g k‖ := by
        rw [norm_mul]
        exact mul_le_mul_of_nonneg_right hph (norm_nonneg _)
      have e2 : ‖Complex.I * (f k : ℂ) * g k‖ = |f k| * ‖g k‖ := by
        simp [Complex.norm_real, Real.norm_eq_abs, mul_assoc]
      have e3 : ‖(f k : ℂ) * g k‖ = |f k| * ‖g k‖ := by
        simp [Complex.norm_real, Real.norm_eq_abs]
      calc ‖((t⁻¹ : ℝ) • (phase f t k - 1)) * g k - Complex.I * (f k : ℂ) * g k‖
          ≤ ‖((t⁻¹ : ℝ) • (phase f t k - 1)) * g k‖ + ‖Complex.I * (f k : ℂ) * g k‖ :=
            norm_sub_le _ _
        _ ≤ |f k| * ‖g k‖ + |f k| * ‖g k‖ := by rw [e2]; linarith
        _ = 2 * ‖(f k : ℂ) * g k‖ := by rw [e3]; ring
    rw [Real.norm_eq_abs, abs_of_nonneg (by positivity)]
    nlinarith [norm_nonneg (((t⁻¹ : ℝ) • (phase f t k - 1)) * g k -
      Complex.I * (f k : ℂ) * g k), norm_nonneg ((f k : ℂ) * g k)]
  have htsum := tendsto_tsum_of_dominated_convergence hbound hpt
    (Filter.Eventually.of_forall hdom)
  rw [tsum_zero] at htsum
  have hsqrt : Filter.Tendsto
      (fun t : ℝ => Real.sqrt (∑' k : ℤ,
        ‖((t⁻¹ : ℝ) • (phase f t k - 1)) * g k - Complex.I * (f k : ℂ) * g k‖ ^ 2))
      (nhdsWithin 0 {0}ᶜ) (nhds 0) := by
    simpa using (Real.continuous_sqrt.tendsto 0).comp htsum
  refine hsqrt.congr fun t => ?_
  rw [← hsq t, Real.sqrt_sq (norm_nonneg _)]

end BookProof.ChapterUnboundedPosition

/-! ## Cross-chapter definitions from `BookProof.ChapterUnitaryTransport` -/
def IsSelfAdjointOn (D : Submodule ℂ H) (A : D →ₗ[ℂ] H) : Prop :=
  adjointDomain D A = (D : Set H)

theorem inner_map_symm (W : H ≃ₗᵢ[ℂ] K) (x : H) (y : K) :
    ⟪W x, y⟫_ℂ = ⟪x, W.symm y⟫_ℂ := by
  conv_lhs => rw [← W.apply_symm_apply y]
  exact W.inner_map_map _ _

theorem map_real_smul (W : H ≃ₗᵢ[ℂ] K) (r : ℝ) (x : H) : W (r • x) = r • W x := by
  rw [← Complex.coe_smul, ← Complex.coe_smul, map_smul]

/-! ## Transporting the domain and the operator -/

/-- The transported domain `W(D) ⊆ K`. -/
def transportDomain (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) : Submodule ℂ K :=
  D.map (W.toLinearEquiv : H →ₗ[ℂ] K)

theorem coe_transportDomain (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) :
    ((transportDomain W D : Submodule ℂ K) : Set K) = W '' (D : Set H) := rfl

/-- `W` restricts to a linear equivalence `D ≃ W(D)`. -/
noncomputable def transportEquiv (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) :
    D ≃ₗ[ℂ] transportDomain W D :=
  W.toLinearEquiv.submoduleMap D

@[simp] theorem transportEquiv_coe (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (x : D) :
    ((transportEquiv W D x : transportDomain W D) : K) = W (x : H) := rfl

/-- The **transported operator** `W A W⁻¹`, defined on `W(D)`. -/
noncomputable def transportOp (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H) :
    transportDomain W D →ₗ[ℂ] K :=
  (W.toLinearEquiv : H →ₗ[ℂ] K) ∘ₗ A ∘ₗ ((transportEquiv W D).symm : transportDomain W D →ₗ[ℂ] D)

theorem transportOp_apply (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H) (x : D) :
    transportOp W D A (transportEquiv W D x) = W (A x) := by
  simp [transportOp]

/-! ## The structural properties transport -/

/-- A unitary carries a dense domain to a dense domain. -/
theorem transportDomain_dense (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H)
    (hD : Dense ((D : Submodule ℂ H) : Set H)) :
    Dense ((transportDomain W D : Submodule ℂ K) : Set K) := by
  rw [coe_transportDomain]
  exact W.toHomeomorph.isDenseEmbedding.dense_image.2 hD

/-- Symmetry transports. -/
theorem transportOp_symmetric (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H)
    (hA : IsSymmetricOn D A) : IsSymmetricOn (transportDomain W D) (transportOp W D A) := by
  intro y z
  obtain ⟨a, rfl⟩ := (transportEquiv W D).surjective y
  obtain ⟨b, rfl⟩ := (transportEquiv W D).surjective z
  rw [transportOp_apply, transportOp_apply]
  simpa using hA a b

/-- The adjoint domain of the transported operator is the image of the adjoint
domain — the key step, since self-adjointness is an equality of domains. -/
theorem transport_adjointDomain (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H) :
    adjointDomain (transportDomain W D) (transportOp W D A) = W '' adjointDomain D A := by
  ext phi'
  constructor
  · rintro ⟨eta', h⟩
    refine ⟨W.symm phi', ⟨W.symm eta', fun psi => ?_⟩, by simp⟩
    have hkey := h (transportEquiv W D psi)
    rw [transportOp_apply, inner_map_symm] at hkey
    rw [hkey, transportEquiv_coe, inner_map_symm]
  · rintro ⟨phi, ⟨eta, h⟩, rfl⟩
    refine ⟨W eta, fun y => ?_⟩
    obtain ⟨a, rfl⟩ := (transportEquiv W D).surjective y
    rw [transportOp_apply, transportEquiv_coe, W.inner_map_map, W.inner_map_map]
    exact h a

/-- **Self-adjointness transports along a unitary.** -/
theorem transport_isSelfAdjointOn (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H)
    (hA : IsSelfAdjointOn D A) :
    IsSelfAdjointOn (transportDomain W D) (transportOp W D A) := by
  rw [IsSelfAdjointOn, transport_adjointDomain, hA, coe_transportDomain]

/-! ## The unitary group transports -/

/-- The transported unitary `W U W⁻¹`. -/
noncomputable def transportUnitary (W : H ≃ₗᵢ[ℂ] K) (U : H ≃ₗᵢ[ℂ] H) : K ≃ₗᵢ[ℂ] K :=
  (W.symm.trans U).trans W

@[simp] theorem transportUnitary_apply (W : H ≃ₗᵢ[ℂ] K) (U : H ≃ₗᵢ[ℂ] H) (y : K) :
    transportUnitary W U y = W (U (W.symm y)) := rfl

/-- The one-parameter group law transports. -/
theorem transportUnitary_add (W : H ≃ₗᵢ[ℂ] K) (U : ℝ → H ≃ₗᵢ[ℂ] H)
    (h : ∀ s t : ℝ, ∀ x : H, U (s + t) x = U s (U t x)) (s t : ℝ) (y : K) :
    transportUnitary W (U (s + t)) y
      = transportUnitary W (U s) (transportUnitary W (U t) y) := by
  simp [h]

/-- `V 0 = 1` transports. -/
theorem transportUnitary_zero (W : H ≃ₗᵢ[ℂ] K) (U : H ≃ₗᵢ[ℂ] H) (h : ∀ x : H, U x = x)
    (y : K) : transportUnitary W U y = y := by
  simp [h]

/-- **Strong continuity transports.** -/
theorem tendsto_transportUnitary (W : H ≃ₗᵢ[ℂ] K) (U : ℝ → H ≃ₗᵢ[ℂ] H)
    (h : ∀ x : H, Filter.Tendsto (fun t : ℝ => U t x) (nhds 0) (nhds x)) (y : K) :
    Filter.Tendsto (fun t : ℝ => transportUnitary W (U t) y) (nhds 0) (nhds y) := by
  have := (W.continuous.tendsto (W.symm y)).comp (h (W.symm y))
  simpa [Function.comp] using this

/-- **Stone's relation transports**: if `A` generates `U` on `D`, then `W A W⁻¹`
generates `W U W⁻¹` on `W(D)`. -/
theorem tendsto_slope_transportUnitary (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H)
    (U : ℝ → H ≃ₗᵢ[ℂ] H)
    (h : ∀ x : D, Filter.Tendsto (fun t : ℝ => (t⁻¹ : ℝ) • (U t (x : H) - (x : H)))
      (nhdsWithin 0 {0}ᶜ) (nhds (Complex.I • A x)))
    (y : transportDomain W D) :
    Filter.Tendsto (fun t : ℝ => (t⁻¹ : ℝ) • (transportUnitary W (U t) (y : K) - (y : K)))
      (nhdsWithin 0 {0}ᶜ) (nhds (Complex.I • transportOp W D A y)) := by
  obtain ⟨a, rfl⟩ := (transportEquiv W D).surjective y
  rw [transportOp_apply]
  have hW := (W.continuous.tendsto (Complex.I • A a)).comp (h a)
  have hlim : Filter.Tendsto
      (fun t : ℝ => W ((t⁻¹ : ℝ) • (U t (a : H) - (a : H))))
      (nhdsWithin 0 {0}ᶜ) (nhds (W (Complex.I • A a))) := by
    simpa [Function.comp] using hW
  rw [map_smul] at hlim
  refine hlim.congr fun t => ?_
  rw [map_real_smul, map_sub, transportUnitary_apply, transportEquiv_coe,
    LinearIsometryEquiv.symm_apply_apply]

/-! ## Consequence: everything unitarily equivalent to lattice multiplication -/


/-- The concrete `adjointDomain` of `ChapterUnboundedPosition` is the abstract one. -/
theorem adjointDomain_mulOp (f : ℤ → ℝ) :
    adjointDomain (mulDomain f) (mulOp f) = BookProof.ChapterUnboundedPosition.adjointDomain f :=
  rfl

/-- Lattice multiplication is self-adjoint in the abstract sense. -/
theorem mulOp_isSelfAdjointOn (f : ℤ → ℝ) : IsSelfAdjointOn (mulDomain f) (mulOp f) := by
  rw [IsSelfAdjointOn, adjointDomain_mulOp]
  exact adjointDomain_eq_mulDomain f

/-- **Any operator unitarily equivalent to a lattice multiplication operator is
self-adjoint on its (dense) domain.** -/
theorem transported_position_isSelfAdjointOn (f : ℤ → ℝ) (W : L2Z ≃ₗᵢ[ℂ] K) :
    IsSelfAdjointOn (transportDomain W (mulDomain f)) (transportOp W (mulDomain f) (mulOp f)) :=
  transport_isSelfAdjointOn W _ _ (mulOp_isSelfAdjointOn f)

/-- ... on a dense domain. -/
theorem transported_position_domain_dense (f : ℤ → ℝ) (W : L2Z ≃ₗᵢ[ℂ] K) :
    Dense ((transportDomain W (mulDomain f) : Submodule ℂ K) : Set K) :=
  transportDomain_dense W _ (mulDomain_dense f)

/-- ... and it carries a one-parameter unitary group. -/
theorem transported_position_group (f : ℤ → ℝ) (W : L2Z ≃ₗᵢ[ℂ] K) (s t : ℝ) (y : K) :
    transportUnitary W (phaseUnitary f (s + t)) y
      = transportUnitary W (phaseUnitary f s) (transportUnitary W (phaseUnitary f t) y) :=
  transportUnitary_add W (phaseUnitary f) (fun s t x => phaseUnitary_add f s t x) s t y

/-- ... strongly continuous at `0`. -/
theorem tendsto_transported_position_unitary (f : ℤ → ℝ) (W : L2Z ≃ₗᵢ[ℂ] K) (y : K) :
    Filter.Tendsto (fun t : ℝ => transportUnitary W (phaseUnitary f t) y) (nhds 0) (nhds y) :=
  tendsto_transportUnitary W (phaseUnitary f) (tendsto_phaseUnitary f) y

/-- ... with the transported operator as its generator: **Stone's relation** holds
for every operator unitarily equivalent to lattice multiplication. -/
theorem tendsto_slope_transported_position (f : ℤ → ℝ) (W : L2Z ≃ₗᵢ[ℂ] K)
    (y : transportDomain W (mulDomain f)) :
    Filter.Tendsto
      (fun t : ℝ => (t⁻¹ : ℝ) • (transportUnitary W (phaseUnitary f t) (y : K) - (y : K)))
      (nhdsWithin 0 {0}ᶜ) (nhds (Complex.I • transportOp W (mulDomain f) (mulOp f) y)) :=
  tendsto_slope_transportUnitary W _ _ (phaseUnitary f) (tendsto_slope_phaseUnitary f) y

end BookProof.ChapterUnitaryTransport

def IsSymmetricOn (D : Submodule ℂ H) (A : D →ₗ[ℂ] H) : Prop :=
  ∀ psi phi : D, ⟪A psi, (phi : H)⟫_ℂ = ⟪(psi : H), A phi⟫_ℂ

/-- `A` is **self-adjoint** on its domain: the adjoint domain is not merely
contained in but *equal* to `D`. -/
def IsSelfAdjointOn (D : Submodule ℂ H) (A : D →ₗ[ℂ] H) : Prop :=
  adjointDomain D A = (D : Set H)

theorem inner_map_symm (W : H ≃ₗᵢ[ℂ] K) (x : H) (y : K) :
    ⟪W x, y⟫_ℂ = ⟪x, W.symm y⟫_ℂ := by
  conv_lhs => rw [← W.apply_symm_apply y]
  exact W.inner_map_map _ _

theorem map_real_smul (W : H ≃ₗᵢ[ℂ] K) (r : ℝ) (x : H) : W (r • x) = r • W x := by
  rw [← Complex.coe_smul, ← Complex.coe_smul, map_smul]

/-! ## Transporting the domain and the operator -/

/-- The transported domain `W(D) ⊆ K`. -/
def transportDomain (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) : Submodule ℂ K :=
  D.map (W.toLinearEquiv : H →ₗ[ℂ] K)

theorem coe_transportDomain (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) :
    ((transportDomain W D : Submodule ℂ K) : Set K) = W '' (D : Set H) := rfl

/-- `W` restricts to a linear equivalence `D ≃ W(D)`. -/
noncomputable def transportEquiv (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) :
    D ≃ₗ[ℂ] transportDomain W D :=
  W.toLinearEquiv.submoduleMap D

@[simp] theorem transportEquiv_coe (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (x : D) :
    ((transportEquiv W D x : transportDomain W D) : K) = W (x : H) := rfl

/-- The **transported operator** `W A W⁻¹`, defined on `W(D)`. -/
noncomputable def transportOp (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H) :
    transportDomain W D →ₗ[ℂ] K :=
  (W.toLinearEquiv : H →ₗ[ℂ] K) ∘ₗ A ∘ₗ ((transportEquiv W D).symm : transportDomain W D →ₗ[ℂ] D)

theorem transportOp_apply (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H) (x : D) :
    transportOp W D A (transportEquiv W D x) = W (A x) := by
  simp [transportOp]

/-! ## The structural properties transport -/

/-- A unitary carries a dense domain to a dense domain. -/
theorem transportDomain_dense (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H)
    (hD : Dense ((D : Submodule ℂ H) : Set H)) :
    Dense ((transportDomain W D : Submodule ℂ K) : Set K) := by
  rw [coe_transportDomain]
  exact W.toHomeomorph.isDenseEmbedding.dense_image.2 hD

/-- Symmetry transports. -/
theorem transportOp_symmetric (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H)
    (hA : IsSymmetricOn D A) : IsSymmetricOn (transportDomain W D) (transportOp W D A) := by
  intro y z
  obtain ⟨a, rfl⟩ := (transportEquiv W D).surjective y
  obtain ⟨b, rfl⟩ := (transportEquiv W D).surjective z
  rw [transportOp_apply, transportOp_apply]
  simpa using hA a b

/-- The adjoint domain of the transported operator is the image of the adjoint
domain — the key step, since self-adjointness is an equality of domains. -/
theorem transport_adjointDomain (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H) :
    adjointDomain (transportDomain W D) (transportOp W D A) = W '' adjointDomain D A := by
  ext phi'
  constructor
  · rintro ⟨eta', h⟩
    refine ⟨W.symm phi', ⟨W.symm eta', fun psi => ?_⟩, by simp⟩
    have hkey := h (transportEquiv W D psi)
    rw [transportOp_apply, inner_map_symm] at hkey
    rw [hkey, transportEquiv_coe, inner_map_symm]
  · rintro ⟨phi, ⟨eta, h⟩, rfl⟩
    refine ⟨W eta, fun y => ?_⟩
    obtain ⟨a, rfl⟩ := (transportEquiv W D).surjective y
    rw [transportOp_apply, transportEquiv_coe, W.inner_map_map, W.inner_map_map]
    exact h a

/-- **Self-adjointness transports along a unitary.** -/
theorem transport_isSelfAdjointOn (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H)
    (hA : IsSelfAdjointOn D A) :
    IsSelfAdjointOn (transportDomain W D) (transportOp W D A) := by
  rw [IsSelfAdjointOn, transport_adjointDomain, hA, coe_transportDomain]

/-! ## The unitary group transports -/

/-- The transported unitary `W U W⁻¹`. -/
noncomputable def transportUnitary (W : H ≃ₗᵢ[ℂ] K) (U : H ≃ₗᵢ[ℂ] H) : K ≃ₗᵢ[ℂ] K :=
  (W.symm.trans U).trans W

@[simp] theorem transportUnitary_apply (W : H ≃ₗᵢ[ℂ] K) (U : H ≃ₗᵢ[ℂ] H) (y : K) :
    transportUnitary W U y = W (U (W.symm y)) := rfl

/-- The one-parameter group law transports. -/
theorem transportUnitary_add (W : H ≃ₗᵢ[ℂ] K) (U : ℝ → H ≃ₗᵢ[ℂ] H)
    (h : ∀ s t : ℝ, ∀ x : H, U (s + t) x = U s (U t x)) (s t : ℝ) (y : K) :
    transportUnitary W (U (s + t)) y
      = transportUnitary W (U s) (transportUnitary W (U t) y) := by
  simp [h]

/-- `V 0 = 1` transports. -/
theorem transportUnitary_zero (W : H ≃ₗᵢ[ℂ] K) (U : H ≃ₗᵢ[ℂ] H) (h : ∀ x : H, U x = x)
    (y : K) : transportUnitary W U y = y := by
  simp [h]

/-- **Strong continuity transports.** -/
theorem tendsto_transportUnitary (W : H ≃ₗᵢ[ℂ] K) (U : ℝ → H ≃ₗᵢ[ℂ] H)
    (h : ∀ x : H, Filter.Tendsto (fun t : ℝ => U t x) (nhds 0) (nhds x)) (y : K) :
    Filter.Tendsto (fun t : ℝ => transportUnitary W (U t) y) (nhds 0) (nhds y) := by
  have := (W.continuous.tendsto (W.symm y)).comp (h (W.symm y))
  simpa [Function.comp] using this

/-- **Stone's relation transports**: if `A` generates `U` on `D`, then `W A W⁻¹`
generates `W U W⁻¹` on `W(D)`. -/
theorem tendsto_slope_transportUnitary (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H)
    (U : ℝ → H ≃ₗᵢ[ℂ] H)
    (h : ∀ x : D, Filter.Tendsto (fun t : ℝ => (t⁻¹ : ℝ) • (U t (x : H) - (x : H)))
      (nhdsWithin 0 {0}ᶜ) (nhds (Complex.I • A x)))
    (y : transportDomain W D) :
    Filter.Tendsto (fun t : ℝ => (t⁻¹ : ℝ) • (transportUnitary W (U t) (y : K) - (y : K)))
      (nhdsWithin 0 {0}ᶜ) (nhds (Complex.I • transportOp W D A y)) := by
  obtain ⟨a, rfl⟩ := (transportEquiv W D).surjective y
  rw [transportOp_apply]
  have hW := (W.continuous.tendsto (Complex.I • A a)).comp (h a)
  have hlim : Filter.Tendsto
      (fun t : ℝ => W ((t⁻¹ : ℝ) • (U t (a : H) - (a : H))))
      (nhdsWithin 0 {0}ᶜ) (nhds (W (Complex.I • A a))) := by
    simpa [Function.comp] using hW
  rw [map_smul] at hlim
  refine hlim.congr fun t => ?_
  rw [map_real_smul, map_sub, transportUnitary_apply, transportEquiv_coe,
    LinearIsometryEquiv.symm_apply_apply]

/-! ## Consequence: everything unitarily equivalent to lattice multiplication -/


/-- The concrete `adjointDomain` of `ChapterUnboundedPosition` is the abstract one. -/
theorem adjointDomain_mulOp (f : ℤ → ℝ) :
    adjointDomain (mulDomain f) (mulOp f) = BookProof.ChapterUnboundedPosition.adjointDomain f :=
  rfl

/-- Lattice multiplication is self-adjoint in the abstract sense. -/
theorem mulOp_isSelfAdjointOn (f : ℤ → ℝ) : IsSelfAdjointOn (mulDomain f) (mulOp f) := by
  rw [IsSelfAdjointOn, adjointDomain_mulOp]
  exact adjointDomain_eq_mulDomain f

/-- **Any operator unitarily equivalent to a lattice multiplication operator is
self-adjoint on its (dense) domain.** -/
theorem transported_position_isSelfAdjointOn (f : ℤ → ℝ) (W : L2Z ≃ₗᵢ[ℂ] K) :
    IsSelfAdjointOn (transportDomain W (mulDomain f)) (transportOp W (mulDomain f) (mulOp f)) :=
  transport_isSelfAdjointOn W _ _ (mulOp_isSelfAdjointOn f)

/-- ... on a dense domain. -/
theorem transported_position_domain_dense (f : ℤ → ℝ) (W : L2Z ≃ₗᵢ[ℂ] K) :
    Dense ((transportDomain W (mulDomain f) : Submodule ℂ K) : Set K) :=
  transportDomain_dense W _ (mulDomain_dense f)

/-- ... and it carries a one-parameter unitary group. -/
theorem transported_position_group (f : ℤ → ℝ) (W : L2Z ≃ₗᵢ[ℂ] K) (s t : ℝ) (y : K) :
    transportUnitary W (phaseUnitary f (s + t)) y
      = transportUnitary W (phaseUnitary f s) (transportUnitary W (phaseUnitary f t) y) :=
  transportUnitary_add W (phaseUnitary f) (fun s t x => phaseUnitary_add f s t x) s t y

/-- ... strongly continuous at `0`. -/
theorem tendsto_transported_position_unitary (f : ℤ → ℝ) (W : L2Z ≃ₗᵢ[ℂ] K) (y : K) :
    Filter.Tendsto (fun t : ℝ => transportUnitary W (phaseUnitary f t) y) (nhds 0) (nhds y) :=
  tendsto_transportUnitary W (phaseUnitary f) (tendsto_phaseUnitary f) y

/-- ... with the transported operator as its generator: **Stone's relation** holds
for every operator unitarily equivalent to lattice multiplication. -/
theorem tendsto_slope_transported_position (f : ℤ → ℝ) (W : L2Z ≃ₗᵢ[ℂ] K)
    (y : transportDomain W (mulDomain f)) :
    Filter.Tendsto
      (fun t : ℝ => (t⁻¹ : ℝ) • (transportUnitary W (phaseUnitary f t) (y : K) - (y : K)))
      (nhdsWithin 0 {0}ᶜ) (nhds (Complex.I • transportOp W (mulDomain f) (mulOp f) y)) :=
  tendsto_slope_transportUnitary W _ _ (phaseUnitary f) (tendsto_slope_phaseUnitary f) y

end BookProof.ChapterUnitaryTransport
/-! ## Cross-chapter definitions from `BookProof.ChapterUnboundedPosition` -/
def adjointDomain (f : ℤ → ℝ) : Set L2Z :=
  {phi | ∃ eta : L2Z, ∀ psi : mulDomain f, ⟪mulOp f psi, phi⟫_ℂ = ⟪(psi : L2Z), eta⟫_ℂ}

/-- **The maximal multiplication operator is self-adjoint**: the adjoint domain is
exactly the natural domain.  In particular the lattice position operator — densely
defined, symmetric and unbounded — is a *self-adjoint* observable, not merely a
symmetric one. -/
theorem adjointDomain_eq_mulDomain (f : ℤ → ℝ) :
    adjointDomain f = ((mulDomain f : Submodule ℂ L2Z) : Set L2Z) := by
  ext phi
  constructor
  · rintro ⟨eta, h⟩
    exact (mulOp_adjoint_apply f h).2
  · intro hphi
    exact ⟨mulOp f ⟨phi, hphi⟩, fun psi => mulOp_symmetric f psi ⟨phi, hphi⟩⟩

/-- ... and on that domain the adjoint *is* the operator: any `η` implementing the
adjoint pairing equals `f·φ`. -/
theorem adjoint_eq_mulOp (f : ℤ → ℝ) {phi eta : L2Z} (hphi : phi ∈ mulDomain f)
    (h : ∀ psi : mulDomain f, ⟪mulOp f psi, phi⟫_ℂ = ⟪(psi : L2Z), eta⟫_ℂ) :
    eta = mulOp f ⟨phi, hphi⟩ := by
  refine lp.ext (funext fun k => ?_)
  exact ((mulOp_adjoint_apply f h).1 k).symm

/-- The position operator is not the restriction of any bounded operator on
`ℓ²(ℤ)`: a bounded operator would supply exactly the constant that
`position_unbounded` forbids. -/
theorem position_not_boundedOperator :
    ¬ ∃ T : L2Z →L[ℂ] L2Z, ∀ psi : mulDomain positionField,
      mulOp positionField psi = T (psi : L2Z) := by
  rintro ⟨T, hT⟩
  refine position_unbounded ⟨‖T‖, fun psi => ?_⟩
  rw [hT psi]
  exact T.le_opNorm _

/-! ## The unitary group generated by the multiplication operator -/

/-- The phase `e^{i t f k}` of the group generated by multiplication by `f`. -/
noncomputable def phase (f : ℤ → ℝ) (t : ℝ) (k : ℤ) : ℂ :=
  Complex.exp (Complex.I * ((t * f k : ℝ) : ℂ))

theorem norm_phase (f : ℤ → ℝ) (t : ℝ) (k : ℤ) : ‖phase f t k‖ = 1 :=
  Complex.norm_exp_I_mul_ofReal _

theorem continuous_phase (f : ℤ → ℝ) (k : ℤ) : Continuous fun t : ℝ => phase f t k := by
  unfold phase
  fun_prop

theorem memℓp_phase (f : ℤ → ℝ) (t : ℝ) (psi : L2Z) :
    Memℓp (fun k => phase f t k * (psi : ℤ → ℂ) k) 2 := by
  refine BookProof.ChapterContinuityUnitaryInfinite.memℓp_two_of_summable ?_
  have h : ∀ k : ℤ, ‖phase f t k * (psi : ℤ → ℂ) k‖ ^ 2 = ‖(psi : ℤ → ℂ) k‖ ^ 2 := by
    intro k
    rw [norm_mul, norm_phase, one_mul]
  simpa only [h] using BookProof.ChapterContinuityUnitaryInfinite.summable_normSq psi

/-- Multiplication by the phase `e^{i t f}`, as a linear map. -/
noncomputable def phaseLin (f : ℤ → ℝ) (t : ℝ) : L2Z →ₗ[ℂ] L2Z where
  toFun psi := ⟨fun k => phase f t k * (psi : ℤ → ℂ) k, memℓp_phase f t psi⟩
  map_add' a b := by ext k; simp [mul_add]
  map_smul' c a := by
    ext k
    simp only [lp.coeFn_smul, Pi.smul_apply, smul_eq_mul, RingHom.id_apply]
    ring

@[simp] theorem phaseLin_apply (f : ℤ → ℝ) (t : ℝ) (psi : L2Z) (k : ℤ) :
    ((phaseLin f t psi : L2Z) : ℤ → ℂ) k = phase f t k * (psi : ℤ → ℂ) k := rfl

theorem phaseLin_add (f : ℤ → ℝ) (s t : ℝ) (psi : L2Z) :
    phaseLin f s (phaseLin f t psi) = phaseLin f (s + t) psi := by
  ext k
  simp only [phaseLin_apply, phase, ← mul_assoc, ← Complex.exp_add]
  congr 2
  push_cast
  ring

theorem phaseLin_zero (f : ℤ → ℝ) (psi : L2Z) : phaseLin f 0 psi = psi := by
  ext k
  simp [phase]

theorem phaseLin_norm (f : ℤ → ℝ) (t : ℝ) (psi : L2Z) : ‖phaseLin f t psi‖ = ‖psi‖ := by
  have key : ‖phaseLin f t psi‖ ^ 2 = ‖psi‖ ^ 2 := by
    rw [BookProof.ChapterContinuityUnitaryInfinite.norm_sq_eq_tsum,
      BookProof.ChapterContinuityUnitaryInfinite.norm_sq_eq_tsum]
    refine tsum_congr fun k => ?_
    rw [phaseLin_apply, norm_mul, norm_phase, one_mul]
  have hpow : ‖phaseLin f t psi‖ ^ ((2 : ℕ) : ℝ) = ‖psi‖ ^ ((2 : ℕ) : ℝ) := by
    simpa only [Real.rpow_natCast] using key
  exact Real.rpow_left_injOn (x := ((2 : ℕ) : ℝ)) (by norm_num)
    (norm_nonneg _) (norm_nonneg _) hpow

/-- **The unitary group `U t = e^{i t f}` generated by multiplication by `f`.**
Every `U t` is a unitary of `ℓ²(ℤ)` — for the position field this is the group
generated by an *unbounded* self-adjoint observable. -/
noncomputable def phaseUnitary (f : ℤ → ℝ) (t : ℝ) : L2Z ≃ₗᵢ[ℂ] L2Z where
  toLinearEquiv :=
    { phaseLin f t with
      invFun := phaseLin f (-t)
      left_inv := fun psi => by
        change phaseLin f (-t) (phaseLin f t psi) = psi
        rw [phaseLin_add, neg_add_cancel, phaseLin_zero]
      right_inv := fun psi => by
        change phaseLin f t (phaseLin f (-t) psi) = psi
        rw [phaseLin_add, add_neg_cancel, phaseLin_zero] }
  norm_map' := phaseLin_norm f t

@[simp] theorem phaseUnitary_apply (f : ℤ → ℝ) (t : ℝ) (psi : L2Z) :
    phaseUnitary f t psi = phaseLin f t psi := rfl

theorem phaseUnitary_zero (f : ℤ → ℝ) (psi : L2Z) : phaseUnitary f 0 psi = psi :=
  phaseLin_zero f psi

/-- The one-parameter group law. -/
theorem phaseUnitary_add (f : ℤ → ℝ) (s t : ℝ) (psi : L2Z) :
    phaseUnitary f (s + t) psi = phaseUnitary f s (phaseUnitary f t psi) :=
  (phaseLin_add f s t psi).symm

/-- **Strong continuity at `0`.**  Although the generator is unbounded, the group
is strongly continuous: `U t ψ → ψ` in `ℓ²(ℤ)` as `t → 0`, for *every* state — no
domain hypothesis. -/
theorem tendsto_phaseUnitary (f : ℤ → ℝ) (psi : L2Z) :
    Filter.Tendsto (fun t : ℝ => phaseUnitary f t psi) (nhds 0) (nhds psi) := by
  rw [tendsto_iff_norm_sub_tendsto_zero]
  have hsq : ∀ t : ℝ, ‖phaseUnitary f t psi - psi‖ ^ 2
      = ∑' k : ℤ, ‖(phase f t k - 1) * (psi : ℤ → ℂ) k‖ ^ 2 := by
    intro t
    rw [BookProof.ChapterContinuityUnitaryInfinite.norm_sq_eq_tsum]
    refine tsum_congr fun k => ?_
    congr 1
    simp [sub_mul]
  have hbound : Summable fun k : ℤ => 4 * ‖(psi : ℤ → ℂ) k‖ ^ 2 :=
    (BookProof.ChapterContinuityUnitaryInfinite.summable_normSq psi).mul_left 4
  have hpt : ∀ k : ℤ, Filter.Tendsto
      (fun t : ℝ => ‖(phase f t k - 1) * (psi : ℤ → ℂ) k‖ ^ 2) (nhds 0) (nhds 0) := by
    intro k
    have hc : Continuous fun t : ℝ => ‖(phase f t k - 1) * (psi : ℤ → ℂ) k‖ ^ 2 :=
      (((continuous_phase f k).sub continuous_const).mul continuous_const).norm.pow 2
    simpa [phase] using hc.tendsto 0
  have hdom : ∀ t : ℝ, ∀ k : ℤ,
      ‖‖(phase f t k - 1) * (psi : ℤ → ℂ) k‖ ^ 2‖ ≤ 4 * ‖(psi : ℤ → ℂ) k‖ ^ 2 := by
    intro t k
    have h1 : ‖phase f t k - 1‖ ≤ 2 := by
      calc ‖phase f t k - 1‖ ≤ ‖phase f t k‖ + ‖(1 : ℂ)‖ := norm_sub_le _ _
        _ = 2 := by rw [norm_phase]; norm_num
    have h2 : ‖(phase f t k - 1) * (psi : ℤ → ℂ) k‖ ≤ 2 * ‖(psi : ℤ → ℂ) k‖ := by
      rw [norm_mul]
      exact mul_le_mul_of_nonneg_right h1 (norm_nonneg _)
    rw [Real.norm_eq_abs, abs_of_nonneg (by positivity)]
    nlinarith [norm_nonneg ((phase f t k - 1) * (psi : ℤ → ℂ) k), norm_nonneg ((psi : ℤ → ℂ) k)]
  have htsum := tendsto_tsum_of_dominated_convergence hbound hpt
    (Filter.Eventually.of_forall hdom)
  rw [tsum_zero] at htsum
  have hsqrt : Filter.Tendsto
      (fun t : ℝ => Real.sqrt (∑' k : ℤ, ‖(phase f t k - 1) * (psi : ℤ → ℂ) k‖ ^ 2))
      (nhds 0) (nhds 0) := by
    simpa using (Real.continuous_sqrt.tendsto 0).comp htsum
  refine hsqrt.congr fun t => ?_
  rw [← hsq t, Real.sqrt_sq (norm_nonneg _)]

/-- The phase has the expected derivative in `t`. -/
theorem hasDerivAt_phase (f : ℤ → ℝ) (k : ℤ) :
    HasDerivAt (fun t : ℝ => phase f t k) (Complex.I * f k) 0 := by
  have h1 : HasDerivAt (fun t : ℝ => Complex.I * ((t * f k : ℝ) : ℂ)) (Complex.I * f k) 0 := by
    have h0 : HasDerivAt (fun t : ℝ => ((t * f k : ℝ) : ℂ)) ((f k : ℂ)) 0 := by
      simpa using ((hasDerivAt_id (0 : ℝ)).mul_const (f k)).ofReal_comp
    simpa [mul_comm] using h0.const_mul Complex.I
  simpa [phase] using h1.cexp

theorem tendsto_slope_phase (f : ℤ → ℝ) (k : ℤ) :
    Filter.Tendsto (fun t : ℝ => (t⁻¹ : ℝ) • (phase f t k - 1)) (nhdsWithin 0 {0}ᶜ)
      (nhds (Complex.I * f k)) := by
  have h := hasDerivAt_iff_tendsto_slope.1 (hasDerivAt_phase f k)
  refine h.congr fun t => ?_
  simp [slope, vsub_eq_sub, phase]

/-- **The multiplication operator is the generator of its phase group.**  For a
state in the natural domain the difference quotient of `U t ψ` converges *in
`ℓ²(ℤ)`* to `i·f·ψ` — Stone's relation `dU/dt|₀ = iA`, here for an unbounded
self-adjoint `A`. -/
theorem tendsto_slope_phaseUnitary (f : ℤ → ℝ) (psi : mulDomain f) :
    Filter.Tendsto (fun t : ℝ => (t⁻¹ : ℝ) • (phaseUnitary f t (psi : L2Z) - (psi : L2Z)))
      (nhdsWithin 0 {0}ᶜ) (nhds (Complex.I • mulOp f psi)) := by
  rw [tendsto_iff_norm_sub_tendsto_zero]
  set g : ℤ → ℂ := fun k => (psi : L2Z) k with hg
  have hsq : ∀ t : ℝ,
      ‖(t⁻¹ : ℝ) • (phaseUnitary f t (psi : L2Z) - (psi : L2Z)) - Complex.I • mulOp f psi‖ ^ 2
        = ∑' k : ℤ, ‖((t⁻¹ : ℝ) • (phase f t k - 1)) * g k - Complex.I * (f k : ℂ) * g k‖ ^ 2 := by
    intro t
    rw [BookProof.ChapterContinuityUnitaryInfinite.norm_sq_eq_tsum]
    refine tsum_congr fun k => ?_
    congr 1
    simp only [lp.coeFn_sub, lp.coeFn_smul, Pi.sub_apply, Pi.smul_apply, smul_eq_mul,
      phaseUnitary_apply, phaseLin_apply, mulOp_apply, Complex.real_smul, hg]
    ring
  have hfpsi : Summable fun k : ℤ => ‖(f k : ℂ) * g k‖ ^ 2 := by
    simpa [hg] using
      BookProof.ChapterContinuityUnitaryInfinite.summable_normSq (mulOp f psi)
  have hbound : Summable fun k : ℤ => 4 * ‖(f k : ℂ) * g k‖ ^ 2 := hfpsi.mul_left 4
  have hpt : ∀ k : ℤ, Filter.Tendsto
      (fun t : ℝ => ‖((t⁻¹ : ℝ) • (phase f t k - 1)) * g k - Complex.I * (f k : ℂ) * g k‖ ^ 2)
      (nhdsWithin 0 {0}ᶜ) (nhds 0) := by
    intro k
    have h1 := (tendsto_slope_phase f k).mul_const (g k)
    have h2 : Filter.Tendsto
        (fun t : ℝ => ((t⁻¹ : ℝ) • (phase f t k - 1)) * g k - Complex.I * (f k : ℂ) * g k)
        (nhdsWithin 0 {0}ᶜ) (nhds 0) := by
      have := h1.sub_const (Complex.I * (f k : ℂ) * g k)
      simpa [mul_assoc] using this
    simpa using (h2.norm.pow 2)
  have hdom : ∀ t : ℝ, ∀ k : ℤ,
      ‖‖((t⁻¹ : ℝ) • (phase f t k - 1)) * g k - Complex.I * (f k : ℂ) * g k‖ ^ 2‖
        ≤ 4 * ‖(f k : ℂ) * g k‖ ^ 2 := by
    intro t k
    have hph : ‖((t⁻¹ : ℝ) • (phase f t k - 1))‖ ≤ |f k| := by
      rcases eq_or_ne t 0 with rfl | ht
      · simp
      · have hbase : ‖phase f t k - 1‖ ≤ |t * f k| := by
          simpa [phase, Real.norm_eq_abs] using
            (Real.norm_exp_I_mul_ofReal_sub_one_le (x := t * f k))
        rw [norm_smul, Real.norm_eq_abs, abs_inv]
        calc |t|⁻¹ * ‖phase f t k - 1‖ ≤ |t|⁻¹ * |t * f k| :=
              mul_le_mul_of_nonneg_left hbase (by positivity)
          _ = |f k| := by
              rw [abs_mul, ← mul_assoc, inv_mul_cancel₀ (abs_ne_zero.2 ht), one_mul]
    have h1 : ‖((t⁻¹ : ℝ) • (phase f t k - 1)) * g k - Complex.I * (f k : ℂ) * g k‖
        ≤ 2 * ‖(f k : ℂ) * g k‖ := by
      have e1 : ‖((t⁻¹ : ℝ) • (phase f t k - 1)) * g k‖ ≤ |f k| * ‖g k‖ := by
        rw [norm_mul]
        exact mul_le_mul_of_nonneg_right hph (norm_nonneg _)
      have e2 : ‖Complex.I * (f k : ℂ) * g k‖ = |f k| * ‖g k‖ := by
        simp [Complex.norm_real, Real.norm_eq_abs, mul_assoc]
      have e3 : ‖(f k : ℂ) * g k‖ = |f k| * ‖g k‖ := by
        simp [Complex.norm_real, Real.norm_eq_abs]
      calc ‖((t⁻¹ : ℝ) • (phase f t k - 1)) * g k - Complex.I * (f k : ℂ) * g k‖
          ≤ ‖((t⁻¹ : ℝ) • (phase f t k - 1)) * g k‖ + ‖Complex.I * (f k : ℂ) * g k‖ :=
            norm_sub_le _ _
        _ ≤ |f k| * ‖g k‖ + |f k| * ‖g k‖ := by rw [e2]; linarith
        _ = 2 * ‖(f k : ℂ) * g k‖ := by rw [e3]; ring
    rw [Real.norm_eq_abs, abs_of_nonneg (by positivity)]
    nlinarith [norm_nonneg (((t⁻¹ : ℝ) • (phase f t k - 1)) * g k -
      Complex.I * (f k : ℂ) * g k), norm_nonneg ((f k : ℂ) * g k)]
  have htsum := tendsto_tsum_of_dominated_convergence hbound hpt
    (Filter.Eventually.of_forall hdom)
  rw [tsum_zero] at htsum
  have hsqrt : Filter.Tendsto
      (fun t : ℝ => Real.sqrt (∑' k : ℤ,
        ‖((t⁻¹ : ℝ) • (phase f t k - 1)) * g k - Complex.I * (f k : ℂ) * g k‖ ^ 2))
      (nhdsWithin 0 {0}ᶜ) (nhds 0) := by
    simpa using (Real.continuous_sqrt.tendsto 0).comp htsum
  refine hsqrt.congr fun t => ?_
  rw [← hsq t, Real.sqrt_sq (norm_nonneg _)]

end BookProof.ChapterUnboundedPosition

/-! ## Cross-chapter definitions from `BookProof.ChapterUnitaryTransport` -/
def IsSelfAdjointOn (D : Submodule ℂ H) (A : D →ₗ[ℂ] H) : Prop :=
  adjointDomain D A = (D : Set H)

theorem inner_map_symm (W : H ≃ₗᵢ[ℂ] K) (x : H) (y : K) :
    ⟪W x, y⟫_ℂ = ⟪x, W.symm y⟫_ℂ := by
  conv_lhs => rw [← W.apply_symm_apply y]
  exact W.inner_map_map _ _

theorem map_real_smul (W : H ≃ₗᵢ[ℂ] K) (r : ℝ) (x : H) : W (r • x) = r • W x := by
  rw [← Complex.coe_smul, ← Complex.coe_smul, map_smul]

/-! ## Transporting the domain and the operator -/

/-- The transported domain `W(D) ⊆ K`. -/
def transportDomain (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) : Submodule ℂ K :=
  D.map (W.toLinearEquiv : H →ₗ[ℂ] K)

theorem coe_transportDomain (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) :
    ((transportDomain W D : Submodule ℂ K) : Set K) = W '' (D : Set H) := rfl

/-- `W` restricts to a linear equivalence `D ≃ W(D)`. -/
noncomputable def transportEquiv (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) :
    D ≃ₗ[ℂ] transportDomain W D :=
  W.toLinearEquiv.submoduleMap D

@[simp] theorem transportEquiv_coe (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (x : D) :
    ((transportEquiv W D x : transportDomain W D) : K) = W (x : H) := rfl

/-- The **transported operator** `W A W⁻¹`, defined on `W(D)`. -/
noncomputable def transportOp (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H) :
    transportDomain W D →ₗ[ℂ] K :=
  (W.toLinearEquiv : H →ₗ[ℂ] K) ∘ₗ A ∘ₗ ((transportEquiv W D).symm : transportDomain W D →ₗ[ℂ] D)

theorem transportOp_apply (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H) (x : D) :
    transportOp W D A (transportEquiv W D x) = W (A x) := by
  simp [transportOp]

/-! ## The structural properties transport -/

/-- A unitary carries a dense domain to a dense domain. -/
theorem transportDomain_dense (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H)
    (hD : Dense ((D : Submodule ℂ H) : Set H)) :
    Dense ((transportDomain W D : Submodule ℂ K) : Set K) := by
  rw [coe_transportDomain]
  exact W.toHomeomorph.isDenseEmbedding.dense_image.2 hD

/-- Symmetry transports. -/
theorem transportOp_symmetric (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H)
    (hA : IsSymmetricOn D A) : IsSymmetricOn (transportDomain W D) (transportOp W D A) := by
  intro y z
  obtain ⟨a, rfl⟩ := (transportEquiv W D).surjective y
  obtain ⟨b, rfl⟩ := (transportEquiv W D).surjective z
  rw [transportOp_apply, transportOp_apply]
  simpa using hA a b

/-- The adjoint domain of the transported operator is the image of the adjoint
domain — the key step, since self-adjointness is an equality of domains. -/
theorem transport_adjointDomain (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H) :
    adjointDomain (transportDomain W D) (transportOp W D A) = W '' adjointDomain D A := by
  ext phi'
  constructor
  · rintro ⟨eta', h⟩
    refine ⟨W.symm phi', ⟨W.symm eta', fun psi => ?_⟩, by simp⟩
    have hkey := h (transportEquiv W D psi)
    rw [transportOp_apply, inner_map_symm] at hkey
    rw [hkey, transportEquiv_coe, inner_map_symm]
  · rintro ⟨phi, ⟨eta, h⟩, rfl⟩
    refine ⟨W eta, fun y => ?_⟩
    obtain ⟨a, rfl⟩ := (transportEquiv W D).surjective y
    rw [transportOp_apply, transportEquiv_coe, W.inner_map_map, W.inner_map_map]
    exact h a

/-- **Self-adjointness transports along a unitary.** -/
theorem transport_isSelfAdjointOn (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H)
    (hA : IsSelfAdjointOn D A) :
    IsSelfAdjointOn (transportDomain W D) (transportOp W D A) := by
  rw [IsSelfAdjointOn, transport_adjointDomain, hA, coe_transportDomain]

/-! ## The unitary group transports -/

/-- The transported unitary `W U W⁻¹`. -/
noncomputable def transportUnitary (W : H ≃ₗᵢ[ℂ] K) (U : H ≃ₗᵢ[ℂ] H) : K ≃ₗᵢ[ℂ] K :=
  (W.symm.trans U).trans W

@[simp] theorem transportUnitary_apply (W : H ≃ₗᵢ[ℂ] K) (U : H ≃ₗᵢ[ℂ] H) (y : K) :
    transportUnitary W U y = W (U (W.symm y)) := rfl

/-- The one-parameter group law transports. -/
theorem transportUnitary_add (W : H ≃ₗᵢ[ℂ] K) (U : ℝ → H ≃ₗᵢ[ℂ] H)
    (h : ∀ s t : ℝ, ∀ x : H, U (s + t) x = U s (U t x)) (s t : ℝ) (y : K) :
    transportUnitary W (U (s + t)) y
      = transportUnitary W (U s) (transportUnitary W (U t) y) := by
  simp [h]

/-- `V 0 = 1` transports. -/
theorem transportUnitary_zero (W : H ≃ₗᵢ[ℂ] K) (U : H ≃ₗᵢ[ℂ] H) (h : ∀ x : H, U x = x)
    (y : K) : transportUnitary W U y = y := by
  simp [h]

/-- **Strong continuity transports.** -/
theorem tendsto_transportUnitary (W : H ≃ₗᵢ[ℂ] K) (U : ℝ → H ≃ₗᵢ[ℂ] H)
    (h : ∀ x : H, Filter.Tendsto (fun t : ℝ => U t x) (nhds 0) (nhds x)) (y : K) :
    Filter.Tendsto (fun t : ℝ => transportUnitary W (U t) y) (nhds 0) (nhds y) := by
  have := (W.continuous.tendsto (W.symm y)).comp (h (W.symm y))
  simpa [Function.comp] using this

/-- **Stone's relation transports**: if `A` generates `U` on `D`, then `W A W⁻¹`
generates `W U W⁻¹` on `W(D)`. -/
theorem tendsto_slope_transportUnitary (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H)
    (U : ℝ → H ≃ₗᵢ[ℂ] H)
    (h : ∀ x : D, Filter.Tendsto (fun t : ℝ => (t⁻¹ : ℝ) • (U t (x : H) - (x : H)))
      (nhdsWithin 0 {0}ᶜ) (nhds (Complex.I • A x)))
    (y : transportDomain W D) :
    Filter.Tendsto (fun t : ℝ => (t⁻¹ : ℝ) • (transportUnitary W (U t) (y : K) - (y : K)))
      (nhdsWithin 0 {0}ᶜ) (nhds (Complex.I • transportOp W D A y)) := by
  obtain ⟨a, rfl⟩ := (transportEquiv W D).surjective y
  rw [transportOp_apply]
  have hW := (W.continuous.tendsto (Complex.I • A a)).comp (h a)
  have hlim : Filter.Tendsto
      (fun t : ℝ => W ((t⁻¹ : ℝ) • (U t (a : H) - (a : H))))
      (nhdsWithin 0 {0}ᶜ) (nhds (W (Complex.I • A a))) := by
    simpa [Function.comp] using hW
  rw [map_smul] at hlim
  refine hlim.congr fun t => ?_
  rw [map_real_smul, map_sub, transportUnitary_apply, transportEquiv_coe,
    LinearIsometryEquiv.symm_apply_apply]

/-! ## Consequence: everything unitarily equivalent to lattice multiplication -/


/-- The concrete `adjointDomain` of `ChapterUnboundedPosition` is the abstract one. -/
theorem adjointDomain_mulOp (f : ℤ → ℝ) :
    adjointDomain (mulDomain f) (mulOp f) = BookProof.ChapterUnboundedPosition.adjointDomain f :=
  rfl

/-- Lattice multiplication is self-adjoint in the abstract sense. -/
theorem mulOp_isSelfAdjointOn (f : ℤ → ℝ) : IsSelfAdjointOn (mulDomain f) (mulOp f) := by
  rw [IsSelfAdjointOn, adjointDomain_mulOp]
  exact adjointDomain_eq_mulDomain f

/-- **Any operator unitarily equivalent to a lattice multiplication operator is
self-adjoint on its (dense) domain.** -/
theorem transported_position_isSelfAdjointOn (f : ℤ → ℝ) (W : L2Z ≃ₗᵢ[ℂ] K) :
    IsSelfAdjointOn (transportDomain W (mulDomain f)) (transportOp W (mulDomain f) (mulOp f)) :=
  transport_isSelfAdjointOn W _ _ (mulOp_isSelfAdjointOn f)

/-- ... on a dense domain. -/
theorem transported_position_domain_dense (f : ℤ → ℝ) (W : L2Z ≃ₗᵢ[ℂ] K) :
    Dense ((transportDomain W (mulDomain f) : Submodule ℂ K) : Set K) :=
  transportDomain_dense W _ (mulDomain_dense f)

/-- ... and it carries a one-parameter unitary group. -/
theorem transported_position_group (f : ℤ → ℝ) (W : L2Z ≃ₗᵢ[ℂ] K) (s t : ℝ) (y : K) :
    transportUnitary W (phaseUnitary f (s + t)) y
      = transportUnitary W (phaseUnitary f s) (transportUnitary W (phaseUnitary f t) y) :=
  transportUnitary_add W (phaseUnitary f) (fun s t x => phaseUnitary_add f s t x) s t y

/-- ... strongly continuous at `0`. -/
theorem tendsto_transported_position_unitary (f : ℤ → ℝ) (W : L2Z ≃ₗᵢ[ℂ] K) (y : K) :
    Filter.Tendsto (fun t : ℝ => transportUnitary W (phaseUnitary f t) y) (nhds 0) (nhds y) :=
  tendsto_transportUnitary W (phaseUnitary f) (tendsto_phaseUnitary f) y

/-- ... with the transported operator as its generator: **Stone's relation** holds
for every operator unitarily equivalent to lattice multiplication. -/
theorem tendsto_slope_transported_position (f : ℤ → ℝ) (W : L2Z ≃ₗᵢ[ℂ] K)
    (y : transportDomain W (mulDomain f)) :
    Filter.Tendsto
      (fun t : ℝ => (t⁻¹ : ℝ) • (transportUnitary W (phaseUnitary f t) (y : K) - (y : K)))
      (nhdsWithin 0 {0}ᶜ) (nhds (Complex.I • transportOp W (mulDomain f) (mulOp f) y)) :=
  tendsto_slope_transportUnitary W _ _ (phaseUnitary f) (tendsto_slope_phaseUnitary f) y

end BookProof.ChapterUnitaryTransport

def IsSymmetricOn (D : Submodule ℂ H) (A : D →ₗ[ℂ] H) : Prop :=
  ∀ psi phi : D, ⟪A psi, (phi : H)⟫_ℂ = ⟪(psi : H), A phi⟫_ℂ

/-- `A` is **self-adjoint** on its domain: the adjoint domain is not merely
contained in but *equal* to `D`. -/
def IsSelfAdjointOn (D : Submodule ℂ H) (A : D →ₗ[ℂ] H) : Prop :=
  adjointDomain D A = (D : Set H)

theorem inner_map_symm (W : H ≃ₗᵢ[ℂ] K) (x : H) (y : K) :
    ⟪W x, y⟫_ℂ = ⟪x, W.symm y⟫_ℂ := by
  conv_lhs => rw [← W.apply_symm_apply y]
  exact W.inner_map_map _ _

theorem map_real_smul (W : H ≃ₗᵢ[ℂ] K) (r : ℝ) (x : H) : W (r • x) = r • W x := by
  rw [← Complex.coe_smul, ← Complex.coe_smul, map_smul]

/-! ## Transporting the domain and the operator -/

/-- The transported domain `W(D) ⊆ K`. -/
def transportDomain (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) : Submodule ℂ K :=
  D.map (W.toLinearEquiv : H →ₗ[ℂ] K)

theorem coe_transportDomain (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) :
    ((transportDomain W D : Submodule ℂ K) : Set K) = W '' (D : Set H) := rfl

/-- `W` restricts to a linear equivalence `D ≃ W(D)`. -/
noncomputable def transportEquiv (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) :
    D ≃ₗ[ℂ] transportDomain W D :=
  W.toLinearEquiv.submoduleMap D

@[simp] theorem transportEquiv_coe (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (x : D) :
    ((transportEquiv W D x : transportDomain W D) : K) = W (x : H) := rfl

/-- The **transported operator** `W A W⁻¹`, defined on `W(D)`. -/
noncomputable def transportOp (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H) :
    transportDomain W D →ₗ[ℂ] K :=
  (W.toLinearEquiv : H →ₗ[ℂ] K) ∘ₗ A ∘ₗ ((transportEquiv W D).symm : transportDomain W D →ₗ[ℂ] D)

theorem transportOp_apply (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H) (x : D) :
    transportOp W D A (transportEquiv W D x) = W (A x) := by
  simp [transportOp]

/-! ## The structural properties transport -/

/-- A unitary carries a dense domain to a dense domain. -/
theorem transportDomain_dense (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H)
    (hD : Dense ((D : Submodule ℂ H) : Set H)) :
    Dense ((transportDomain W D : Submodule ℂ K) : Set K) := by
  rw [coe_transportDomain]
  exact W.toHomeomorph.isDenseEmbedding.dense_image.2 hD

/-- Symmetry transports. -/
theorem transportOp_symmetric (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H)
    (hA : IsSymmetricOn D A) : IsSymmetricOn (transportDomain W D) (transportOp W D A) := by
  intro y z
  obtain ⟨a, rfl⟩ := (transportEquiv W D).surjective y
  obtain ⟨b, rfl⟩ := (transportEquiv W D).surjective z
  rw [transportOp_apply, transportOp_apply]
  simpa using hA a b

/-- The adjoint domain of the transported operator is the image of the adjoint
domain — the key step, since self-adjointness is an equality of domains. -/
theorem transport_adjointDomain (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H) :
    adjointDomain (transportDomain W D) (transportOp W D A) = W '' adjointDomain D A := by
  ext phi'
  constructor
  · rintro ⟨eta', h⟩
    refine ⟨W.symm phi', ⟨W.symm eta', fun psi => ?_⟩, by simp⟩
    have hkey := h (transportEquiv W D psi)
    rw [transportOp_apply, inner_map_symm] at hkey
    rw [hkey, transportEquiv_coe, inner_map_symm]
  · rintro ⟨phi, ⟨eta, h⟩, rfl⟩
    refine ⟨W eta, fun y => ?_⟩
    obtain ⟨a, rfl⟩ := (transportEquiv W D).surjective y
    rw [transportOp_apply, transportEquiv_coe, W.inner_map_map, W.inner_map_map]
    exact h a

/-- **Self-adjointness transports along a unitary.** -/
theorem transport_isSelfAdjointOn (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H)
    (hA : IsSelfAdjointOn D A) :
    IsSelfAdjointOn (transportDomain W D) (transportOp W D A) := by
  rw [IsSelfAdjointOn, transport_adjointDomain, hA, coe_transportDomain]

/-! ## The unitary group transports -/

/-- The transported unitary `W U W⁻¹`. -/
noncomputable def transportUnitary (W : H ≃ₗᵢ[ℂ] K) (U : H ≃ₗᵢ[ℂ] H) : K ≃ₗᵢ[ℂ] K :=
  (W.symm.trans U).trans W

@[simp] theorem transportUnitary_apply (W : H ≃ₗᵢ[ℂ] K) (U : H ≃ₗᵢ[ℂ] H) (y : K) :
    transportUnitary W U y = W (U (W.symm y)) := rfl

/-- The one-parameter group law transports. -/
theorem transportUnitary_add (W : H ≃ₗᵢ[ℂ] K) (U : ℝ → H ≃ₗᵢ[ℂ] H)
    (h : ∀ s t : ℝ, ∀ x : H, U (s + t) x = U s (U t x)) (s t : ℝ) (y : K) :
    transportUnitary W (U (s + t)) y
      = transportUnitary W (U s) (transportUnitary W (U t) y) := by
  simp [h]

/-- `V 0 = 1` transports. -/
theorem transportUnitary_zero (W : H ≃ₗᵢ[ℂ] K) (U : H ≃ₗᵢ[ℂ] H) (h : ∀ x : H, U x = x)
    (y : K) : transportUnitary W U y = y := by
  simp [h]

/-- **Strong continuity transports.** -/
theorem tendsto_transportUnitary (W : H ≃ₗᵢ[ℂ] K) (U : ℝ → H ≃ₗᵢ[ℂ] H)
    (h : ∀ x : H, Filter.Tendsto (fun t : ℝ => U t x) (nhds 0) (nhds x)) (y : K) :
    Filter.Tendsto (fun t : ℝ => transportUnitary W (U t) y) (nhds 0) (nhds y) := by
  have := (W.continuous.tendsto (W.symm y)).comp (h (W.symm y))
  simpa [Function.comp] using this

/-- **Stone's relation transports**: if `A` generates `U` on `D`, then `W A W⁻¹`
generates `W U W⁻¹` on `W(D)`. -/
theorem tendsto_slope_transportUnitary (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H)
    (U : ℝ → H ≃ₗᵢ[ℂ] H)
    (h : ∀ x : D, Filter.Tendsto (fun t : ℝ => (t⁻¹ : ℝ) • (U t (x : H) - (x : H)))
      (nhdsWithin 0 {0}ᶜ) (nhds (Complex.I • A x)))
    (y : transportDomain W D) :
    Filter.Tendsto (fun t : ℝ => (t⁻¹ : ℝ) • (transportUnitary W (U t) (y : K) - (y : K)))
      (nhdsWithin 0 {0}ᶜ) (nhds (Complex.I • transportOp W D A y)) := by
  obtain ⟨a, rfl⟩ := (transportEquiv W D).surjective y
  rw [transportOp_apply]
  have hW := (W.continuous.tendsto (Complex.I • A a)).comp (h a)
  have hlim : Filter.Tendsto
      (fun t : ℝ => W ((t⁻¹ : ℝ) • (U t (a : H) - (a : H))))
      (nhdsWithin 0 {0}ᶜ) (nhds (W (Complex.I • A a))) := by
    simpa [Function.comp] using hW
  rw [map_smul] at hlim
  refine hlim.congr fun t => ?_
  rw [map_real_smul, map_sub, transportUnitary_apply, transportEquiv_coe,
    LinearIsometryEquiv.symm_apply_apply]

/-! ## Consequence: everything unitarily equivalent to lattice multiplication -/


/-- The concrete `adjointDomain` of `ChapterUnboundedPosition` is the abstract one. -/
theorem adjointDomain_mulOp (f : ℤ → ℝ) :
    adjointDomain (mulDomain f) (mulOp f) = BookProof.ChapterUnboundedPosition.adjointDomain f :=
  rfl

/-- Lattice multiplication is self-adjoint in the abstract sense. -/
theorem mulOp_isSelfAdjointOn (f : ℤ → ℝ) : IsSelfAdjointOn (mulDomain f) (mulOp f) := by
  rw [IsSelfAdjointOn, adjointDomain_mulOp]
  exact adjointDomain_eq_mulDomain f

/-- **Any operator unitarily equivalent to a lattice multiplication operator is
self-adjoint on its (dense) domain.** -/
theorem transported_position_isSelfAdjointOn (f : ℤ → ℝ) (W : L2Z ≃ₗᵢ[ℂ] K) :
    IsSelfAdjointOn (transportDomain W (mulDomain f)) (transportOp W (mulDomain f) (mulOp f)) :=
  transport_isSelfAdjointOn W _ _ (mulOp_isSelfAdjointOn f)

/-- ... on a dense domain. -/
theorem transported_position_domain_dense (f : ℤ → ℝ) (W : L2Z ≃ₗᵢ[ℂ] K) :
    Dense ((transportDomain W (mulDomain f) : Submodule ℂ K) : Set K) :=
  transportDomain_dense W _ (mulDomain_dense f)

/-- ... and it carries a one-parameter unitary group. -/
theorem transported_position_group (f : ℤ → ℝ) (W : L2Z ≃ₗᵢ[ℂ] K) (s t : ℝ) (y : K) :
    transportUnitary W (phaseUnitary f (s + t)) y
      = transportUnitary W (phaseUnitary f s) (transportUnitary W (phaseUnitary f t) y) :=
  transportUnitary_add W (phaseUnitary f) (fun s t x => phaseUnitary_add f s t x) s t y

/-- ... strongly continuous at `0`. -/
theorem tendsto_transported_position_unitary (f : ℤ → ℝ) (W : L2Z ≃ₗᵢ[ℂ] K) (y : K) :
    Filter.Tendsto (fun t : ℝ => transportUnitary W (phaseUnitary f t) y) (nhds 0) (nhds y) :=
  tendsto_transportUnitary W (phaseUnitary f) (tendsto_phaseUnitary f) y

/-- ... with the transported operator as its generator: **Stone's relation** holds
for every operator unitarily equivalent to lattice multiplication. -/
theorem tendsto_slope_transported_position (f : ℤ → ℝ) (W : L2Z ≃ₗᵢ[ℂ] K)
    (y : transportDomain W (mulDomain f)) :
    Filter.Tendsto
      (fun t : ℝ => (t⁻¹ : ℝ) • (transportUnitary W (phaseUnitary f t) (y : K) - (y : K)))
      (nhdsWithin 0 {0}ᶜ) (nhds (Complex.I • transportOp W (mulDomain f) (mulOp f) y)) :=
  tendsto_slope_transportUnitary W _ _ (phaseUnitary f) (tendsto_slope_phaseUnitary f) y

end BookProof.ChapterUnitaryTransport
/-! ## Cross-chapter definitions from `BookProof.ChapterUnitaryTransport` -/
def IsSelfAdjointOn (D : Submodule ℂ H) (A : D →ₗ[ℂ] H) : Prop :=
  adjointDomain D A = (D : Set H)

theorem inner_map_symm (W : H ≃ₗᵢ[ℂ] K) (x : H) (y : K) :
    ⟪W x, y⟫_ℂ = ⟪x, W.symm y⟫_ℂ := by
  conv_lhs => rw [← W.apply_symm_apply y]
  exact W.inner_map_map _ _

theorem map_real_smul (W : H ≃ₗᵢ[ℂ] K) (r : ℝ) (x : H) : W (r • x) = r • W x := by
  rw [← Complex.coe_smul, ← Complex.coe_smul, map_smul]

/-! ## Transporting the domain and the operator -/

/-- The transported domain `W(D) ⊆ K`. -/
def transportDomain (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) : Submodule ℂ K :=
  D.map (W.toLinearEquiv : H →ₗ[ℂ] K)

theorem coe_transportDomain (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) :
    ((transportDomain W D : Submodule ℂ K) : Set K) = W '' (D : Set H) := rfl

/-- `W` restricts to a linear equivalence `D ≃ W(D)`. -/
noncomputable def transportEquiv (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) :
    D ≃ₗ[ℂ] transportDomain W D :=
  W.toLinearEquiv.submoduleMap D

@[simp] theorem transportEquiv_coe (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (x : D) :
    ((transportEquiv W D x : transportDomain W D) : K) = W (x : H) := rfl

/-- The **transported operator** `W A W⁻¹`, defined on `W(D)`. -/
noncomputable def transportOp (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H) :
    transportDomain W D →ₗ[ℂ] K :=
  (W.toLinearEquiv : H →ₗ[ℂ] K) ∘ₗ A ∘ₗ ((transportEquiv W D).symm : transportDomain W D →ₗ[ℂ] D)

theorem transportOp_apply (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H) (x : D) :
    transportOp W D A (transportEquiv W D x) = W (A x) := by
  simp [transportOp]

/-! ## The structural properties transport -/

/-- A unitary carries a dense domain to a dense domain. -/
theorem transportDomain_dense (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H)
    (hD : Dense ((D : Submodule ℂ H) : Set H)) :
    Dense ((transportDomain W D : Submodule ℂ K) : Set K) := by
  rw [coe_transportDomain]
  exact W.toHomeomorph.isDenseEmbedding.dense_image.2 hD

/-- Symmetry transports. -/
theorem transportOp_symmetric (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H)
    (hA : IsSymmetricOn D A) : IsSymmetricOn (transportDomain W D) (transportOp W D A) := by
  intro y z
  obtain ⟨a, rfl⟩ := (transportEquiv W D).surjective y
  obtain ⟨b, rfl⟩ := (transportEquiv W D).surjective z
  rw [transportOp_apply, transportOp_apply]
  simpa using hA a b

/-- The adjoint domain of the transported operator is the image of the adjoint
domain — the key step, since self-adjointness is an equality of domains. -/
theorem transport_adjointDomain (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H) :
    adjointDomain (transportDomain W D) (transportOp W D A) = W '' adjointDomain D A := by
  ext phi'
  constructor
  · rintro ⟨eta', h⟩
    refine ⟨W.symm phi', ⟨W.symm eta', fun psi => ?_⟩, by simp⟩
    have hkey := h (transportEquiv W D psi)
    rw [transportOp_apply, inner_map_symm] at hkey
    rw [hkey, transportEquiv_coe, inner_map_symm]
  · rintro ⟨phi, ⟨eta, h⟩, rfl⟩
    refine ⟨W eta, fun y => ?_⟩
    obtain ⟨a, rfl⟩ := (transportEquiv W D).surjective y
    rw [transportOp_apply, transportEquiv_coe, W.inner_map_map, W.inner_map_map]
    exact h a

/-- **Self-adjointness transports along a unitary.** -/
theorem transport_isSelfAdjointOn (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H)
    (hA : IsSelfAdjointOn D A) :
    IsSelfAdjointOn (transportDomain W D) (transportOp W D A) := by
  rw [IsSelfAdjointOn, transport_adjointDomain, hA, coe_transportDomain]

/-! ## The unitary group transports -/

/-- The transported unitary `W U W⁻¹`. -/
noncomputable def transportUnitary (W : H ≃ₗᵢ[ℂ] K) (U : H ≃ₗᵢ[ℂ] H) : K ≃ₗᵢ[ℂ] K :=
  (W.symm.trans U).trans W

@[simp] theorem transportUnitary_apply (W : H ≃ₗᵢ[ℂ] K) (U : H ≃ₗᵢ[ℂ] H) (y : K) :
    transportUnitary W U y = W (U (W.symm y)) := rfl

/-- The one-parameter group law transports. -/
theorem transportUnitary_add (W : H ≃ₗᵢ[ℂ] K) (U : ℝ → H ≃ₗᵢ[ℂ] H)
    (h : ∀ s t : ℝ, ∀ x : H, U (s + t) x = U s (U t x)) (s t : ℝ) (y : K) :
    transportUnitary W (U (s + t)) y
      = transportUnitary W (U s) (transportUnitary W (U t) y) := by
  simp [h]

/-- `V 0 = 1` transports. -/
theorem transportUnitary_zero (W : H ≃ₗᵢ[ℂ] K) (U : H ≃ₗᵢ[ℂ] H) (h : ∀ x : H, U x = x)
    (y : K) : transportUnitary W U y = y := by
  simp [h]

/-- **Strong continuity transports.** -/
theorem tendsto_transportUnitary (W : H ≃ₗᵢ[ℂ] K) (U : ℝ → H ≃ₗᵢ[ℂ] H)
    (h : ∀ x : H, Filter.Tendsto (fun t : ℝ => U t x) (nhds 0) (nhds x)) (y : K) :
    Filter.Tendsto (fun t : ℝ => transportUnitary W (U t) y) (nhds 0) (nhds y) := by
  have := (W.continuous.tendsto (W.symm y)).comp (h (W.symm y))
  simpa [Function.comp] using this

/-- **Stone's relation transports**: if `A` generates `U` on `D`, then `W A W⁻¹`
generates `W U W⁻¹` on `W(D)`. -/
theorem tendsto_slope_transportUnitary (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H)
    (U : ℝ → H ≃ₗᵢ[ℂ] H)
    (h : ∀ x : D, Filter.Tendsto (fun t : ℝ => (t⁻¹ : ℝ) • (U t (x : H) - (x : H)))
      (nhdsWithin 0 {0}ᶜ) (nhds (Complex.I • A x)))
    (y : transportDomain W D) :
    Filter.Tendsto (fun t : ℝ => (t⁻¹ : ℝ) • (transportUnitary W (U t) (y : K) - (y : K)))
      (nhdsWithin 0 {0}ᶜ) (nhds (Complex.I • transportOp W D A y)) := by
  obtain ⟨a, rfl⟩ := (transportEquiv W D).surjective y
  rw [transportOp_apply]
  have hW := (W.continuous.tendsto (Complex.I • A a)).comp (h a)
  have hlim : Filter.Tendsto
      (fun t : ℝ => W ((t⁻¹ : ℝ) • (U t (a : H) - (a : H))))
      (nhdsWithin 0 {0}ᶜ) (nhds (W (Complex.I • A a))) := by
    simpa [Function.comp] using hW
  rw [map_smul] at hlim
  refine hlim.congr fun t => ?_
  rw [map_real_smul, map_sub, transportUnitary_apply, transportEquiv_coe,
    LinearIsometryEquiv.symm_apply_apply]

/-! ## Consequence: everything unitarily equivalent to lattice multiplication -/


/-- The concrete `adjointDomain` of `ChapterUnboundedPosition` is the abstract one. -/
theorem adjointDomain_mulOp (f : ℤ → ℝ) :
    adjointDomain (mulDomain f) (mulOp f) = BookProof.ChapterUnboundedPosition.adjointDomain f :=
  rfl

/-- Lattice multiplication is self-adjoint in the abstract sense. -/
theorem mulOp_isSelfAdjointOn (f : ℤ → ℝ) : IsSelfAdjointOn (mulDomain f) (mulOp f) := by
  rw [IsSelfAdjointOn, adjointDomain_mulOp]
  exact adjointDomain_eq_mulDomain f

/-- **Any operator unitarily equivalent to a lattice multiplication operator is
self-adjoint on its (dense) domain.** -/
theorem transported_position_isSelfAdjointOn (f : ℤ → ℝ) (W : L2Z ≃ₗᵢ[ℂ] K) :
    IsSelfAdjointOn (transportDomain W (mulDomain f)) (transportOp W (mulDomain f) (mulOp f)) :=
  transport_isSelfAdjointOn W _ _ (mulOp_isSelfAdjointOn f)

/-- ... on a dense domain. -/
theorem transported_position_domain_dense (f : ℤ → ℝ) (W : L2Z ≃ₗᵢ[ℂ] K) :
    Dense ((transportDomain W (mulDomain f) : Submodule ℂ K) : Set K) :=
  transportDomain_dense W _ (mulDomain_dense f)

/-- ... and it carries a one-parameter unitary group. -/
theorem transported_position_group (f : ℤ → ℝ) (W : L2Z ≃ₗᵢ[ℂ] K) (s t : ℝ) (y : K) :
    transportUnitary W (phaseUnitary f (s + t)) y
      = transportUnitary W (phaseUnitary f s) (transportUnitary W (phaseUnitary f t) y) :=
  transportUnitary_add W (phaseUnitary f) (fun s t x => phaseUnitary_add f s t x) s t y

/-- ... strongly continuous at `0`. -/
theorem tendsto_transported_position_unitary (f : ℤ → ℝ) (W : L2Z ≃ₗᵢ[ℂ] K) (y : K) :
    Filter.Tendsto (fun t : ℝ => transportUnitary W (phaseUnitary f t) y) (nhds 0) (nhds y) :=
  tendsto_transportUnitary W (phaseUnitary f) (tendsto_phaseUnitary f) y

/-- ... with the transported operator as its generator: **Stone's relation** holds
for every operator unitarily equivalent to lattice multiplication. -/
theorem tendsto_slope_transported_position (f : ℤ → ℝ) (W : L2Z ≃ₗᵢ[ℂ] K)
    (y : transportDomain W (mulDomain f)) :
    Filter.Tendsto
      (fun t : ℝ => (t⁻¹ : ℝ) • (transportUnitary W (phaseUnitary f t) (y : K) - (y : K)))
      (nhdsWithin 0 {0}ᶜ) (nhds (Complex.I • transportOp W (mulDomain f) (mulOp f) y)) :=
  tendsto_slope_transportUnitary W _ _ (phaseUnitary f) (tendsto_slope_phaseUnitary f) y

end BookProof.ChapterUnitaryTransport

def IsSymmetricOn (D : Submodule ℂ H) (A : D →ₗ[ℂ] H) : Prop :=
  ∀ psi phi : D, ⟪A psi, (phi : H)⟫_ℂ = ⟪(psi : H), A phi⟫_ℂ

/-- `A` is **self-adjoint** on its domain: the adjoint domain is not merely
contained in but *equal* to `D`. -/
def IsSelfAdjointOn (D : Submodule ℂ H) (A : D →ₗ[ℂ] H) : Prop :=
  adjointDomain D A = (D : Set H)

theorem inner_map_symm (W : H ≃ₗᵢ[ℂ] K) (x : H) (y : K) :
    ⟪W x, y⟫_ℂ = ⟪x, W.symm y⟫_ℂ := by
  conv_lhs => rw [← W.apply_symm_apply y]
  exact W.inner_map_map _ _

theorem map_real_smul (W : H ≃ₗᵢ[ℂ] K) (r : ℝ) (x : H) : W (r • x) = r • W x := by
  rw [← Complex.coe_smul, ← Complex.coe_smul, map_smul]

/-! ## Transporting the domain and the operator -/

/-- The transported domain `W(D) ⊆ K`. -/
def transportDomain (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) : Submodule ℂ K :=
  D.map (W.toLinearEquiv : H →ₗ[ℂ] K)

theorem coe_transportDomain (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) :
    ((transportDomain W D : Submodule ℂ K) : Set K) = W '' (D : Set H) := rfl

/-- `W` restricts to a linear equivalence `D ≃ W(D)`. -/
noncomputable def transportEquiv (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) :
    D ≃ₗ[ℂ] transportDomain W D :=
  W.toLinearEquiv.submoduleMap D

@[simp] theorem transportEquiv_coe (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (x : D) :
    ((transportEquiv W D x : transportDomain W D) : K) = W (x : H) := rfl

/-- The **transported operator** `W A W⁻¹`, defined on `W(D)`. -/
noncomputable def transportOp (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H) :
    transportDomain W D →ₗ[ℂ] K :=
  (W.toLinearEquiv : H →ₗ[ℂ] K) ∘ₗ A ∘ₗ ((transportEquiv W D).symm : transportDomain W D →ₗ[ℂ] D)

theorem transportOp_apply (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H) (x : D) :
    transportOp W D A (transportEquiv W D x) = W (A x) := by
  simp [transportOp]

/-! ## The structural properties transport -/

/-- A unitary carries a dense domain to a dense domain. -/
theorem transportDomain_dense (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H)
    (hD : Dense ((D : Submodule ℂ H) : Set H)) :
    Dense ((transportDomain W D : Submodule ℂ K) : Set K) := by
  rw [coe_transportDomain]
  exact W.toHomeomorph.isDenseEmbedding.dense_image.2 hD

/-- Symmetry transports. -/
theorem transportOp_symmetric (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H)
    (hA : IsSymmetricOn D A) : IsSymmetricOn (transportDomain W D) (transportOp W D A) := by
  intro y z
  obtain ⟨a, rfl⟩ := (transportEquiv W D).surjective y
  obtain ⟨b, rfl⟩ := (transportEquiv W D).surjective z
  rw [transportOp_apply, transportOp_apply]
  simpa using hA a b

/-- The adjoint domain of the transported operator is the image of the adjoint
domain — the key step, since self-adjointness is an equality of domains. -/
theorem transport_adjointDomain (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H) :
    adjointDomain (transportDomain W D) (transportOp W D A) = W '' adjointDomain D A := by
  ext phi'
  constructor
  · rintro ⟨eta', h⟩
    refine ⟨W.symm phi', ⟨W.symm eta', fun psi => ?_⟩, by simp⟩
    have hkey := h (transportEquiv W D psi)
    rw [transportOp_apply, inner_map_symm] at hkey
    rw [hkey, transportEquiv_coe, inner_map_symm]
  · rintro ⟨phi, ⟨eta, h⟩, rfl⟩
    refine ⟨W eta, fun y => ?_⟩
    obtain ⟨a, rfl⟩ := (transportEquiv W D).surjective y
    rw [transportOp_apply, transportEquiv_coe, W.inner_map_map, W.inner_map_map]
    exact h a

/-- **Self-adjointness transports along a unitary.** -/
theorem transport_isSelfAdjointOn (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H)
    (hA : IsSelfAdjointOn D A) :
    IsSelfAdjointOn (transportDomain W D) (transportOp W D A) := by
  rw [IsSelfAdjointOn, transport_adjointDomain, hA, coe_transportDomain]

/-! ## The unitary group transports -/

/-- The transported unitary `W U W⁻¹`. -/
noncomputable def transportUnitary (W : H ≃ₗᵢ[ℂ] K) (U : H ≃ₗᵢ[ℂ] H) : K ≃ₗᵢ[ℂ] K :=
  (W.symm.trans U).trans W

@[simp] theorem transportUnitary_apply (W : H ≃ₗᵢ[ℂ] K) (U : H ≃ₗᵢ[ℂ] H) (y : K) :
    transportUnitary W U y = W (U (W.symm y)) := rfl

/-- The one-parameter group law transports. -/
theorem transportUnitary_add (W : H ≃ₗᵢ[ℂ] K) (U : ℝ → H ≃ₗᵢ[ℂ] H)
    (h : ∀ s t : ℝ, ∀ x : H, U (s + t) x = U s (U t x)) (s t : ℝ) (y : K) :
    transportUnitary W (U (s + t)) y
      = transportUnitary W (U s) (transportUnitary W (U t) y) := by
  simp [h]

/-- `V 0 = 1` transports. -/
theorem transportUnitary_zero (W : H ≃ₗᵢ[ℂ] K) (U : H ≃ₗᵢ[ℂ] H) (h : ∀ x : H, U x = x)
    (y : K) : transportUnitary W U y = y := by
  simp [h]

/-- **Strong continuity transports.** -/
theorem tendsto_transportUnitary (W : H ≃ₗᵢ[ℂ] K) (U : ℝ → H ≃ₗᵢ[ℂ] H)
    (h : ∀ x : H, Filter.Tendsto (fun t : ℝ => U t x) (nhds 0) (nhds x)) (y : K) :
    Filter.Tendsto (fun t : ℝ => transportUnitary W (U t) y) (nhds 0) (nhds y) := by
  have := (W.continuous.tendsto (W.symm y)).comp (h (W.symm y))
  simpa [Function.comp] using this

/-- **Stone's relation transports**: if `A` generates `U` on `D`, then `W A W⁻¹`
generates `W U W⁻¹` on `W(D)`. -/
theorem tendsto_slope_transportUnitary (W : H ≃ₗᵢ[ℂ] K) (D : Submodule ℂ H) (A : D →ₗ[ℂ] H)
    (U : ℝ → H ≃ₗᵢ[ℂ] H)
    (h : ∀ x : D, Filter.Tendsto (fun t : ℝ => (t⁻¹ : ℝ) • (U t (x : H) - (x : H)))
      (nhdsWithin 0 {0}ᶜ) (nhds (Complex.I • A x)))
    (y : transportDomain W D) :
    Filter.Tendsto (fun t : ℝ => (t⁻¹ : ℝ) • (transportUnitary W (U t) (y : K) - (y : K)))
      (nhdsWithin 0 {0}ᶜ) (nhds (Complex.I • transportOp W D A y)) := by
  obtain ⟨a, rfl⟩ := (transportEquiv W D).surjective y
  rw [transportOp_apply]
  have hW := (W.continuous.tendsto (Complex.I • A a)).comp (h a)
  have hlim : Filter.Tendsto
      (fun t : ℝ => W ((t⁻¹ : ℝ) • (U t (a : H) - (a : H))))
      (nhdsWithin 0 {0}ᶜ) (nhds (W (Complex.I • A a))) := by
    simpa [Function.comp] using hW
  rw [map_smul] at hlim
  refine hlim.congr fun t => ?_
  rw [map_real_smul, map_sub, transportUnitary_apply, transportEquiv_coe,
    LinearIsometryEquiv.symm_apply_apply]

/-! ## Consequence: everything unitarily equivalent to lattice multiplication -/


/-- The concrete `adjointDomain` of `ChapterUnboundedPosition` is the abstract one. -/
theorem adjointDomain_mulOp (f : ℤ → ℝ) :
    adjointDomain (mulDomain f) (mulOp f) = BookProof.ChapterUnboundedPosition.adjointDomain f :=
  rfl

/-- Lattice multiplication is self-adjoint in the abstract sense. -/
theorem mulOp_isSelfAdjointOn (f : ℤ → ℝ) : IsSelfAdjointOn (mulDomain f) (mulOp f) := by
  rw [IsSelfAdjointOn, adjointDomain_mulOp]
  exact adjointDomain_eq_mulDomain f

/-- **Any operator unitarily equivalent to a lattice multiplication operator is
self-adjoint on its (dense) domain.** -/
theorem transported_position_isSelfAdjointOn (f : ℤ → ℝ) (W : L2Z ≃ₗᵢ[ℂ] K) :
    IsSelfAdjointOn (transportDomain W (mulDomain f)) (transportOp W (mulDomain f) (mulOp f)) :=
  transport_isSelfAdjointOn W _ _ (mulOp_isSelfAdjointOn f)

/-- ... on a dense domain. -/
theorem transported_position_domain_dense (f : ℤ → ℝ) (W : L2Z ≃ₗᵢ[ℂ] K) :
    Dense ((transportDomain W (mulDomain f) : Submodule ℂ K) : Set K) :=
  transportDomain_dense W _ (mulDomain_dense f)

/-- ... and it carries a one-parameter unitary group. -/
theorem transported_position_group (f : ℤ → ℝ) (W : L2Z ≃ₗᵢ[ℂ] K) (s t : ℝ) (y : K) :
    transportUnitary W (phaseUnitary f (s + t)) y
      = transportUnitary W (phaseUnitary f s) (transportUnitary W (phaseUnitary f t) y) :=
  transportUnitary_add W (phaseUnitary f) (fun s t x => phaseUnitary_add f s t x) s t y

/-- ... strongly continuous at `0`. -/
theorem tendsto_transported_position_unitary (f : ℤ → ℝ) (W : L2Z ≃ₗᵢ[ℂ] K) (y : K) :
    Filter.Tendsto (fun t : ℝ => transportUnitary W (phaseUnitary f t) y) (nhds 0) (nhds y) :=
  tendsto_transportUnitary W (phaseUnitary f) (tendsto_phaseUnitary f) y

/-- ... with the transported operator as its generator: **Stone's relation** holds
for every operator unitarily equivalent to lattice multiplication. -/
theorem tendsto_slope_transported_position (f : ℤ → ℝ) (W : L2Z ≃ₗᵢ[ℂ] K)
    (y : transportDomain W (mulDomain f)) :
    Filter.Tendsto
      (fun t : ℝ => (t⁻¹ : ℝ) • (transportUnitary W (phaseUnitary f t) (y : K) - (y : K)))
      (nhdsWithin 0 {0}ᶜ) (nhds (Complex.I • transportOp W (mulDomain f) (mulOp f) y)) :=
  tendsto_slope_transportUnitary W _ _ (phaseUnitary f) (tendsto_slope_phaseUnitary f) y

end BookProof.ChapterUnitaryTransport

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

/-- Differentiating a Hilbert-space valued curve inside an inner product. -/
theorem hasDerivAt_inner_right {f : ℝ → H} {f' : H} {t : ℝ} (y : H) (h : HasDerivAt f f' t) :
    HasDerivAt (fun s => ⟪y, f s⟫_ℂ) (⟪y, f'⟫_ℂ) t :=
  ((innerSL ℂ y).restrictScalars ℝ).hasFDerivAt.comp_hasDerivAt t h

/-- Complex conjugation may be pushed through a derivative. -/
theorem hasDerivAt_conj {g : ℝ → ℂ} {g' : ℂ} {t : ℝ} (h : HasDerivAt g g' t) :
    HasDerivAt (fun s => (starRingEnd ℂ) (g s)) ((starRingEnd ℂ) g') t :=
  (Complex.conjCLE : ℂ →L[ℝ] ℂ).hasFDerivAt.comp_hasDerivAt t h

/-- A continuous linear map may be pushed through a derivative. -/
theorem hasDerivAt_clm {f : ℝ → H} {f' : H} {t : ℝ} (L : H →L[ℂ] H) (h : HasDerivAt f f' t) :
    HasDerivAt (fun s => L (f s)) (L f') t :=
  (L.restrictScalars ℝ).hasFDerivAt.comp_hasDerivAt t h

namespace WeakMeasurableUnitaryGroup

variable [CompleteSpace H] [TopologicalSpace.SeparableSpace H]
variable (G : WeakMeasurableUnitaryGroup H)

/-! ## The domain and the generator -/

/-- The domain of the infinitesimal generator: the vectors whose orbit is differentiable. -/
def genDomain : Submodule ℂ H where
  carrier := {x : H | DifferentiableAt ℝ (fun t : ℝ => G.U t x) 0}
  add_mem' := by
    intro x y hx hy
    have h : (fun t : ℝ => G.U t (x + y)) = fun t : ℝ => G.U t x + G.U t y := by
      funext t; exact ContinuousLinearMap.map_add (G.U t) x y
    change DifferentiableAt ℝ (fun t : ℝ => G.U t (x + y)) 0
    rw [h]
    exact hx.add hy
  zero_mem' := by
    have h : (fun t : ℝ => G.U t (0 : H)) = fun _ : ℝ => (0 : H) := by
      funext t; exact ContinuousLinearMap.map_zero (G.U t)
    change DifferentiableAt ℝ (fun t : ℝ => G.U t (0 : H)) 0
    rw [h]
    exact differentiableAt_const _
  smul_mem' := by
    intro c x hx
    have h : (fun t : ℝ => G.U t (c • x)) = fun t : ℝ => c • G.U t x := by
      funext t; exact ContinuousLinearMap.map_smul (G.U t) c x
    change DifferentiableAt ℝ (fun t : ℝ => G.U t (c • x)) 0
    rw [h]
    exact hx.const_smul c

omit [CompleteSpace H] [TopologicalSpace.SeparableSpace H] in
theorem mem_genDomain_iff (x : H) :
    x ∈ G.genDomain ↔ DifferentiableAt ℝ (fun t : ℝ => G.U t x) 0 := Iff.rfl

/-- The **infinitesimal generator** `A = i d/dt|₀ U t`. -/
noncomputable def genOp : G.genDomain →ₗ[ℂ] H where
  toFun x := Complex.I • deriv (fun t : ℝ => G.U t (x : H)) 0
  map_add' := by
    intro x y
    have h : (fun t : ℝ => G.U t ((x + y : G.genDomain) : H))
        = fun t : ℝ => G.U t (x : H) + G.U t (y : H) := by
      funext t
      rw [Submodule.coe_add]
      exact ContinuousLinearMap.map_add (G.U t) _ _
    have hd : deriv (fun t : ℝ => G.U t (x : H) + G.U t (y : H)) 0
        = deriv (fun t : ℝ => G.U t (x : H)) 0 + deriv (fun t : ℝ => G.U t (y : H)) 0 :=
      (x.2.hasDerivAt.add y.2.hasDerivAt).deriv
    change Complex.I • deriv (fun t : ℝ => G.U t ((x + y : G.genDomain) : H)) 0 = _
    rw [h, hd, smul_add]
  map_smul' := by
    intro c x
    have h : (fun t : ℝ => G.U t ((c • x : G.genDomain) : H))
        = fun t : ℝ => c • G.U t (x : H) := by
      funext t
      rw [Submodule.coe_smul]
      exact ContinuousLinearMap.map_smul (G.U t) c _
    have hd : deriv (fun t : ℝ => c • G.U t (x : H)) 0
        = c • deriv (fun t : ℝ => G.U t (x : H)) 0 :=
      (x.2.hasDerivAt.const_smul c).deriv
    change Complex.I • deriv (fun t : ℝ => G.U t ((c • x : G.genDomain) : H)) 0 = _
    rw [h, hd]
    simp only [RingHom.id_apply]
    rw [smul_comm]

omit [CompleteSpace H] [TopologicalSpace.SeparableSpace H] in
theorem genOp_apply (x : G.genDomain) :
    G.genOp x = Complex.I • deriv (fun t : ℝ => G.U t (x : H)) 0 := rfl



omit [CompleteSpace H] [TopologicalSpace.SeparableSpace H] in
theorem genOp_eq_of_hasDerivAt {x : G.genDomain} {y : H}
    (h : HasDerivAt (fun t : ℝ => G.U t (x : H)) ((-Complex.I) • y) 0) : G.genOp x = y := by
  rw [genOp_apply, h.deriv, smul_smul]
  simp

omit [CompleteSpace H] [TopologicalSpace.SeparableSpace H] in
/-- The defining differential equation at `t = 0`. -/
theorem hasDerivAt_orbit_zero (x : G.genDomain) :
    HasDerivAt (fun t : ℝ => G.U t (x : H)) ((-Complex.I) • G.genOp x) 0 := by
  have h : DifferentiableAt ℝ (fun t : ℝ => G.U t (x : H)) 0 := x.2
  have := h.hasDerivAt
  rw [genOp_apply, smul_smul]
  simpa using this

/-! ## Invariance of the domain -/

omit [CompleteSpace H] [TopologicalSpace.SeparableSpace H] in
theorem apply_mem_genDomain (s : ℝ) (x : G.genDomain) : G.U s (x : H) ∈ G.genDomain := by
  have h : (fun t : ℝ => G.U t (G.U s (x : H))) = fun t : ℝ => G.U s (G.U t (x : H)) := by
    funext t
    rw [G.apply_apply, G.apply_apply, add_comm]
  rw [mem_genDomain_iff, h]
  exact (hasDerivAt_clm (G.U s) (G.hasDerivAt_orbit_zero x)).differentiableAt

omit [CompleteSpace H] [TopologicalSpace.SeparableSpace H] in
theorem genOp_apply_comm (s : ℝ) (x : G.genDomain) :
    G.genOp ⟨G.U s (x : H), G.apply_mem_genDomain s x⟩ = G.U s (G.genOp x) := by
  refine G.genOp_eq_of_hasDerivAt ?_
  have h : (fun t : ℝ => G.U t (G.U s (x : H))) = fun t : ℝ => G.U s (G.U t (x : H)) := by
    funext t
    rw [G.apply_apply, G.apply_apply, add_comm]
  rw [h]
  have := hasDerivAt_clm (G.U s) (G.hasDerivAt_orbit_zero x)
  simpa using this

omit [CompleteSpace H] [TopologicalSpace.SeparableSpace H] in
/-- The Schrödinger equation at an arbitrary time. -/
theorem hasDerivAt_orbit (x : G.genDomain) (t : ℝ) :
    HasDerivAt (fun s : ℝ => G.U s (x : H)) ((-Complex.I) • G.U t (G.genOp x)) t := by
  have hz : HasDerivAt (fun u : ℝ => G.U t (G.U u (x : H)))
      ((-Complex.I) • G.U t (G.genOp x)) (t - t) := by
    have h0 := hasDerivAt_clm (G.U t) (G.hasDerivAt_orbit_zero x)
    rw [map_smul] at h0
    simpa using h0
  have hshift : HasDerivAt (fun s : ℝ => G.U t (G.U (s - t) (x : H)))
      ((-Complex.I) • G.U t (G.genOp x)) t := HasDerivAt.comp_sub_const t t hz
  refine hshift.congr_of_eventuallyEq ?_
  filter_upwards with s
  rw [G.apply_apply]
  ring_nf

/-! ## The averaged vectors lie in the domain -/

/-- The Bochner average `∫₀ᵃ U t x dt`. -/
noncomputable def bAvg (x : H) (a : ℝ) : H := ∫ t in (0 : ℝ)..a, G.U t x

theorem hasDerivAt_bAvg (x : H) (a : ℝ) :
    HasDerivAt (fun u : ℝ => G.bAvg x u) (G.U a x) a := by
  have hc : Continuous fun t : ℝ => G.U t x := G.continuous_apply x
  exact intervalIntegral.integral_hasDerivAt_right (hc.intervalIntegrable 0 a)
    (hc.stronglyMeasurableAtFilter _ _) hc.continuousAt

theorem apply_bAvg (s a : ℝ) (x : H) :
    G.U s (G.bAvg x a) = G.bAvg x (s + a) - G.bAvg x s := by
  have hc : Continuous fun t : ℝ => G.U t x := G.continuous_apply x
  have h1 : G.U s (G.bAvg x a) = ∫ t in (0 : ℝ)..a, G.U s (G.U t x) := by
    rw [bAvg]
    exact ((G.U s).intervalIntegral_comp_comm (hc.intervalIntegrable 0 a)).symm
  have h2 : (∫ t in (0 : ℝ)..a, G.U s (G.U t x)) = ∫ t in (0 : ℝ)..a, G.U (s + t) x := by
    congr 1
    funext t
    rw [G.apply_apply]
  have h3 : (∫ t in (0 : ℝ)..a, G.U (s + t) x) = ∫ u in (s + 0)..(s + a), G.U u x :=
    intervalIntegral.integral_comp_add_left (f := fun u => G.U u x) (a := (0 : ℝ)) (b := a) s
  rw [h1, h2, h3, add_zero, bAvg, bAvg]
  exact (intervalIntegral.integral_interval_sub_left (hc.intervalIntegrable 0 (s + a))
    (hc.intervalIntegrable 0 s)).symm

theorem bAvg_mem_genDomain (x : H) (a : ℝ) : G.bAvg x a ∈ G.genDomain := by
  have h : (fun s : ℝ => G.U s (G.bAvg x a))
      = fun s : ℝ => G.bAvg x (s + a) - G.bAvg x s := by
    funext s; exact G.apply_bAvg s a x
  rw [mem_genDomain_iff, h]
  have hfa : HasDerivAt (fun u : ℝ => G.bAvg x u) (G.U a x) (0 + a) := by
    simpa using G.hasDerivAt_bAvg x a
  have h1 : HasDerivAt (fun s : ℝ => G.bAvg x (s + a)) (G.U a x) 0 :=
    HasDerivAt.comp_add_const 0 a hfa
  have h2 : HasDerivAt (fun s : ℝ => G.bAvg x s) (G.U 0 x) 0 := G.hasDerivAt_bAvg x 0
  exact (h1.sub h2).differentiableAt



/-! ## Density of the domain -/

theorem norm_bAvg_sub_smul_le (x : H) (a C : ℝ)
    (hC : ∀ t ∈ Set.uIcc (0 : ℝ) a, ‖G.U t x - x‖ ≤ C) :
    ‖G.bAvg x a - (a : ℂ) • x‖ ≤ C * |a| := by
  have hc : Continuous fun t : ℝ => G.U t x := G.continuous_apply x
  have hconst : (∫ _t in (0 : ℝ)..a, x) = (a : ℂ) • x := by
    rw [intervalIntegral.integral_const]
    simp [Complex.coe_smul]
  have hsub : G.bAvg x a - (a : ℂ) • x = ∫ t in (0 : ℝ)..a, (G.U t x - x) := by
    rw [bAvg, ← hconst,
      intervalIntegral.integral_sub (hc.intervalIntegrable 0 a)
        (intervalIntegrable_const)]
  rw [hsub]
  have := intervalIntegral.norm_integral_le_of_norm_le_const
    (a := (0 : ℝ)) (b := a) (C := C) (f := fun t => G.U t x - x)
    (fun t ht => hC t (by simpa [Set.uIoc, Set.uIcc] using Set.Ioc_subset_Icc_self ht))
  simpa using this

theorem denseDomain : Dense ((G.genDomain : Submodule ℂ H) : Set H) := by
  refine Metric.dense_iff.mpr ?_
  intro x r hr
  obtain ⟨δ, hδ, hball⟩ : ∃ δ > 0, ∀ ⦃t : ℝ⦄, dist t 0 < δ → dist (G.U t x) x < r / 2 := by
    have h := Metric.tendsto_nhds.mp (G.tendsto_apply_zero x) (r / 2) (by linarith)
    rw [Metric.eventually_nhds_iff] at h
    obtain ⟨δ, hδ, hb⟩ := h
    exact ⟨δ, hδ, fun t ht => hb ht⟩
  set a : ℝ := δ / 2 with ha
  have ha0 : 0 < a := by positivity
  have haδ : a < δ := by rw [ha]; linarith
  have hbound : ∀ t ∈ Set.uIcc (0 : ℝ) a, ‖G.U t x - x‖ ≤ r / 2 := by
    intro t ht
    rw [Set.uIcc_of_le ha0.le] at ht
    have hdt : dist t 0 < δ := by
      rw [Real.dist_eq, sub_zero, abs_of_nonneg ht.1]
      exact lt_of_le_of_lt ht.2 haδ
    have := hball hdt
    rw [dist_eq_norm] at this
    exact this.le
  have hkey := G.norm_bAvg_sub_smul_le x a (r / 2) hbound
  have hne : (a : ℂ) ≠ 0 := by exact_mod_cast ha0.ne'
  refine ⟨((a : ℂ)⁻¹) • G.bAvg x a, ?_, Submodule.smul_mem _ _ (G.bAvg_mem_genDomain x a)⟩
  rw [Metric.mem_ball, dist_eq_norm]
  have heq : ((a : ℂ)⁻¹) • G.bAvg x a - x = ((a : ℂ)⁻¹) • (G.bAvg x a - (a : ℂ) • x) := by
    rw [smul_sub, smul_smul, inv_mul_cancel₀ hne, one_smul]
  rw [heq, norm_smul]
  have hn : ‖((a : ℂ)⁻¹)‖ = a⁻¹ := by
    rw [norm_inv, Complex.norm_real, Real.norm_eq_abs, abs_of_pos ha0]
  rw [hn]
  calc a⁻¹ * ‖G.bAvg x a - (a : ℂ) • x‖ ≤ a⁻¹ * (r / 2 * a) := by
        have h := mul_le_mul_of_nonneg_left hkey (le_of_lt (inv_pos.mpr ha0))
        rwa [abs_of_pos ha0] at h
    _ = r / 2 := by field_simp
    _ < r := by linarith

/-! ## Symmetry -/

omit [CompleteSpace H] [TopologicalSpace.SeparableSpace H] in
theorem symmetric : BookProof.ChapterUnitaryTransport.IsSymmetricOn G.genDomain G.genOp := by
  intro psi phi
  have hx := G.hasDerivAt_orbit_zero psi
  have hy := G.hasDerivAt_orbit_zero phi
  have hf : HasDerivAt (fun t : ℝ => ⟪(phi : H), G.U t (psi : H)⟫_ℂ)
      (⟪(phi : H), (-Complex.I) • G.genOp psi⟫_ℂ) 0 :=
    hasDerivAt_inner_right (phi : H) hx
  have hyneg : HasDerivAt (fun t : ℝ => G.U (-t) (phi : H))
      ((-1 : ℝ) • ((-Complex.I) • G.genOp phi)) 0 := by
    have h := HasDerivAt.scomp (0 : ℝ) (by simpa using hy) (hasDerivAt_neg (0 : ℝ))
    simpa [Function.comp_def] using h
  have hg : HasDerivAt (fun t : ℝ => ⟪(psi : H), G.U (-t) (phi : H)⟫_ℂ)
      (⟪(psi : H), (-1 : ℝ) • ((-Complex.I) • G.genOp phi)⟫_ℂ) 0 :=
    hasDerivAt_inner_right (psi : H) hyneg
  have hEq : (fun t : ℝ => (starRingEnd ℂ) ⟪(psi : H), G.U (-t) (phi : H)⟫_ℂ)
      = fun t : ℝ => ⟪(phi : H), G.U t (psi : H)⟫_ℂ := by
    funext t
    rw [inner_conj_symm]
    exact (G.inner_adjoint t (phi : H) (psi : H)).symm
  have hfg : HasDerivAt (fun t : ℝ => ⟪(phi : H), G.U t (psi : H)⟫_ℂ)
      ((starRingEnd ℂ) ⟪(psi : H), (-1 : ℝ) • ((-Complex.I) • G.genOp phi)⟫_ℂ) 0 :=
    hEq ▸ hasDerivAt_conj hg
  have hsm : ((-1 : ℝ) • ((-Complex.I) • G.genOp phi)) = Complex.I • G.genOp phi := by
    rw [← Complex.coe_smul, smul_smul]
    norm_num
  have h := hf.unique hfg
  rw [hsm, inner_smul_right, inner_smul_right, map_mul] at h
  have hIne : (-Complex.I) ≠ 0 := by simp
  have hconjI : (starRingEnd ℂ) Complex.I = -Complex.I := by simp
  rw [hconjI] at h
  have key : ⟪(phi : H), G.genOp psi⟫_ℂ
      = (starRingEnd ℂ) ⟪(psi : H), G.genOp phi⟫_ℂ := mul_left_cancel₀ hIne h
  rw [inner_conj_symm] at key
  rw [← inner_conj_symm (G.genOp psi) (phi : H), ← inner_conj_symm (psi : H) (G.genOp phi), key]

/-! ## Self-adjointness -/

omit [CompleteSpace H] [TopologicalSpace.SeparableSpace H] in
/-- Weak convergence together with the bound `‖v i‖ ≤ ‖w‖` forces strong convergence. -/
theorem tendsto_of_weak_of_norm_le {ι : Type*} {l : Filter ι} {v : ι → H} {w : H}
    {D : Set H} (hD : Dense D) (hbd : ∀ᶠ i in l, ‖v i‖ ≤ ‖w‖)
    (hweak : ∀ x ∈ D, Tendsto (fun i => ⟪x, v i⟫_ℂ) l (𝓝 (⟪x, w⟫_ℂ))) :
    Tendsto v l (𝓝 w) := by
  rw [Metric.tendsto_nhds]
  intro ε hε
  set δ : ℝ := ε / 3 with hδdef
  have hδ : 0 < δ := by positivity
  obtain ⟨x, hxD, hxw⟩ : ∃ x ∈ D, dist w x < δ :=
    Metric.mem_closure_iff.mp (hD w) δ hδ
  have hre : Tendsto (fun i => (⟪x, v i⟫_ℂ).re) l (𝓝 ((⟪x, w⟫_ℂ).re)) :=
    (Complex.continuous_re.tendsto _).comp (hweak x hxD)
  have hev : ∀ᶠ i in l, (⟪x, w⟫_ℂ).re - δ ^ 2 / 2 < (⟪x, v i⟫_ℂ).re :=
    hre.eventually (eventually_gt_nhds (by nlinarith))
  filter_upwards [hbd, hev] with i hbi hei
  have hsq : ‖v i - x‖ ^ 2 = ‖v i‖ ^ 2 - 2 * (⟪v i, x⟫_ℂ).re + ‖x‖ ^ 2 := by
    simpa using norm_sub_sq (𝕜 := ℂ) (v i) x
  have hwsq : ‖w - x‖ ^ 2 = ‖w‖ ^ 2 - 2 * (⟪w, x⟫_ℂ).re + ‖x‖ ^ 2 := by
    simpa using norm_sub_sq (𝕜 := ℂ) w x
  have hswap1 : (⟪v i, x⟫_ℂ).re = (⟪x, v i⟫_ℂ).re := by
    rw [← inner_conj_symm (v i) x, Complex.conj_re]
  have hswap2 : (⟪w, x⟫_ℂ).re = (⟪x, w⟫_ℂ).re := by
    rw [← inner_conj_symm w x, Complex.conj_re]
  have hwx : ‖w - x‖ < δ := by rwa [← dist_eq_norm]
  have hwx2 : ‖w‖ ^ 2 - 2 * (⟪x, w⟫_ℂ).re + ‖x‖ ^ 2 < δ ^ 2 := by
    rw [← hswap2, ← hwsq]
    nlinarith [norm_nonneg (w - x)]
  have hlt : ‖v i - x‖ ^ 2 < (2 * δ) ^ 2 := by
    rw [hsq, hswap1]
    nlinarith [norm_nonneg (v i), norm_nonneg w]
  have hvx : ‖v i - x‖ < 2 * δ := by
    have h1 : (0 : ℝ) ≤ ‖v i - x‖ := norm_nonneg _
    nlinarith
  calc dist (v i) w ≤ ‖v i - x‖ + ‖x - w‖ := by
        rw [dist_eq_norm]
        simpa using norm_sub_le_norm_sub_add_norm_sub (v i) x w
    _ < 2 * δ + δ := by
        have : ‖x - w‖ < δ := by rw [norm_sub_rev, ← dist_eq_norm]; exact hxw
        linarith
    _ = ε := by rw [hδdef]; ring

/-! ## Self-adjointness -/

theorem selfAdjoint : BookProof.ChapterUnitaryTransport.IsSelfAdjointOn G.genDomain G.genOp := by
  refine Set.eq_of_subset_of_subset ?_ ?_
  · rintro phi ⟨eta, heta⟩
    -- the matrix coefficient `K u = ⟪φ, U u x⟫` and its derivative
    have hK : ∀ x : G.genDomain, ∀ s : ℝ,
        HasDerivAt (fun u : ℝ => ⟪phi, G.U u (x : H)⟫_ℂ)
          ((-Complex.I) * ⟪eta, G.U s (x : H)⟫_ℂ) s := by
      intro x s
      have h1 := hasDerivAt_inner_right phi (G.hasDerivAt_orbit x s)
      have h2 : ⟪phi, (-Complex.I) • G.U s (G.genOp x)⟫_ℂ
          = (-Complex.I) * ⟪eta, G.U s (x : H)⟫_ℂ := by
        rw [inner_smul_right]
        congr 1
        have hcomm := G.genOp_apply_comm s x
        have hz := heta ⟨G.U s (x : H), G.apply_mem_genDomain s x⟩
        rw [hcomm] at hz
        conv_lhs => rw [← inner_conj_symm]
        rw [hz, inner_conj_symm]
      rw [← h2]
      exact h1
    have hKbd : ∀ x : G.genDomain, ∀ s : ℝ,
        ‖(-Complex.I) * ⟪eta, G.U s (x : H)⟫_ℂ‖ ≤ ‖eta‖ * ‖(x : H)‖ := by
      intro x s
      rw [norm_mul, norm_neg, Complex.norm_I, one_mul]
      calc ‖⟪eta, G.U s (x : H)⟫_ℂ‖ ≤ ‖eta‖ * ‖G.U s (x : H)‖ := norm_inner_le_norm _ _
        _ = ‖eta‖ * ‖(x : H)‖ := by rw [G.norm_map]
    have hMVT : ∀ (x : G.genDomain) (t : ℝ),
        ‖⟪phi, G.U t (x : H)⟫_ℂ - ⟪phi, (x : H)⟫_ℂ‖ ≤ (‖eta‖ * ‖(x : H)‖) * |t| := by
      intro x t
      have h := (convex_univ (𝕜 := ℝ) (E := ℝ)).norm_image_sub_le_of_norm_hasDerivWithin_le
        (f := fun u : ℝ => ⟪phi, G.U u (x : H)⟫_ℂ)
        (f' := fun s : ℝ => (-Complex.I) * ⟪eta, G.U s (x : H)⟫_ℂ)
        (C := ‖eta‖ * ‖(x : H)‖)
        (fun s _ => (hK x s).hasDerivWithinAt) (fun s _ => hKbd x s)
        (Set.mem_univ (0 : ℝ)) (Set.mem_univ t)
      simpa using h
    -- the weak Lipschitz bound, first on the domain then everywhere
    have hconj : ∀ (t : ℝ) (x : H), ⟪x, G.U t phi - phi⟫_ℂ
        = (starRingEnd ℂ) (⟪phi, G.U (-t) x⟫_ℂ - ⟪phi, x⟫_ℂ) := by
      intro t x
      rw [map_sub, inner_conj_symm, inner_conj_symm, inner_sub_right]
      congr 1
      exact G.inner_adjoint t x phi
    have hb2 : ∀ (t : ℝ) (x : G.genDomain),
        ‖⟪(x : H), G.U t phi - phi⟫_ℂ‖ ≤ (|t| * ‖eta‖) * ‖(x : H)‖ := by
      intro t x
      rw [hconj t (x : H), RCLike.norm_conj]
      have := hMVT x (-t)
      rw [abs_neg] at this
      calc ‖⟪phi, G.U (-t) (x : H)⟫_ℂ - ⟪phi, (x : H)⟫_ℂ‖ ≤ (‖eta‖ * ‖(x : H)‖) * |t| := this
        _ = (|t| * ‖eta‖) * ‖(x : H)‖ := by ring
    have hb3 : ∀ (t : ℝ) (x : H),
        ‖⟪x, G.U t phi - phi⟫_ℂ‖ ≤ (|t| * ‖eta‖) * ‖x‖ := by
      intro t
      have hclosed : IsClosed
          {x : H | ‖⟪x, G.U t phi - phi⟫_ℂ‖ ≤ (|t| * ‖eta‖) * ‖x‖} :=
        isClosed_le ((continuous_id.inner continuous_const).norm)
          (continuous_const.mul continuous_norm)
      have hsub : ((G.genDomain : Submodule ℂ H) : Set H)
          ⊆ {x : H | ‖⟪x, G.U t phi - phi⟫_ℂ‖ ≤ (|t| * ‖eta‖) * ‖x‖} :=
        fun x hx => hb2 t ⟨x, hx⟩
      intro x
      have hall := hclosed.closure_subset_iff.mpr hsub
      rw [G.denseDomain.closure_eq] at hall
      exact hall (Set.mem_univ x)
    have hLip : ∀ t : ℝ, ‖G.U t phi - phi‖ ≤ |t| * ‖eta‖ := by
      intro t
      exact norm_le_of_inner_self_bound (by positivity) (hb3 t _)
    -- weak convergence of the difference quotients
    set w : H := (-Complex.I) • eta with hw
    have hweak : ∀ x ∈ ((G.genDomain : Submodule ℂ H) : Set H),
        Tendsto (fun t : ℝ => ⟪x, t⁻¹ • (G.U t phi - phi)⟫_ℂ) (𝓝[≠] (0 : ℝ))
          (𝓝 (⟪x, w⟫_ℂ)) := by
      intro x hx
      have hMd : HasDerivAt (fun u : ℝ => ⟪phi, G.U (-u) x⟫_ℂ)
          (Complex.I * ⟪eta, x⟫_ℂ) 0 := by
        have h0 := hK ⟨x, hx⟩ 0
        rw [G.apply_zero] at h0
        have h := HasDerivAt.scomp (0 : ℝ) (by simpa using h0) (hasDerivAt_neg (0 : ℝ))
        simp only [Function.comp_def] at h
        convert h using 1
        · rfl
        · norm_num
      have hslope := hasDerivAt_iff_tendsto_slope.mp hMd
      have hcj : Tendsto
          (fun t : ℝ => (starRingEnd ℂ) (slope (fun u : ℝ => ⟪phi, G.U (-u) x⟫_ℂ) 0 t))
          (𝓝[≠] (0 : ℝ)) (𝓝 ((starRingEnd ℂ) (Complex.I * ⟪eta, x⟫_ℂ))) :=
        (Complex.continuous_conj.tendsto _).comp hslope
      have hfun : ∀ t : ℝ, ⟪x, t⁻¹ • (G.U t phi - phi)⟫_ℂ
          = (starRingEnd ℂ) (slope (fun u : ℝ => ⟪phi, G.U (-u) x⟫_ℂ) 0 t) := by
        intro t
        simp only [slope, vsub_eq_sub, sub_zero, neg_zero, G.apply_zero]
        rw [← Complex.coe_smul, inner_smul_right, hconj t x, ← Complex.coe_smul,
          smul_eq_mul, map_mul, Complex.conj_ofReal]
      have hlim : (starRingEnd ℂ) (Complex.I * ⟪eta, x⟫_ℂ) = ⟪x, w⟫_ℂ := by
        rw [hw, inner_smul_right, map_mul, inner_conj_symm]
        simp
      rw [← hlim]
      exact hcj.congr (fun t => (hfun t).symm)
    have hbdd : ∀ᶠ t : ℝ in 𝓝[≠] (0 : ℝ), ‖t⁻¹ • (G.U t phi - phi)‖ ≤ ‖w‖ := by
      filter_upwards [self_mem_nhdsWithin] with t ht
      have ht0 : t ≠ 0 := ht
      have hwn : ‖w‖ = ‖eta‖ := by
        rw [hw, norm_smul, norm_neg, Complex.norm_I, one_mul]
      rw [norm_smul, Real.norm_eq_abs, abs_inv, hwn]
      have habs : (0 : ℝ) < |t| := abs_pos.mpr ht0
      calc |t|⁻¹ * ‖G.U t phi - phi‖ ≤ |t|⁻¹ * (|t| * ‖eta‖) :=
            mul_le_mul_of_nonneg_left (hLip t) (by positivity)
        _ = ‖eta‖ := by field_simp
    have hstrong := tendsto_of_weak_of_norm_le G.denseDomain hbdd hweak
    have hderiv : HasDerivAt (fun t : ℝ => G.U t phi) w 0 := by
      rw [hasDerivAt_iff_tendsto_slope]
      exact hstrong.congr (fun t => by simp [slope, G.apply_zero])
    exact hderiv.differentiableAt
  · intro phi hphi
    exact ⟨G.genOp ⟨phi, hphi⟩, fun psi => G.symmetric psi ⟨phi, hphi⟩⟩


/-- The self-adjoint generator of a weakly measurable unitary group on a separable
Hilbert space. -/
noncomputable def gen : BookProof.ChapterStoneResolvent.UnboundedSelfAdjoint H where
  domain := G.genDomain
  op := G.genOp
  denseDomain := G.denseDomain
  symmetric := G.symmetric
  selfAdjoint := G.selfAdjoint


/-! ## Uniqueness: the group is the Stone group of its generator -/









end WeakMeasurableUnitaryGroup

end BookProof.ChapterStoneMeasurable
