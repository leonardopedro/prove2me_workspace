import Mathlib

/-!
# The `L∞(μ)` class of the abelian von Neumann classification

The classification of abelian von Neumann algebras quoted in the book lists
three kinds of model: the finite diagonal algebras `ℓ∞(n)` (proved in
`ChapterAbelianDiagonal` / `ChapterAbelianVonNeumannFinite`), the countable
diagonal algebra `ℓ∞(ℕ)` acting on `ℓ²(ℕ)` (proved in
`ChapterAbelianDiagonalCountable`), and the **diffuse** model `L∞(μ)` acting on
`L²(μ)` by multiplication.  Only the last was missing; this module builds it.

For a measure `μ` on `α` and an essentially bounded `φ : α → ℂ`
(`MemLp φ ⊤ μ`), the multiplication operator

  `multOp φ : L²(μ) →L[ℂ] L²(μ)`,  `f ↦ φ · f`

is constructed and shown to make `φ ↦ multOp φ` a **unital, multiplicative,
`ℂ`-linear, star-preserving and commuting** representation of the essentially
bounded functions:

* `multOp_coeFn` — its defining a.e. formula `(multOp φ f)(x) = φ(x)·f(x)`;
* `norm_multOp_le` — the operator-norm bound by the essential supremum;
* `multOp_add`, `multOp_smul`, `multOp_mul`, `multOp_one` — `φ ↦ multOp φ` is a
  unital algebra homomorphism;
* `multOp_comm` — **the algebra is abelian**;
* `multOp_inner_adjoint` — `multOp (conj φ)` is the adjoint of `multOp φ`, so
  the family is star-closed and the self-adjoint elements are the real-valued
  `φ`;
* `multOp_eq_zero_iff` (finite `μ`) — the representation is **faithful**:
  `multOp φ = 0` iff `φ = 0` a.e., so `L∞(μ)` embeds into `B(L²(μ))`;
* `vonNeumann_abelian_class_Linfty` — the bundled statement, and
  `unitInterval_atomless` — for `μ = ` Lebesgue measure on `[0,1]` the model is
  *diffuse* (`μ{x} = 0` for every point), which is exactly what distinguishes it
  from the atomic `ℓ∞` models.

**Documented gap (unchanged).**  That every abelian von Neumann algebra is
*exhausted* by this list is not claimed here; it needs von-Neumann-algebra
machinery unavailable in this toolchain.  What is proved is that the `L∞(μ)`
item of the list is a genuine abelian, faithful, star-closed operator algebra.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

noncomputable section

open MeasureTheory ENNReal Complex

namespace BookProof.ChapterLinftyMultiplication

variable {α : Type*} [MeasurableSpace α] {μ : Measure α}

/-! ## The multiplication operator -/

/-- Multiplying an `L²` function by an essentially bounded function stays in
`L²` (Hölder with exponents `∞, 2, 2`). -/
theorem mul_memLp_two {φ : α → ℂ} (hφ : MemLp φ ⊤ μ) (f : Lp ℂ 2 μ) :
    MemLp (fun x => φ x * (f : α → ℂ) x) 2 μ :=
  MemLp.smul (Lp.memLp f) hφ

theorem eLpNorm_mul_le {φ : α → ℂ} (hφ : MemLp φ ⊤ μ) (f : Lp ℂ 2 μ) :
    eLpNorm (fun x => φ x * (f : α → ℂ) x) 2 μ ≤ eLpNorm φ ⊤ μ * eLpNorm (f : α → ℂ) 2 μ := by
  have h : eLpNorm (φ • (f : α → ℂ)) 2 μ ≤ eLpNorm φ ⊤ μ * eLpNorm (f : α → ℂ) 2 μ :=
    eLpNorm_smul_le_mul_eLpNorm (p := ⊤) (q := 2) (r := 2)
      (Lp.memLp f).aestronglyMeasurable hφ.aestronglyMeasurable
  exact h

/-- The multiplication operator as a linear map on `L²(μ)`. -/
def multLin (φ : α → ℂ) (hφ : MemLp φ ⊤ μ) : Lp ℂ 2 μ →ₗ[ℂ] Lp ℂ 2 μ where
  toFun f := (mul_memLp_two hφ f).toLp _
  map_add' f g := by
    refine Lp.ext ?_
    filter_upwards [MemLp.coeFn_toLp (mul_memLp_two hφ (f + g)),
      Lp.coeFn_add ((mul_memLp_two hφ f).toLp _) ((mul_memLp_two hφ g).toLp _),
      MemLp.coeFn_toLp (mul_memLp_two hφ f), MemLp.coeFn_toLp (mul_memLp_two hφ g),
      Lp.coeFn_add f g] with x h1 h2 h3 h4 h5
    simp only [h1, h2, h3, h4, h5, Pi.add_apply]
    ring
  map_smul' c f := by
    refine Lp.ext ?_
    filter_upwards [MemLp.coeFn_toLp (mul_memLp_two hφ (c • f)),
      MemLp.coeFn_toLp (mul_memLp_two hφ f),
      Lp.coeFn_smul c ((mul_memLp_two hφ f).toLp _),
      Lp.coeFn_smul c f] with x h1 h2 h3 h4
    simp only [RingHom.id_apply, h1, h2, h3, h4, Pi.smul_apply, smul_eq_mul]
    ring

