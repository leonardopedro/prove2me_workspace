import Mathlib

/-!
# The countable (type `I_∞`) case of the abelian von Neumann classification:
`ℓ∞(ℕ)` is a MASA of `B(ℓ²(ℕ))`

`BookProof/ChapterAbelianDiagonal.lean` proves the **finite** (type `Iₙ`) case of
von Neumann's classification of abelian von Neumann algebras: `ℓ∞({1,…,n})`,
realized as the diagonal subalgebra of `Mat(n, ℂ)`, is its own commutant.  This
file proves the next case of the list — the **countable** one, `ℓ∞(ℕ)` acting by
multiplication operators on `ℓ²(ℕ)`.

The full five-way classification (and its exhaustiveness) is a deep theorem and
is *not* claimed here; what is proved is the second isomorphism class as a
concrete MASA.

## Deliverables

* `Ell2C`, `EllInf` — the complex Hilbert space `ℓ²(ℕ)` and the algebra `ℓ∞(ℕ)`;
* `memℓp_diag_two` — a bounded sequence multiplies `ℓ²` into `ℓ²`;
* `diagOp d` — the **diagonal multiplication operator** of `d ∈ ℓ∞(ℕ)`, a bounded
  operator on `ℓ²(ℕ)` with `‖diagOp d‖ ≤ ‖d‖`;
* `diagOp_add`, `diagOp_smul`, `diagOp_mul`, `diagOp_one`, `diagOp_star` — `diagOp`
  is a unital `*`-algebra map;
* `diagOp_injective` — it is faithful, so `ℓ∞(ℕ)` really *is* an algebra of
  operators;
* `diagOp_comm` — the diagonal algebra is abelian;
* `commutes_diagOp_iff` — **maximal abelianness**: a bounded operator commutes
  with every diagonal operator iff it is itself diagonal;
* `vonNeumann_abelian_class_countable` — the headline packaging of the countable
  isomorphism class.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open scoped ENNReal

noncomputable section

namespace BookProof.ChapterAbelianDiagonalCountable

/-- The complex Hilbert space `ℓ²(ℕ)`. -/
abbrev Ell2C := lp (fun _ : ℕ => ℂ) 2

/-- The algebra `ℓ∞(ℕ)` of bounded complex sequences. -/
abbrev EllInf := lp (fun _ : ℕ => ℂ) ∞

theorem norm_coord_le (d : EllInf) (i : ℕ) : ‖(d : ℕ → ℂ) i‖ ≤ ‖d‖ :=
  lp.norm_apply_le_norm (by simp) d i

/-- Multiplying an `ℓ²` sequence by a bounded sequence stays in `ℓ²`, with the
expected bound on the partial sums. -/
theorem memℓp_diag_two (d : EllInf) (f : Ell2C) :
    Memℓp (fun i => (d : ℕ → ℂ) i * (f : ℕ → ℂ) i) 2 := by
  have hd0 : 0 ≤ ‖d‖ := norm_nonneg _
  have hp : (0:ℝ) < (2 : ℝ≥0∞).toReal := by norm_num
  refine memℓp_gen' (C := (‖d‖ * ‖f‖) ^ (2 : ℝ≥0∞).toReal) fun s => ?_
  have h1 : ∀ i ∈ s, ‖(d : ℕ → ℂ) i * (f : ℕ → ℂ) i‖ ^ (2 : ℝ≥0∞).toReal
      ≤ ‖d‖ ^ (2:ℝ≥0∞).toReal * ‖(f : ℕ → ℂ) i‖ ^ (2:ℝ≥0∞).toReal := by
    intro i _
    rw [norm_mul, Real.mul_rpow (norm_nonneg _) (norm_nonneg _)]
    gcongr
    exact norm_coord_le d i
  calc ∑ i ∈ s, ‖(d : ℕ → ℂ) i * (f : ℕ → ℂ) i‖ ^ (2 : ℝ≥0∞).toReal
      ≤ ∑ i ∈ s, ‖d‖ ^ (2:ℝ≥0∞).toReal * ‖(f : ℕ → ℂ) i‖ ^ (2:ℝ≥0∞).toReal :=
        Finset.sum_le_sum h1
    _ = ‖d‖ ^ (2:ℝ≥0∞).toReal * ∑ i ∈ s, ‖(f : ℕ → ℂ) i‖ ^ (2:ℝ≥0∞).toReal := by
        rw [Finset.mul_sum]
    _ ≤ ‖d‖ ^ (2:ℝ≥0∞).toReal * ‖f‖ ^ (2:ℝ≥0∞).toReal :=
        mul_le_mul_of_nonneg_left (lp.sum_rpow_le_norm_rpow hp f s)
          (Real.rpow_nonneg hd0 _)
    _ = (‖d‖ * ‖f‖) ^ (2:ℝ≥0∞).toReal := (Real.mul_rpow hd0 (norm_nonneg _)).symm

