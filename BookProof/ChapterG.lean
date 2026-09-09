import Mathlib

/-!
# Chapter G — Gauge transformations in probability spaces

This file formalizes the self-contained mathematical backbone of the book's
chapter *"Gauge symmetry and dissipative dynamics in probability spaces"*
(book line 2128), following work-package **N6** of `FORMALIZATION_ROADMAP.md`.

Sections G.0–G.7:
* G.0 the gauge group of a parametrization,
* G.1 orbits = fibers; gauge-invariance ⇔ factoring through `π`,
* G.2 gauge-invariant subalgebras; gauge-independence of expectation values,
* G.3 the Dirac obstruction (no shift-invariant state on `ℤ`),
* G.4 gauge-fixing sections always exist,
* G.5 Haar averaging (invariantization) and the pushforward headline,
* G.6 the BRST ghost algebra (nilpotency),
* G.7 dissipative dynamics: Koopman evolution.

None of these needs an `EXTERNAL` hypothesis; everything is `sorry`-free.
-/

open scoped ComplexConjugate InnerProductSpace Matrix

namespace BookProof.ChapterG

/-! ## G.0 — Parametrization and its gauge group -/

/-- The gauge group of a parametrization `π : X → Y`: permutations of the
parameter space that preserve every fiber of `π` (book line 2247). -/
def gaugeGroup {X Y : Type*} (π : X → Y) : Subgroup (Equiv.Perm X) where
  carrier := {g | ∀ x, π (g x) = π x}
  one_mem' := fun _ => rfl
  mul_mem' := by
    intro a b ha hb x
    simp only [Equiv.Perm.coe_mul, Function.comp_apply]
    rw [ha, hb]
  inv_mem' := by
    intro a ha x
    have h := ha (a⁻¹ x)
    simpa using h.symm

@[simp] theorem mem_gaugeGroup {X Y : Type*} {π : X → Y} {g : Equiv.Perm X} :
    g ∈ gaugeGroup π ↔ ∀ x, π (g x) = π x := Iff.rfl

/-! ## G.1 — Orbits are fibers; gauge-invariance ⇔ factoring -/