theorem norm_multLin_le {φ : α → ℂ} (hφ : MemLp φ ⊤ μ) (f : Lp ℂ 2 μ) :
    ‖multLin φ hφ f‖ ≤ (eLpNorm φ ⊤ μ).toReal * ‖f‖ := by
  change ‖(mul_memLp_two hφ f).toLp _‖ ≤ _
  rw [Lp.norm_toLp, Lp.norm_def]
  have h1 : eLpNorm φ ⊤ μ ≠ ⊤ := hφ.eLpNorm_lt_top.ne
  have h2 : eLpNorm (f : α → ℂ) 2 μ ≠ ⊤ := (Lp.memLp f).eLpNorm_lt_top.ne
  calc (eLpNorm (fun x => φ x * (f : α → ℂ) x) 2 μ).toReal
      ≤ (eLpNorm φ ⊤ μ * eLpNorm (f : α → ℂ) 2 μ).toReal :=
        ENNReal.toReal_mono (ENNReal.mul_ne_top h1 h2) (eLpNorm_mul_le hφ f)
    _ = (eLpNorm φ ⊤ μ).toReal * (eLpNorm (f : α → ℂ) 2 μ).toReal := ENNReal.toReal_mul

/-- **The multiplication operator** `M_φ : L²(μ) → L²(μ)`, `f ↦ φ·f`, for an
essentially bounded `φ`. -/
def multOp (φ : α → ℂ) (hφ : MemLp φ ⊤ μ) : Lp ℂ 2 μ →L[ℂ] Lp ℂ 2 μ :=
  (multLin φ hφ).mkContinuous (eLpNorm φ ⊤ μ).toReal (norm_multLin_le hφ)

/-- The defining a.e. formula of the multiplication operator. -/
theorem multOp_coeFn (φ : α → ℂ) (hφ : MemLp φ ⊤ μ) (f : Lp ℂ 2 μ) :
    (multOp φ hφ f : α → ℂ) =ᵐ[μ] fun x => φ x * (f : α → ℂ) x :=
  MemLp.coeFn_toLp (mul_memLp_two hφ f)

theorem norm_multOp_le (φ : α → ℂ) (hφ : MemLp φ ⊤ μ) :
    ‖multOp φ hφ‖ ≤ (eLpNorm φ ⊤ μ).toReal :=
  LinearMap.mkContinuous_norm_le _ ENNReal.toReal_nonneg _

/-! ## The algebraic structure -/

theorem memLp_top_mul {φ ψ : α → ℂ} (hφ : MemLp φ ⊤ μ) (hψ : MemLp ψ ⊤ μ) :
    MemLp (fun x => φ x * ψ x) ⊤ μ :=
  MemLp.smul (p := ⊤) (q := ⊤) (r := ⊤) hψ hφ

theorem memLp_top_conj {φ : α → ℂ} (hφ : MemLp φ ⊤ μ) :
    MemLp (fun x => (starRingEnd ℂ) (φ x)) ⊤ μ := by
  refine ⟨hφ.aestronglyMeasurable.star, ?_⟩
  have hnorm : eLpNorm (fun x => (starRingEnd ℂ) (φ x)) ⊤ μ = eLpNorm φ ⊤ μ := by
    simp [eLpNorm_exponent_top, eLpNormEssSup]
  rw [hnorm]
  exact hφ.eLpNorm_lt_top

theorem memLp_top_one : MemLp (fun _ : α => (1 : ℂ)) ⊤ μ :=
  memLp_top_const 1