/-- The diagonal multiplication operator of `d ∈ ℓ∞(ℕ)`, as a linear map. -/
def diagLin (d : EllInf) : Ell2C →ₗ[ℂ] Ell2C where
  toFun f := ⟨fun i => (d : ℕ → ℂ) i * (f : ℕ → ℂ) i, memℓp_diag_two d f⟩
  map_add' f g := by
    apply lp.ext
    funext i
    simp [mul_add]
  map_smul' c f := by
    apply lp.ext
    funext i
    simp [mul_left_comm]

@[simp] theorem diagLin_apply (d : EllInf) (f : Ell2C) (i : ℕ) :
    ((diagLin d f : Ell2C) : ℕ → ℂ) i = (d : ℕ → ℂ) i * (f : ℕ → ℂ) i := rfl

theorem norm_diagLin_le (d : EllInf) (f : Ell2C) : ‖diagLin d f‖ ≤ ‖d‖ * ‖f‖ := by
  have hp : (0:ℝ) < (2 : ℝ≥0∞).toReal := by norm_num
  refine lp.norm_le_of_forall_sum_le hp (by positivity) fun s => ?_
  have h1 : ∀ i ∈ s, ‖((diagLin d f : Ell2C) : ℕ → ℂ) i‖ ^ (2 : ℝ≥0∞).toReal
      ≤ ‖d‖ ^ (2:ℝ≥0∞).toReal * ‖(f : ℕ → ℂ) i‖ ^ (2:ℝ≥0∞).toReal := by
    intro i _
    rw [diagLin_apply, norm_mul, Real.mul_rpow (norm_nonneg _) (norm_nonneg _)]
    gcongr
    exact norm_coord_le d i
  calc ∑ i ∈ s, ‖((diagLin d f : Ell2C) : ℕ → ℂ) i‖ ^ (2 : ℝ≥0∞).toReal
      ≤ ∑ i ∈ s, ‖d‖ ^ (2:ℝ≥0∞).toReal * ‖(f : ℕ → ℂ) i‖ ^ (2:ℝ≥0∞).toReal :=
        Finset.sum_le_sum h1
    _ = ‖d‖ ^ (2:ℝ≥0∞).toReal * ∑ i ∈ s, ‖(f : ℕ → ℂ) i‖ ^ (2:ℝ≥0∞).toReal := by
        rw [Finset.mul_sum]
    _ ≤ ‖d‖ ^ (2:ℝ≥0∞).toReal * ‖f‖ ^ (2:ℝ≥0∞).toReal :=
        mul_le_mul_of_nonneg_left (lp.sum_rpow_le_norm_rpow hp f s)
          (Real.rpow_nonneg (norm_nonneg _) _)
    _ = (‖d‖ * ‖f‖) ^ (2:ℝ≥0∞).toReal :=
        (Real.mul_rpow (norm_nonneg _) (norm_nonneg _)).symm

