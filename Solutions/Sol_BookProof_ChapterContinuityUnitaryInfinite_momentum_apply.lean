-- Generated from ChapterContinuityUnitaryInfinite.lean — solution of BookProof.ChapterContinuityUnitaryInfinite.momentum_apply
import Mathlib
import Definitions.Def_ChapterContinuityUnitaryInfinite
open BookProof.ChapterContinuityUnitaryInfinite



open scoped ENNReal InnerProductSpace

set_option maxHeartbeats 1000000 in
1 - shiftOp (-1))

theorem solution (f : L2Z) (k : ℤ) :
    ((momentum f : L2Z) : ℤ → ℂ) k
      = (-Complex.I / 2) * ((f : ℤ → ℂ) (k + 1) - (f : ℤ → ℂ) (k - 1)) :=
  import Mathlib
  
  /-!
  # The dynamics-based unitary on the infinite lattice `ℓ²(ℤ)`
  
  Source: the manuscript's field-theoretic thread (`QFM.tex`) and the
  `ConditionalUnitary` chapter's *"A Less Arbitrary Construction"* section
  (`Book/ConditionalUnitary.lean`); proof plan appendix §E
  (`Book/ProofPlans.lean`).
  
  `BookProof.ChapterContinuityUnitary` builds the dynamics-based unitary on the
  *finite* cyclic lattice `ZMod N`, where every operator is a matrix and the
  exponential is a matrix exponential.  Its docstring records the
  infinite-dimensional analytic realization as the book's standing open layer.
  This module closes that layer in the **bounded** case: the same construction is
  carried out on the genuine infinite-dimensional Hilbert space
  `ℓ²(ℤ) = lp (fun _ : ℤ => ℂ) 2`, with
  
  * the lattice translations `(S_m f) k = f (k + m)` as *unitaries*
    (`shiftEquiv`), rather than permutation matrices;
  * the symmetric-difference momentum `p = -(i/2)(S₁ - S₋₁)` as a **bounded
    self-adjoint operator** (`momentum_isSelfAdjoint`);
  * a bounded velocity field `v ∈ ℓ^∞(ℤ)` acting as a bounded self-adjoint
    multiplication operator (`velocityOp_isSelfAdjoint`);
  * the Weyl-symmetrized generator `H = ½ (p·v + v·p)`, again bounded and
    self-adjoint (`continuityHamiltonian_isSelfAdjoint`);
  * the one-parameter unitary group `U t = exp (i t H)`
    (`continuityUnitary_unitary`, `continuityUnitary_zero`,
    `continuityUnitary_add`), built with the Banach-algebra exponential of
    `ℓ²(ℤ) →L[ℂ] ℓ²(ℤ)`;
  * the Born recovery `P(B) = ∑_{z ∈ B} |Ψ_t z|²`, now a **countably** additive
    probability law: `bornRecover_tsum_univ` gives total mass `1` and `bornPMF`
    packages it as a `PMF ℤ`, with the capstone `condProb_of_continuity_infinite`.
  
  The only structural change from the finite chapter is that self-adjointness is
  proved through the inner product (`ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric`)
  instead of through conjugate transposition of matrices, and that the total mass
  is a `tsum` instead of a finite sum.  Unboundedness (the position/momentum
  operators of the continuum) remains outside the statement: everything here is a
  bounded operator on `ℓ²(ℤ)`.
  
  Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
  `Quot.sound`).
  -/
  
  open scoped ENNReal InnerProductSpace
  
  namespace BookProof.ChapterContinuityUnitaryInfinite
  
  /-! ## The lattice Hilbert space and the `ℓ^∞` velocity fields -/
  
  /-- The infinite lattice Hilbert space `ℓ²(ℤ)`. -/
  noncomputable abbrev L2Z := lp (fun _ : ℤ => ℂ) 2
  
  /-- Bounded velocity fields on the lattice: `ℓ^∞(ℤ)`. -/
  abbrev LinfZ := lp (fun _ : ℤ => ℝ) ∞
  
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
    map_add' f g := by
      ext k
      rfl
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
      lp.coeFn_smul, lp.coeFn_sub, Pi.smul_apply, Pi.sub_apply, smul_eq_mul, shif