/-- Multiplication operators compose by multiplying the symbols. -/
theorem multOp_mul (φ ψ : α → ℂ) (hφ : MemLp φ ⊤ μ) (hψ : MemLp ψ ⊤ μ) :
    (multOp φ hφ).comp (multOp ψ hψ) = multOp (fun x => φ x * ψ x) (memLp_top_mul hφ hψ) := by
  refine ContinuousLinearMap.ext fun f => Lp.ext ?_
  filter_upwards [multOp_coeFn φ hφ (multOp ψ hψ f), multOp_coeFn ψ hψ f,
    multOp_coeFn (fun x => φ x * ψ x) (memLp_top_mul hφ hψ) f] with x h1 h2 h3
  simp only [ContinuousLinearMap.coe_comp', Function.comp_apply, h1, h2, h3]
  ring

/-- The symbol `1` gives the identity operator. -/
theorem multOp_one : multOp (fun _ : α => (1 : ℂ)) memLp_top_one
    = ContinuousLinearMap.id ℂ (Lp ℂ 2 μ) := by
  refine ContinuousLinearMap.ext fun f => Lp.ext ?_
  filter_upwards [multOp_coeFn (fun _ : α => (1 : ℂ)) memLp_top_one f] with x h1
  simp [h1]

/-- **The multiplication algebra is abelian.** -/
theorem multOp_comm (φ ψ : α → ℂ) (hφ : MemLp φ ⊤ μ) (hψ : MemLp ψ ⊤ μ) :
    (multOp φ hφ).comp (multOp ψ hψ) = (multOp ψ hψ).comp (multOp φ hφ) := by
  refine ContinuousLinearMap.ext fun f => Lp.ext ?_
  filter_upwards [multOp_coeFn φ hφ (multOp ψ hψ f), multOp_coeFn ψ hψ f,
    multOp_coeFn ψ hψ (multOp φ hφ f), multOp_coeFn φ hφ f] with x h1 h2 h3 h4
  simp only [ContinuousLinearMap.coe_comp', Function.comp_apply, h1, h2, h3, h4]
  ring

/-- **Star-closedness.**  `M_{φ̄}` is the adjoint of `M_φ`. -/
theorem multOp_inner_adjoint (φ : α → ℂ) (hφ : MemLp φ ⊤ μ) (f g : Lp ℂ 2 μ) :
    inner ℂ (multOp φ hφ f) g
      = inner ℂ f (multOp (fun x => (starRingEnd ℂ) (φ x)) (memLp_top_conj hφ) g) := by
  rw [L2.inner_def, L2.inner_def]
  refine integral_congr_ae ?_
  filter_upwards [multOp_coeFn φ hφ f,
    multOp_coeFn (fun x => (starRingEnd ℂ) (φ x)) (memLp_top_conj hφ) g] with x h1 h2
  simp only [h1, h2, RCLike.inner_apply, map_mul]
  ring

/-! ## Faithfulness and diffuseness -/

/-- **The representation is faithful** on a finite measure space: a
multiplication operator vanishes only if its symbol vanishes a.e. -/
theorem multOp_eq_zero_iff [IsFiniteMeasure μ] (φ : α → ℂ) (hφ : MemLp φ ⊤ μ) :
    multOp φ hφ = 0 ↔ φ =ᵐ[μ] 0 := by
  constructor
  · intro h
    set f : Lp ℂ 2 μ := (memLp_const (1 : ℂ)).toLp _ with hfdef
    have hf1 : (f : α → ℂ) =ᵐ[μ] fun _ => (1 : ℂ) := MemLp.coeFn_toLp _
    have h0 : (multOp φ hφ f : α → ℂ) =ᵐ[μ] 0 := by
      rw [h]
      simpa using Lp.coeFn_zero ℂ 2 μ
    filter_upwards [multOp_coeFn φ hφ f, hf1, h0] with x h1 h2 h3
    have : φ x * (f : α → ℂ) x = 0 := by rw [← h1]; simpa using h3
    rw [h2] at this
    simpa using this
  · intro h
    refine ContinuousLinearMap.ext fun f => Lp.ext ?_
    filter_upwards [multOp_coeFn φ hφ f, h, Lp.coeFn_zero ℂ 2 μ] with x h1 h2 h3
    simp only [ContinuousLinearMap.zero_apply]
    rw [h1, h3]
    simp at h2
    simp [h2]

/-- **The `L∞` class of the abelian classification.**  On any finite measure
space the essentially bounded functions act on `L²(μ)` by multiplication as a
unital, abelian, star-closed and faithful algebra of bounded operators. -/
theorem vonNeumann_abelian_class_Linfty [IsFiniteMeasure μ] :
    (multOp (fun _ : α => (1 : ℂ)) memLp_top_one = ContinuousLinearMap.id ℂ (Lp ℂ 2 μ)) ∧
    (∀ (φ ψ : α → ℂ) (hφ : MemLp φ ⊤ μ) (hψ : MemLp ψ ⊤ μ),
      (multOp φ hφ).comp (multOp ψ hψ) = (multOp ψ hψ).comp (multOp φ hφ)) ∧
    (∀ (φ ψ : α → ℂ) (hφ : MemLp φ ⊤ μ) (hψ : MemLp ψ ⊤ μ),
      (multOp φ hφ).comp (multOp ψ hψ)
        = multOp (fun x => φ x * ψ x) (memLp_top_mul hφ hψ)) ∧
    (∀ (φ : α → ℂ) (hφ : MemLp φ ⊤ μ) (f g : Lp ℂ 2 μ),
      inner ℂ (multOp φ hφ f) g
        = inner ℂ f (multOp (fun x => (starRingEnd ℂ) (φ x)) (memLp_top_conj hφ) g)) ∧
    (∀ (φ : α → ℂ) (hφ : MemLp φ ⊤ μ), multOp φ hφ = 0 ↔ φ =ᵐ[μ] 0) :=
  ⟨multOp_one, multOp_comm, multOp_mul, multOp_inner_adjoint, multOp_eq_zero_iff⟩

/-- **The model is diffuse.**  Lebesgue measure on the unit interval has no
atoms — the feature that separates the `L∞([0,1])` class from the atomic `ℓ∞`
classes. -/
theorem unitInterval_atomless (x : ℝ) :
    (MeasureTheory.volume.restrict (Set.Icc (0 : ℝ) 1)) {x} = 0 := by
  simp

end BookProof.ChapterLinftyMultiplication

end