/-- **The diagonal multiplication operator** of a bounded sequence `d ∈ ℓ∞(ℕ)`:
a bounded operator on `ℓ²(ℕ)`, of norm at most `‖d‖`. -/
def diagOp (d : EllInf) : Ell2C →L[ℂ] Ell2C :=
  LinearMap.mkContinuous (diagLin d) ‖d‖ (fun f => norm_diagLin_le d f)

@[simp] theorem diagOp_apply (d : EllInf) (f : Ell2C) (i : ℕ) :
    ((diagOp d f : Ell2C) : ℕ → ℂ) i = (d : ℕ → ℂ) i * (f : ℕ → ℂ) i := rfl

theorem norm_diagOp_le (d : EllInf) : ‖diagOp d‖ ≤ ‖d‖ :=
  LinearMap.mkContinuous_norm_le _ (norm_nonneg _) _

/-! ## `diagOp` is a faithful unital `*`-algebra map -/

theorem diagOp_add (d e : EllInf) : diagOp (d + e) = diagOp d + diagOp e := by
  ext f i
  simp [add_mul]

theorem diagOp_smul (c : ℂ) (d : EllInf) : diagOp (c • d) = c • diagOp d := by
  ext f i
  simp [mul_assoc]

theorem diagOp_mul (d e : EllInf) : diagOp (d * e) = (diagOp d).comp (diagOp e) := by
  ext f i
  simp [mul_assoc]

theorem diagOp_one : diagOp (1 : EllInf) = ContinuousLinearMap.id ℂ Ell2C := by
  ext f i
  simp

/-- The adjoint identity: multiplication by `star d` is the adjoint of
multiplication by `d`. -/
theorem diagOp_star (d : EllInf) (f g : Ell2C) :
    (inner ℂ (diagOp d f) g : ℂ) = inner ℂ f (diagOp (star d) g) := by
  rw [lp.inner_eq_tsum, lp.inner_eq_tsum]
  refine tsum_congr fun i => ?_
  simp [RCLike.inner_apply, map_mul, mul_comm, mul_left_comm]

/-- `diagOp` is **faithful**: distinct bounded sequences give distinct operators.
-/
theorem diagOp_injective : Function.Injective diagOp := by
  intro d e h
  apply lp.ext
  funext i
  have := congrArg (fun T => ((T (lp.single 2 i (1 : ℂ)) : Ell2C) : ℕ → ℂ) i) h
  simpa using this

/-- **The diagonal algebra is abelian.** -/
theorem diagOp_comm (d e : EllInf) :
    (diagOp d).comp (diagOp e) = (diagOp e).comp (diagOp d) := by
  ext f i
  simp [mul_left_comm]

/-! ## Maximal abelianness: the commutant of the diagonal algebra -/

/-- The coordinate atom `eᵢ ∈ ℓ²(ℕ)`. -/
def atom (i : ℕ) : Ell2C := lp.single 2 i (1 : ℂ)

@[simp] theorem norm_atom (i : ℕ) : ‖atom i‖ = 1 := by
  rw [atom, lp.norm_single (by norm_num)]
  simp

/-- The coordinate projection, as a diagonal operator. -/
def coordUnit (i : ℕ) : EllInf := lp.single ∞ i (1 : ℂ)

theorem diagOp_coordUnit_apply (i : ℕ) (f : Ell2C) (j : ℕ) :
    ((diagOp (coordUnit i) f : Ell2C) : ℕ → ℂ) j = if j = i then (f : ℕ → ℂ) i else 0 := by
  rw [diagOp_apply]
  by_cases h : j = i
  · subst h; simp [coordUnit, lp.single_apply]
  · simp [coordUnit, lp.single_apply, h]

/-- Multiplying by the coordinate unit picks out a single atom. -/
theorem diagOp_coordUnit_eq (i : ℕ) (f : Ell2C) :
    diagOp (coordUnit i) f = (f : ℕ → ℂ) i • atom i := by
  apply lp.ext
  funext j
  rw [diagOp_coordUnit_apply]
  by_cases h : j = i
  · subst h; simp [atom, lp.single_apply]
  · simp [atom, lp.single_apply, h]