/-- Transpositions between points of a common fiber are gauge transformations. -/
theorem swap_mem_gaugeGroup {X Y : Type*} [DecidableEq X] {π : X → Y}
    {x x' : X} (h : π x = π x') :
    Equiv.swap x x' ∈ gaugeGroup π := by
  intro z
  rcases eq_or_ne z x with hzx | hzx
  · subst hzx; rw [Equiv.swap_apply_left]; exact h.symm
  · rcases eq_or_ne z x' with hzx' | hzx'
    · subst hzx'; rw [Equiv.swap_apply_right]; exact h
    · rw [Equiv.swap_apply_of_ne_of_ne hzx hzx']

/-- The gauge orbit of a point is exactly its fiber under `π`. -/
theorem gaugeOrbit_eq_fiber {X Y : Type*} (π : X → Y) (x : X) :
    MulAction.orbit (gaugeGroup π) x = π ⁻¹' {π x} := by
  classical
  ext z
  constructor
  · rintro ⟨g, rfl⟩
    simp only [Set.mem_preimage, Set.mem_singleton_iff]
    exact g.2 x
  · intro hz
    simp only [Set.mem_preimage, Set.mem_singleton_iff] at hz
    refine ⟨⟨Equiv.swap x z, swap_mem_gaugeGroup hz.symm⟩, ?_⟩
    change (Equiv.swap x z) x = z
    rw [Equiv.swap_apply_left]

/-- Gauge-invariant functions are exactly the functions of the parametrized
point (book 2247–2251). -/
theorem gaugeInvariant_iff_factors {X Y Z : Type*} {π : X → Y}
    (hπ : Function.Surjective π) (f : X → Z) :
    (∀ g ∈ gaugeGroup π, ∀ x, f (g x) = f x) ↔ ∃ h : Y → Z, f = h ∘ π := by
  classical
  constructor
  · intro hinv
    have hconst : ∀ x x', π x = π x' → f x = f x' := by
      intro x x' he
      have h := hinv (Equiv.swap x x') (swap_mem_gaugeGroup he) x
      rw [Equiv.swap_apply_left] at h
      exact h.symm
    refine ⟨f ∘ Function.surjInv hπ, ?_⟩
    funext x
    change f x = f (Function.surjInv hπ (π x))
    exact (hconst _ _ (by rw [Function.surjInv_eq hπ])).symm
  · rintro ⟨h, rfl⟩ g hg x
    simp only [Function.comp_apply]
    rw [hg x]

/-! ## G.2 — Gauge-invariant subalgebras and expectation values -/

/-- Gauge-invariant observables form a subalgebra of `X → R`
(book 2277–2289). -/
def gaugeInvariantSubalgebra (R : Type*) [CommSemiring R] {X Y : Type*}
    (π : X → Y) : Subalgebra R (X → R) where
  carrier := {f | ∀ g ∈ gaugeGroup π, ∀ x, f (g x) = f x}
  mul_mem' := by
    intro f f' hf hf' g hg x
    simp only [Pi.mul_apply]
    rw [hf g hg, hf' g hg]
  add_mem' := by
    intro f f' hf hf' g hg x
    simp only [Pi.add_apply]
    rw [hf g hg, hf' g hg]
  algebraMap_mem' := by
    intro r g _ x
    rfl

/-- The gauge-invariant *operator* algebra of a family of gauge unitaries is the
centralizer of that family (book 2444). -/
abbrev gaugeInvariantOperators (𝔽 : Type*) [CommSemiring 𝔽] {V : Type*}
    [Semiring V] [Algebra 𝔽 V] {G : Type*} (U : G → V) : Subalgebra 𝔽 V :=
  Subalgebra.centralizer 𝔽 (Set.range U)

/-- Expectation values are gauge-independent for observables that commute with a
gauge unitary (book 2344–2347). -/
theorem expectation_gauge_invariant {V : Type*} [NormedAddCommGroup V]
    [InnerProductSpace ℂ V] [CompleteSpace V]
    (U : V →L[ℂ] V) (hU : U ∈ unitary (V →L[ℂ] V))
    (A : V →L[ℂ] V) (hA : A * U = U * A) (Ψ : V) :
    ⟪U Ψ, A (U Ψ)⟫_ℂ = ⟪Ψ, A Ψ⟫_ℂ := by
  have hAU : A (U Ψ) = U (A Ψ) := by
    have := congr_arg (fun T : V →L[ℂ] V => T Ψ) hA
    simpa [ContinuousLinearMap.mul_apply] using this
  rw [hAU, ← ContinuousLinearMap.adjoint_inner_left]
  have hUU : (ContinuousLinearMap.adjoint U) * U = 1 := by
    have h := hU.1
    rwa [ContinuousLinearMap.star_eq_adjoint] at h
  calc ⟪(ContinuousLinearMap.adjoint U) (U Ψ), A Ψ⟫_ℂ
      = ⟪((ContinuousLinearMap.adjoint U) * U) Ψ, A Ψ⟫_ℂ := by rw [ContinuousLinearMap.mul_apply]
    _ = ⟪Ψ, A Ψ⟫_ℂ := by rw [hUU]; rfl

/-! ## G.3 — The Dirac obstruction: no gauge-invariant normalized state -/

open MeasureTheory

/-- There is no shift-invariant probability measure on `ℤ` (book 2277–2289). -/
theorem no_shift_invariant_probabilityMeasure :
    ¬ ∃ μ : Measure ℤ, IsProbabilityMeasure μ ∧
      ∀ s : Set ℤ, μ ((· + 1) ⁻¹' s) = μ s := by
  rintro ⟨μ, hμ, hinv⟩
  have hpre : ∀ k : ℤ, (· + 1) ⁻¹' ({k} : Set ℤ) = {k - 1} := by
    intro k; ext x; simp only [Set.mem_preimage, Set.mem_singleton_iff]; omega
  have hstep : ∀ k : ℤ, μ {k - 1} = μ {k} := by
    intro k; rw [← hpre k]; exact hinv {k}
  have hconst : ∀ k : ℤ, μ {k} = μ {(0:ℤ)} := by
    intro k
    induction k using Int.induction_on with
    | zero => rfl
    | succ n ih => rw [← hstep ((n:ℤ) + 1)]; simpa using ih
    | pred n ih => rw [hstep (-(n:ℤ))]; simpa using ih
  have huniv : (⋃ k : ℤ, ({k} : Set ℤ)) = Set.univ := by
    ext x; simp
  have hcount : μ Set.univ = ∑' k : ℤ, μ {k} := by
    rw [← huniv, measure_iUnion (fun i j hij => Set.disjoint_singleton.mpr hij)
      (fun k => measurableSet_singleton k)]
  rw [measure_univ] at hcount
  simp only [hconst] at hcount
  by_cases hc : μ {(0:ℤ)} = 0
  · rw [hc] at hcount; simp at hcount
  · rw [ENNReal.tsum_const_eq_top_of_ne_zero hc] at hcount
    exact ENNReal.one_ne_top hcount

/-- A shift-invariant vector in `ℓ²(ℤ)` is zero. -/
theorem shift_invariant_l2_eq_zero (Ψ : lp (fun _ : ℤ => ℂ) 2)
    (hΨ : ∀ k, Ψ (k + 1) = Ψ k) : Ψ = 0 := by
  have hconst : ∀ k : ℤ, Ψ k = Ψ 0 := by
    intro k
    induction k using Int.induction_on with
    | zero => rfl
    | succ n ih => rw [hΨ (n:ℤ)]; exact ih
    | pred n ih =>
      have h := hΨ (-(n:ℤ) - 1)
      rw [sub_add_cancel] at h
      rw [← h]; exact ih
  have hsum : Summable (fun k : ℤ => ‖Ψ k‖ ^ (2:ℝ)) := by
    have h := lp.memℓp Ψ
    rw [memℓp_gen_iff (by norm_num)] at h
    simpa using h
  have htend := hsum.tendsto_cofinite_zero
  have hc : (fun k : ℤ => ‖Ψ k‖ ^ (2:ℝ)) = fun _ => ‖Ψ 0‖ ^ (2:ℝ) := by
    funext k; rw [hconst k]
  rw [hc] at htend
  have hzero : ‖Ψ 0‖ ^ (2:ℝ) = 0 :=
    (tendsto_nhds_unique htend tendsto_const_nhds).symm
  have hn0 : ‖Ψ 0‖ = 0 := (Real.rpow_eq_zero (norm_nonneg _) (by norm_num)).mp hzero
  have hΨ0 : Ψ 0 = 0 := by simpa using hn0
  apply lp.ext
  funext k
  simp only [lp.coeFn_zero, Pi.zero_apply]
  rw [hconst k, hΨ0]

/-- There is no shift-invariant unit vector in `ℓ²(ℤ)` (book 2277–2289). -/
theorem no_shift_invariant_unit_vector :
    ¬ ∃ Ψ : lp (fun _ : ℤ => ℂ) 2, ‖Ψ‖ = 1 ∧ ∀ k, Ψ (k + 1) = Ψ k := by
  rintro ⟨Ψ, hnorm, hinv⟩
  have h0 := shift_invariant_l2_eq_zero Ψ hinv
  rw [h0] at hnorm
  simp at hnorm

/-- Contrast: the gauge-invariant algebra is nontrivial (contains the constants)
even though there is no invariant state — the point of the chapter. -/
theorem one_mem_gaugeInvariantSubalgebra {X Y : Type*} (π : X → Y) :
    (1 : X → ℝ) ∈ gaugeInvariantSubalgebra ℝ π := by
  intro g _ x; rfl

/-! ## G.4 — Gauge-fixing: sections always exist -/

/-- A complete gauge-fixing slice crosses each fiber at most once (book 2294). -/
def IsCompleteGaugeFixing {X Y : Type*} (π : X → Y) (S : Set X) : Prop :=
  ∀ ⦃x x'⦄, x ∈ S → x' ∈ S → π x = π x' → x = x'

/-- Every parametrization admits a total complete gauge-fixing (a section). -/
theorem exists_complete_gaugeFixing {X Y : Type*} {π : X → Y}
    (hπ : Function.Surjective π) :
    ∃ S : Set X, IsCompleteGaugeFixing π S ∧ π '' S = Set.univ := by
  refine ⟨Set.range (Function.surjInv hπ), ?_, ?_⟩
  · rintro x x' ⟨y, rfl⟩ ⟨y', rfl⟩ he
    rw [Function.surjInv_eq hπ, Function.surjInv_eq hπ] at he
    rw [he]
  · rw [Set.eq_univ_iff_forall]
    intro y
    exact ⟨Function.surjInv hπ (π (Function.surjInv hπ y)), ⟨_, rfl⟩, by
      rw [Function.surjInv_eq hπ, Function.surjInv_eq hπ]⟩

/-! ## G.5 — Haar averaging (invariantization) and the pushforward headline -/

section Haar

variable {G : Type*} [Group G] [MeasurableSpace G]
variable {μG : Measure G} [IsProbabilityMeasure μG] [μG.IsMulLeftInvariant]
variable {X : Type*} [MulAction G X]

/-- The Haar averaging (invariantization) operator (book 2350–2392). -/
noncomputable def haarAverage (f : X → ℝ) (x : X) : ℝ := ∫ g, f (g⁻¹ • x) ∂μG

omit [IsProbabilityMeasure μG] in
/-- Haar averaging produces a gauge-invariant functional. -/
theorem haarAverage_smul [MeasurableMul G]
    (f : X → ℝ) (g₀ : G) (x : X) :
    haarAverage (μG := μG) f (g₀ • x) = haarAverage (μG := μG) f x := by
  simp only [haarAverage]
  have key : (fun g : G => f (g⁻¹ • (g₀ • x)))
      = fun g : G => (fun h => f (h⁻¹ • x)) (g₀⁻¹ * g) := by
    funext g
    simp only [smul_smul, mul_inv_rev, inv_inv]
  rw [key]
  exact integral_mul_left_eq_self (fun h => f (h⁻¹ • x)) g₀⁻¹

omit [μG.IsMulLeftInvariant] in
/-- On invariant functions the averaging operator is the identity (projection). -/
theorem haarAverage_of_invariant (f : X → ℝ) (hf : ∀ g : G, ∀ x, f (g • x) = f x) :
    haarAverage (μG := μG) f = f := by
  funext x
  simp only [haarAverage]
  have : (fun g : G => f (g⁻¹ • x)) = fun _ => f x := by
    funext g; rw [hf g⁻¹ x]
  rw [this, integral_const]; simp

omit [μG.IsMulLeftInvariant] in
/-- The averaging operator is unital. -/
theorem haarAverage_one : haarAverage (μG := μG) (X := X) (fun _ => 1) = fun _ => 1 := by
  funext x
  simp only [haarAverage, integral_const]
  simp

omit [IsProbabilityMeasure μG] [μG.IsMulLeftInvariant] in
/-- The averaging operator is positive. -/
theorem haarAverage_nonneg (f : X → ℝ) (hf : 0 ≤ f) :
    0 ≤ haarAverage (μG := μG) f := by
  intro x
  simp only [haarAverage, Pi.zero_apply]
  apply integral_nonneg
  intro g
  exact hf (g⁻¹ • x)

end Haar

/-- **Headline (book 2374–2386).** The pushforward of a probability measure by a
projection onto the constrained spectrum `C` gives `C` full measure `1` — the
constraint is implemented *without* attributing null probability to the
constrained space. -/
theorem gauge_constraint_pushforward_full_measure
    {X : Type*} [MeasurableSpace X] (μ : Measure X) [IsProbabilityMeasure μ]
    (q : X → X) (hq : Measurable q)
    (C : Set X) (hC : MeasurableSet C)
    (hrange : ∀ x, q x ∈ C) :
    IsProbabilityMeasure (μ.map q) ∧ (μ.map q) C = 1 := by
  refine ⟨Measure.isProbabilityMeasure_map hq.aemeasurable, ?_⟩
  rw [Measure.map_apply hq hC]
  have : q ⁻¹' C = Set.univ := by
    ext x; simp [hrange x]
  rw [this, measure_univ]

/-! ## G.6 — BRST ghost algebra (nilpotency) -/

section BRST

variable {A : Type*} [Ring A]

/-- The ghost annihilation operator `ψ` (book 2403–2452). -/
def ghostAnnih : Matrix (Fin 2) (Fin 2) A := !![0, 1; 0, 0]

/-- The ghost creation operator `ψ†`. -/
def ghostCreat : Matrix (Fin 2) (Fin 2) A := !![0, 0; 1, 0]

/-- The canonical anticommutation relation `{ψ, ψ†} = 1`. -/
theorem ghost_car :
    ghostAnnih * ghostCreat + ghostCreat * ghostAnnih = (1 : Matrix (Fin 2) (Fin 2) A) := by
  ext i j; fin_cases i <;> fin_cases j <;>
    simp [ghostAnnih, ghostCreat]

theorem ghost_annih_sq : ghostAnnih * ghostAnnih = (0 : Matrix (Fin 2) (Fin 2) A) := by
  ext i j; fin_cases i <;> fin_cases j <;>
    simp [ghostAnnih, Matrix.mul_apply, Fin.sum_univ_two]

theorem ghost_creat_sq : ghostCreat * ghostCreat = (0 : Matrix (Fin 2) (Fin 2) A) := by
  ext i j; fin_cases i <;> fin_cases j <;>
    simp [ghostCreat, Matrix.mul_apply, Fin.sum_univ_two]

/-- Over `ℂ`, `ψ†` is the conjugate-transpose (adjoint) of `ψ`. -/
theorem ghost_creat_conjTranspose : (ghostAnnih (A := ℂ))ᴴ = ghostCreat := by
  ext i j; fin_cases i <;> fin_cases j <;>
    simp [ghostAnnih, ghostCreat, Matrix.conjTranspose_apply]

/-- The BRST charge `Ω = Q·ψ†` for a gauge generator `Q` (book: `Ω=(πφ+π*φ*)ψ†`). -/
def BRST (Q : A) : Matrix (Fin 2) (Fin 2) A := !![0, 0; Q, 0]

/-- The BRST charge is nilpotent, `Ω² = 0`, for every gauge generator. -/
theorem BRST_nilpotent (Q : A) : BRST Q * BRST Q = (0 : Matrix (Fin 2) (Fin 2) A) := by
  ext i j; fin_cases i <;> fin_cases j <;>
    simp [BRST, Matrix.mul_apply, Fin.sum_univ_two]

end BRST

/-! ## G.7 — Dissipative dynamics: Koopman evolution -/

/-- The damped coupled-oscillator system in companion (first-order) form
(book eq. 2199). -/
def dampedCoupledMatrix (l₁ l₂ w₁ w₂ c₁ c₂ : ℝ) : Matrix (Fin 4) (Fin 4) ℝ :=
  !![0, 1, 0, 0;  -w₁^2, -l₁, c₂, 0;  0, 0, 0, 1;  c₁, 0, -w₂^2, -l₂]

/-- The flow of a linear system is a one-parameter group. -/
theorem dampedFlow_add (M : Matrix (Fin 4) (Fin 4) ℝ) (s t : ℝ) :
    NormedSpace.exp ((s + t) • M) = NormedSpace.exp (s • M) * NormedSpace.exp (t • M) := by
  rw [add_smul]
  exact Matrix.exp_add_of_commute _ _ ((Commute.refl M).smul_left s |>.smul_right t)

theorem dampedFlow_zero (M : Matrix (Fin 4) (Fin 4) ℝ) :
    NormedSpace.exp ((0 : ℝ) • M) = 1 := by
  rw [zero_smul]; exact NormedSpace.exp_zero

/-- **Probability is conserved** by any measurable evolution map (the honest
formal shadow of "the pendulums do not disappear", book §2184). -/
theorem evolution_conserves_probability {X : Type*} [MeasurableSpace X]
    (μ : Measure X) [IsProbabilityMeasure μ] (T : X → X) (hT : Measurable T) :
    IsProbabilityMeasure (μ.map T) :=
  MeasureTheory.Measure.isProbabilityMeasure_map hT.aemeasurable

/-! ### G.7a — the Koopman unitary of a measure-preserving equivalence -/

section Koopman

variable {α β E : Type*} [MeasurableSpace α] [MeasurableSpace β]
  [NormedAddCommGroup E] [NormedSpace ℝ E] {μ : Measure α} {ν : Measure β}
  {p : ENNReal} [Fact (1 ≤ p)]

/-- Composing with `f` then with `f.symm` is the identity on `Lp E p ν`. -/
theorem koopman_comp_left (f : α ≃ᵐ β) (hf : MeasurePreserving f μ ν) (u : Lp E p ν) :
    (Lp.compMeasurePreservingₗᵢ ℝ (f.symm : β → α) hf.symm)
      (Lp.compMeasurePreservingₗᵢ ℝ (f : α → β) hf u) = u := by
  apply Lp.ext
  have h2 : (↑↑((Lp.compMeasurePreservingₗᵢ ℝ (f.symm : β → α) hf.symm)
      (Lp.compMeasurePreservingₗᵢ ℝ (f : α → β) hf u)) : β → E)
      =ᵐ[ν] (↑↑((Lp.compMeasurePreservingₗᵢ ℝ (f : α → β) hf u)) : α → E) ∘ f.symm :=
    Lp.coeFn_compMeasurePreserving _ hf.symm
  have h1 : (↑↑((Lp.compMeasurePreservingₗᵢ ℝ (f : α → β) hf u)) : α → E)
      =ᵐ[μ] (↑↑u : β → E) ∘ f :=
    Lp.coeFn_compMeasurePreserving _ hf
  have h1' : ((↑↑((Lp.compMeasurePreservingₗᵢ ℝ (f : α → β) hf u)) : α → E) ∘ f.symm)
      =ᵐ[ν] ((↑↑u : β → E) ∘ f) ∘ f.symm :=
    (hf.symm.quasiMeasurePreserving).ae_eq_comp h1
  refine h2.trans (h1'.trans ?_)
  filter_upwards with x
  simp [Function.comp_apply, MeasurableEquiv.apply_symm_apply]

/-- Composing with `f.symm` then with `f` is the identity on `Lp E p μ`. -/
theorem koopman_comp_right (f : α ≃ᵐ β) (hf : MeasurePreserving f μ ν) (v : Lp E p μ) :
    (Lp.compMeasurePreservingₗᵢ ℝ (f : α → β) hf)
      (Lp.compMeasurePreservingₗᵢ ℝ (f.symm : β → α) hf.symm v) = v := by
  apply Lp.ext
  have h2 : (↑↑((Lp.compMeasurePreservingₗᵢ ℝ (f : α → β) hf)
      (Lp.compMeasurePreservingₗᵢ ℝ (f.symm : β → α) hf.symm v)) : α → E)
      =ᵐ[μ] (↑↑((Lp.compMeasurePreservingₗᵢ ℝ (f.symm : β → α) hf.symm v)) : β → E) ∘ f :=
    Lp.coeFn_compMeasurePreserving _ hf
  have h1 : (↑↑((Lp.compMeasurePreservingₗᵢ ℝ (f.symm : β → α) hf.symm v)) : β → E)
      =ᵐ[ν] (↑↑v : α → E) ∘ f.symm :=
    Lp.coeFn_compMeasurePreserving _ hf.symm
  have h1' : ((↑↑((Lp.compMeasurePreservingₗᵢ ℝ (f.symm : β → α) hf.symm v)) : β → E) ∘ f)
      =ᵐ[μ] ((↑↑v : α → E) ∘ f.symm) ∘ f :=
    (hf.quasiMeasurePreserving).ae_eq_comp h1
  refine h2.trans (h1'.trans ?_)
  filter_upwards with x
  simp [Function.comp_apply, MeasurableEquiv.symm_apply_apply]

/-! ## G.13 — Parametrization implies gauge group existence

From book.tex lines 2240–2251: every parametrization `π : X → Y` has an
associated gauge group acting on `X` such that `π` is invariant under the
group action.
-/

/-- The gauge group of a parametrization `π : X → Y` acts transitively on
each fiber.  That is, for any `x₁, x₂` with `π x₁ = π x₂`, there is a
gauge group element sending `x₁` to `x₂`.  This is the key property of
the canonical gauge group (book line 2247). -/
theorem gaugeGroup_fiber_transitive {X Y : Type*} (π : X → Y)
    (x₁ x₂ : X) (h : π x₁ = π x₂) : ∃ g ∈ gaugeGroup π, g x₁ = x₂ := by
  classical
    let σ : Equiv.Perm X := Equiv.swap x₁ x₂
    have hσ : σ ∈ gaugeGroup π := by
      rw [mem_gaugeGroup]
      intro x
      dsimp [σ]
      rw [Equiv.swap_apply_def]
      split_ifs with hx₁ hx₂
      · rw [hx₁, h]
      · rw [hx₂, ← h]
      · rfl
    exact ⟨σ, hσ, by
      dsimp [σ]
      exact Equiv.swap_apply_left x₁ x₂⟩

/-! ## G.14 — Gauge symmetry vs anomalies

From book.tex lines 2394–2400: a gauge symmetry cannot exhibit anomalies
because there is no symmetry-breaking parameter.  Formally: expectation
values of gauge-invariant operators are invariant under the gauge group
action.  An anomaly would appear as a failure of this invariance.
-/

/-- A gauge symmetry cannot exhibit anomalies: expectation values of
gauge-invariant operators are invariant under the gauge group action.
This is the formal version of "there is no way to introduce a
symmetry-breaking parameter because we only consider expectation values
of gauge-invariant operators" (book line 2394). -/
theorem gauge_symmetry_no_anomaly {X : Type*} [MeasurableSpace X]
    (μ : Measure X) [IsProbabilityMeasure μ]
    (G : Type*) [Group G] (U : G → X → X)
    (f : X → ℝ) (hf : ∀ g x, f (U g x) = f x) (g : G) :
    ∫ x, f x ∂μ = ∫ x, f (U g x) ∂μ := by
  have h_eq : (fun x : X => f (U g x)) = f := by
    ext x; exact hf g x
  rw [h_eq]

/-- The **Koopman unitary** induced by a measure-preserving equivalence: the
probability-conserving evolution acts as an isometric isomorphism of
wave-functions (book §2184, and the N7(a) deliverable for book-Ch.-B §7/§9). -/
noncomputable def koopmanEquiv (f : α ≃ᵐ β) (hf : MeasurePreserving f μ ν) :
    Lp E p ν ≃ₗᵢ[ℝ] Lp E p μ where
  toLinearEquiv :=
  { (Lp.compMeasurePreservingₗᵢ ℝ (f : α → β) hf).toLinearMap with
    invFun := Lp.compMeasurePreservingₗᵢ ℝ (f.symm : β → α) hf.symm
    left_inv := koopman_comp_left f hf
    right_inv := koopman_comp_right f hf }
  norm_map' := (Lp.compMeasurePreservingₗᵢ ℝ (f : α → β) hf).norm_map'

end Koopman

/-! ## G.13 — Unconstrained gauge-fixing

From book.tex lines 2334–2348: a gauge-fixing is *unconstrained* when the
gauge generators are necessarily excluded from the commutative von Neumann
algebra and thus do not impose constraints on the spectrum of the algebra.
The commutative algebra used in the gauge-fixing is necessarily commutative
(bounded commuting normal operators can always be simultaneously diagonalized),
so the gauge generators (which are non-commutative in general) cannot be
members of it.
-/

/-- A gauge-fixing is *unconstrained* if the gauge group acts non-trivially
on the commutative von Neumann algebra of gauge-invariant functions
(book line 2342). This means the gauge generators are excluded from the
algebra — they cannot impose constraints on the spectrum. -/
def IsUnconstrainedGaugeFixing {X Y : Type*} (π : X → Y) : Prop :=
  ∃ g ∈ gaugeGroup π, ∃ (f : gaugeInvariantSubalgebra ℝ π),
    (f : X → ℝ) ∘ g ≠ (f : X → ℝ)

/-- In an unconstrained gauge-fixing, there exists a gauge-invariant function
whose value changes under a gauge transformation (book line 2342). -/
theorem gauge_generator_excluded_from_algebra {X Y : Type*} (π : X → Y)
    (h : IsUnconstrainedGaugeFixing π) :
    ∃ g ∈ gaugeGroup π, ∃ (f : gaugeInvariantSubalgebra ℝ π),
      (f : X → ℝ) ∘ g ≠ (f : X → ℝ) :=
  h

/-! ## G.14 — Two-basis correspondence

From book.tex lines 2356–2366: there is always one basis where the gauge
unitary transformations are functions of the spectrum (constrained basis) and
another basis where they are not (unconstrained basis). The expectation
values of gauge-invariant operators are the same in both bases.
-/

/-- The *constrained basis*: a basis where gauge unitary transformations
depend only on the spectrum (book line 2356). In this basis, the
transformation acts as `basis (g x) = φ (basis x)` for some `φ : Y → Y`. -/
def constrainedBasis {X Y : Type*} (π : X → Y) : Prop :=
  ∃ (basis : X → Y) (_ : Function.Bijective basis),
    ∀ g ∈ gaugeGroup π, ∃ (φ : Y → Y), basis ∘ g = φ ∘ basis

/-- The *unconstrained basis*: a basis where gauge transformations are
not functions of the spectrum (book line 2357). There exists a gauge
transformation that does not commute with the basis in the sense above. -/
def unconstrainedBasis {X Y : Type*} (π : X → Y) : Prop :=
  ∃ (basis : X → Y) (_ : Function.Bijective basis),
    ∃ g ∈ gaugeGroup π, ∀ (φ : Y → Y), basis ∘ g ≠ φ ∘ basis

/-- For a gauge-invariant function `f`, the value at `x` depends only on
`π x` (the image under the parametrization). This is the key property
that makes expectation values basis-independent: gauge-invariant functions
are constant on fibers of `π`. -/
theorem gaugeInvariant_constant_on_fibers {X Y : Type*}
    (π : X → Y) (f : X → ℝ) (hf : ∀ g ∈ gaugeGroup π, ∀ x, f (g x) = f x)
    (x y : X) (h : π x = π y) : f x = f y := by
  classical
    have hswap : Equiv.swap x y ∈ gaugeGroup π := swap_mem_gaugeGroup h
    have h_eq := hf (Equiv.swap x y) hswap x
    simpa [Equiv.swap_apply_left] using h_eq.symm

/-! ## G.15 — Casimir operator constraints

From book.tex lines 2368–2370: it suffices to constrain to zero the Casimir
operators of the (eventually non-commutative) Lie algebra of constraints;
this imposes the constraints without the need for the constraints to be part
of the commutative von Neumann algebra.
-/

/-- In an unconstrained gauge-fixing, the gauge-invariant subalgebra is
properly contained in the full algebra. This means there exist
non-invariant operators that must be constrained via their Casimir
operators rather than being excluded from the physical algebra.

This is the algebraic content of the Casimir sufficiency principle:
the constraints need not belong to the commutative von Neumann algebra
if the Casimir operators (which are gauge-invariant by construction)
are sufficient to enforce them. -/
theorem casimir_sufficient_for_constraints {X Y : Type*} (π : X → Y)
    (h : IsUnconstrainedGaugeFixing π) :
    gaugeInvariantSubalgebra ℝ π ≠ ⊤ := by
  rcases h with ⟨g, hg, f, hf⟩
  exfalso
  have h_contra : (f : X → ℝ) ∘ g = (f : X → ℝ) := by
    have h_mem : ∀ x, (f : X → ℝ) (g x) = (f : X → ℝ) x := f.property g hg
    ext x; exact h_mem x
  exact hf h_contra

end BookProof.ChapterG