/-- **Maximal abelianness of `ℓ∞(ℕ)` in `B(ℓ²(ℕ))`.**  A bounded operator on
`ℓ²(ℕ)` commutes with every diagonal multiplication operator **iff** it is itself
one.  The diagonal algebra is therefore its own commutant: a maximal abelian
self-adjoint subalgebra of `B(ℓ²(ℕ))`. -/
theorem commutes_diagOp_iff (T : Ell2C →L[ℂ] Ell2C) :
    (∀ d : EllInf, T.comp (diagOp d) = (diagOp d).comp T) ↔ ∃ d : EllInf, T = diagOp d := by
  constructor
  · intro hT
    -- the diagonal entries
    set c : ℕ → ℂ := fun i => ((T (atom i) : Ell2C) : ℕ → ℂ) i with hc
    have hbdd : ∀ i, ‖c i‖ ≤ ‖T‖ := by
      intro i
      calc ‖c i‖ ≤ ‖T (atom i)‖ := lp.norm_apply_le_norm (by simp) _ i
        _ ≤ ‖T‖ * ‖atom i‖ := T.le_opNorm _
        _ = ‖T‖ := by rw [norm_atom, mul_one]
    have hmem : Memℓp c ∞ := by
      refine memℓp_infty ⟨‖T‖, ?_⟩
      rintro x ⟨i, rfl⟩
      exact hbdd i
    refine ⟨⟨c, hmem⟩, ?_⟩
    ext f i
    -- restrict to the `i`-th coordinate using the projection `coordUnit i`
    have hcomm := congrArg (fun S => ((S f : Ell2C) : ℕ → ℂ) i) (hT (coordUnit i))
    simp only [ContinuousLinearMap.coe_comp', Function.comp_apply] at hcomm
    have hleft : T (diagOp (coordUnit i) f) = (f : ℕ → ℂ) i • T (atom i) := by
      rw [diagOp_coordUnit_eq, map_smul]
    rw [hleft] at hcomm
    have hright : ((diagOp (coordUnit i) (T f) : Ell2C) : ℕ → ℂ) i
        = ((T f : Ell2C) : ℕ → ℂ) i := by
      rw [diagOp_coordUnit_apply]; simp
    rw [hright] at hcomm
    have hval : ((f : ℕ → ℂ) i • T (atom i) : Ell2C) i = (f : ℕ → ℂ) i * c i := rfl
    rw [hval] at hcomm
    rw [← hcomm, diagOp_apply]
    simp [mul_comm]
  · rintro ⟨d, rfl⟩
    exact fun e => diagOp_comm d e

/-- **Headline: the countable (type `I_∞`) case of the abelian von Neumann
classification.**  On the separable Hilbert space `ℓ²(ℕ)` the algebra `ℓ∞(ℕ)` is
realized, faithfully and as a unital `*`-algebra, by diagonal multiplication
operators; the image is abelian and is exactly its own commutant, i.e. a maximal
abelian self-adjoint subalgebra of `B(ℓ²(ℕ))`.

This is the second of von Neumann's five isomorphism classes (the first being the
finite case of `BookProof.AbelianDiagonal`); the remaining classes and the
exhaustiveness of the list are not claimed. -/
theorem vonNeumann_abelian_class_countable :
    Function.Injective diagOp ∧
      (∀ d e : EllInf, (diagOp d).comp (diagOp e) = (diagOp e).comp (diagOp d)) ∧
      (∀ T : Ell2C →L[ℂ] Ell2C,
        (∀ d : EllInf, T.comp (diagOp d) = (diagOp d).comp T) ↔ ∃ d : EllInf, T = diagOp d) :=
  ⟨diagOp_injective, diagOp_comm, commutes_diagOp_iff⟩

end BookProof.ChapterAbelianDiagonalCountable

end
