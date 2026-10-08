import Mathlib


/-!
# Chapter "Wave-function parametrization of a probability measure", §10 — the
decomposition of a continuous energy spectrum into countably many narrow bands

Source: `book.tex`, chapter *"Wave-function parametrization of a probability
measure"*, §*"10. Ensemble forecasting allows the approximation of a non-linear
infinite-dimensional model by a direct sum of linear models with few variables"*
(line ~2048):

> *"We have to show how to decompose an eventually continuous spectrum of the
> quantum time-evolution into a direct sum of sufficiently small intervals of
> energy, each of these intervals described by few variables.  This is not
> obvious, since any continuous interval, no matter how small, is still
> uncountable."*

This file formalizes the part of that programme which is a theorem: **for every
width `ε > 0` a continuous spectrum splits into *countably many* energy bands of
width `ε`, the bands are mutually orthogonal and exhaust the state space, and on
each band the Hamiltonian — and therefore the time evolution — is within `ε`
(resp. `|t| ε`) of a *scalar*.**  What the manuscript defers to "another article"
is the further statement that each band can be described by *few variables*;
that is not claimed here.

## Model

A Hamiltonian with (possibly continuous) spectrum is realized, as everywhere in
this development, as the multiplication operator by a measurable real "energy"
function `E : X → ℝ` on `L²(X, μ)`, and its unitary group is multiplication by
`exp(−i t E(x))`.  The `k`-th band is `band E ε k = E⁻¹([kε, (k+1)ε))`.

## Deliverables

* `mem_band_iff_floor` — every point lies in exactly one band, the one with
  index `⌊E x / ε⌋`; hence `band_pairwise_disjoint` and `iUnion_band`
  (**countably many bands covering the whole space**);
* `measurableSet_band` — the bands are measurable, so they define orthogonal
  projections on `L²`;
* `lintegral_eq_tsum_band` — **Pythagoras**: the `L²` norm of a state is the sum
  of the norms of its band components, i.e. `L²(X) = ⊕ₖ L²(band k)`;
* `bandPart`, `tsum_bandPart` — the band components of a state reassemble it;
* `energy_sub_scalar_lt` and `norm_mul_energy_sub_scalar_le` — on the `k`-th band
  the Hamiltonian differs from the **scalar** `kε` by less than `ε`;
* `norm_evolution_sub_scalar_le` — on the `k`-th band the time evolution differs
  from the scalar phase `exp(−i t kε)` by at most `|t| ε`;
* `evolution_preserves_band` — the evolution leaves each band invariant.
-/

namespace BookProof.EnergyBandDecomposition

open MeasureTheory

variable {X : Type*} {E : X → ℝ} {ε : ℝ} {k : ℤ} {x : X}

/-- The `k`-th **energy band** of width `ε`: the states whose energy lies in
`[kε, (k+1)ε)`. -/
def band (E : X → ℝ) (ε : ℝ) (k : ℤ) : Set X := E ⁻¹' Set.Ico (k * ε) ((k + 1) * ε)



measure", §10 — the
decomposition of a continuous energy spectrum into countably many narrow bands

Source: `book.tex`, chapter *"Wave-function parametrization of a probability
measure"*, §*"10. Ensemble forecasting allows the approximation of a non-linear
infinite-dimensional model by a direct sum of linear models with few variables"*
(line ~2048):

> *"We have to show how to decompose an eventually continuous spectrum of the
> quantum time-evolution into a direct sum of sufficiently small intervals of
> energy, each of these intervals described by few variables.  This is not
> obvious, since any continuous interval, no matter how small, is still
> uncountable."*

This file formalizes the part of that programme which is a theorem: **for every
width `ε > 0` a continuous spectrum splits into *countably many* energy bands of
width `ε`, the bands are mutually orthogonal and exhaust the state space, and on
each band the Hamiltonian — and therefore the time evolution — is within `ε`
(resp. `|t| ε`) of a *scalar*.**  What the manuscript defers to "another article"
is the further statement that each band can be described by *few variables*;
that is not claimed here.

## Model

A Hamiltonian with (possibly continuous) spectrum is realized, as everywhere in
this development, as the multiplication operator by a measurable real "energy"
function `E : X → ℝ` on `L²(X, μ)`, and its unitary group is multiplication by
`exp(−i t E(x))`.  The `k`-th band is `band E ε k = E⁻¹([kε, (k+1)ε))`.

## Deliverables

* `mem_band_iff_floor` — every point lies in exactly one band, the one with
  index `⌊E x / ε⌋`; hence `band_pairwise_disjoint` and `iUnion_band`
  (**countably many bands covering the whole space**);
* `measurableSet_band` — the bands are measurable, so they define orthogonal
  projections on `L²`;
* `lintegral_eq_tsum_band` — **Pythagoras**: the `L²` norm of a state is the sum
  of the norms of its band components, i.e. `L²(X) = ⊕ₖ L²(band k)`;
* `bandPart`, `tsum_bandPart` — the band components of a state reassemble it;
* `energy_sub_scalar_lt` and `norm_mul_energy_sub_scalar_le` — on the `k`-th band
  the Hamiltonian differs from the **scalar** `kε` by less than `ε`;
* `norm_evolution_sub_scalar_le` — on the `k`-th band the time evolution differs
  from the scalar phase `exp(−i t kε)` by at most `|t| ε`;
* `evolution_preserves_band` — the evolution leaves each band invariant.
-/

namespace BookProof.EnergyBandDecomposition

open MeasureTheory

variable {X : Type*} {E : X → ℝ} {ε : ℝ} {k : ℤ} {x : X}

/-- The `k`-th **energy band** of width `ε`: the states whose energy lies in
`[kε, (k+1)ε)`. -/
def band (E : X → ℝ) (ε : ℝ) (k : ℤ) : Set X := E ⁻¹' Set.Ico (k * ε) ((k + 1) * ε)

theorem measurableSet_band [MeasurableSpace X] (hE : Measurable E) (ε : ℝ) (k : ℤ) :
    MeasurableSet (band E ε k) := hE measurableSet_Ico

/-- **Every state sits in exactly one band**, the one indexed by `⌊E x / ε⌋`. -/
theorem mem_band_iff_floor (hε : 0 < ε) (E : X → ℝ) (k : ℤ) (x : X) :
    x ∈ band E ε k ↔ k = ⌊E x / ε⌋ := by
  have h : x ∈ band E ε k ↔ (k : ℝ) ≤ E x / ε ∧ E x / ε < k + 1 := by
    simp only [band, Set.mem_preimage, Set.mem_Ico]
    rw [le_div_iff₀ hε, div_lt_iff₀ hε]
  rw [h, eq_comm, Int.floor_eq_iff]

/-- The bands are pairwise disjoint: they are the fibres of the band index. -/
theorem band_pairwise_disjoint (hε : 0 < ε) (E : X → ℝ) :
    Pairwise (Function.onFun Disjoint (band E ε)) := by
  intro j k hjk
  rw [Function.onFun, Set.disjoint_left]
  intro x hj hk
  exact hjk (((mem_band_iff_floor hε E j x).mp hj).trans
    ((mem_band_iff_floor hε E k x).mp hk).symm)





/-! ## Band components of a state -/

/-- The component of the state `f` in the `k`-th band. -/
noncomputable def bandPart (E : X → ℝ) (ε : ℝ) (k : ℤ) (f : X → ℂ) : X → ℂ :=
  (band E ε k).indicator f







spectrum into countably many narrow bands

Source: `book.tex`, chapter *"Wave-function parametrization of a probability
measure"*, §*"10. Ensemble forecasting allows the approximation of a non-linear
infinite-dimensional model by a direct sum of linear models with few variables"*
(line ~2048):

> *"We have to show how to decompose an eventually continuous spectrum of the
> quantum time-evolution into a direct sum of sufficiently small intervals of
> energy, each of these intervals described by few variables.  This is not
> obvious, since any continuous interval, no matter how small, is still
> uncountable."*

This file formalizes the part of that programme which is a theorem: **for every
width `ε > 0` a continuous spectrum splits into *countably many* energy bands of
width `ε`, the bands are mutually orthogonal and exhaust the state space, and on
each band the Hamiltonian — and therefore the time evolution — is within `ε`
(resp. `|t| ε`) of a *scalar*.**  What the manuscript defers to "another article"
is the further statement that each band can be described by *few variables*;
that is not claimed here.

## Model

A Hamiltonian with (possibly continuous) spectrum is realized, as everywhere in
this development, as the multiplication operator by a measurable real "energy"
function `E : X → ℝ` on `L²(X, μ)`, and its unitary group is multiplication by
`exp(−i t E(x))`.  The `k`-th band is `band E ε k = E⁻¹([kε, (k+1)ε))`.

## Deliverables

* `mem_band_iff_floor` — every point lies in exactly one band, the one with
  index `⌊E x / ε⌋`; hence `band_pairwise_disjoint` and `iUnion_band`
  (**countably many bands covering the whole space**);
* `measurableSet_band` — the bands are measurable, so they define orthogonal
  projections on `L²`;
* `lintegral_eq_tsum_band` — **Pythagoras**: the `L²` norm of a state is the sum
  of the norms of its band components, i.e. `L²(X) = ⊕ₖ L²(band k)`;
* `bandPart`, `tsum_bandPart` — the band components of a state reassemble it;
* `energy_sub_scalar_lt` and `norm_mul_energy_sub_scalar_le` — on the `k`-th band
  the Hamiltonian differs from the **scalar** `kε` by less than `ε`;
* `norm_evolution_sub_scalar_le` — on the `k`-th band the time evolution differs
  from the scalar phase `exp(−i t kε)` by at most `|t| ε`;
* `evolution_preserves_band` — the evolution leaves each band invariant.
-/

namespace BookProof.EnergyBandDecomposition

open MeasureTheory

variable {X : Type*} {E : X → ℝ} {ε : ℝ} {k : ℤ} {x : X}

/-- The `k`-th **energy band** of width `ε`: the states whose energy lies in
`[kε, (k+1)ε)`. -/
def band (E : X → ℝ) (ε : ℝ) (k : ℤ) : Set X := E ⁻¹' Set.Ico (k * ε) ((k + 1) * ε)

theorem measurableSet_band [MeasurableSpace X] (hE : Measurable E) (ε : ℝ) (k : ℤ) :
    MeasurableSet (band E ε k) := hE measurableSet_Ico

/-- **Every state sits in exactly one band**, the one indexed by `⌊E x / ε⌋`. -/
theorem mem_band_iff_floor (hε : 0 < ε) (E : X → ℝ) (k : ℤ) (x : X) :
    x ∈ band E ε k ↔ k = ⌊E x / ε⌋ := by
  have h : x ∈ band E ε k ↔ (k : ℝ) ≤ E x / ε ∧ E x / ε < k + 1 := by
    simp only [band, Set.mem_preimage, Set.mem_Ico]
    rw [le_div_iff₀ hε, div_lt_iff₀ hε]
  rw [h, eq_comm, Int.floor_eq_iff]

/-- The bands are pairwise disjoint: they are the fibres of the band index. -/
theorem band_pairwise_disjoint (hε : 0 < ε) (E : X → ℝ) :
    Pairwise (Function.onFun Disjoint (band E ε)) := by
  intro j k hjk
  rw [Function.onFun, Set.disjoint_left]
  intro x hj hk
  exact hjk (((mem_band_iff_floor hε E j x).mp hj).trans
    ((mem_band_iff_floor hε E k x).mp hk).symm)

/-- **Countably many bands exhaust the whole space.** -/
theorem iUnion_band (hε : 0 < ε) (E : X → ℝ) : (⋃ k : ℤ, band E ε k) = Set.univ := by
  ext x
  simp only [Set.mem_iUnion, Set.mem_univ, iff_true]
  exact ⟨⌊E x / ε⌋, (mem_band_iff_floor hε E _ x).mpr rfl⟩

/-- On the `k`-th band the energy differs from the scalar `kε` by less than `ε`. -/
theorem energy_sub_scalar_lt (hε : 0 < ε) (hx : x ∈ band E ε k) :
    |E x - k * ε| < ε := by
  obtain ⟨h1, h2⟩ := hx
  rw [abs_lt]
  constructor
  · linarith
  · nlinarith [h2]

/-! ## Band components of a state -/

/-- The component of the state `f` in the `k`-th band. -/
noncomputable def bandPart (E : X → ℝ) (ε : ℝ) (k : ℤ) (f : X → ℂ) : X → ℂ :=
  (band E ε k).indicator f

theorem bandPart_of_mem (hx : x ∈ band E ε k) (f : X → ℂ) :
    bandPart E ε k f x = f x := Set.indicator_of_mem hx f

theorem bandPart_of_not_mem (hx : x ∉ band E ε k) (f : X → ℂ) :
    bandPart E ε k f x = 0 := Set.indicator_of_notMem hx f

/-- **The band components reassemble the state**: at every point all but one
component vanish, and the surviving one is the state itself. -/
theorem tsum_bandPart (hε : 0 < ε) (f : X → ℂ) (x : X) :
    ∑' k : ℤ, bandPart E ε k f x = f x := by
  have hsingle : ∀ k : ℤ, k ≠ ⌊E x / ε⌋ → bandPart E ε k f x = 0 := by
    intro k hk
    exact bandPart_of_not_mem (fun hx => hk ((mem_band_iff_floor hε E k x).mp hx)) f
  rw [tsum_eq_single ⌊E x / ε⌋ hsingle]
  exact bandPart_of_mem ((mem_band_iff_floor hε E _ x).mpr rfl) f

/-- **Pythagoras / orthogonal decomposition**: the squared `L²` norm of a state
is the sum over the (countably many) bands of the squared norms of its
components, i.e. `L²(X, μ) = ⊕ₖ L²(band k, μ)`. -/
theorem lintegral_eq_tsum_band [MeasurableSpace X] {μ : Measure X} (hε : 0 < ε)
    (hE : Measurable E)
    (f : X → ℂ) :
    ∫⁻ x, ‖f x‖ₑ ^ 2 ∂μ = ∑' k : ℤ, ∫⁻ x in band E ε k, ‖f x‖ₑ ^ 2 ∂μ := by
  have hdisj : Pairwise (Function.onFun Disjoint (band E ε)) := band_pairwise_disjoint hε E
  have hmeas : ∀ k : ℤ, MeasurableSet (band E ε k) := fun k => measurableSet_band hE ε k
  rw [← lintegral_iUnion hmeas hdisj, iUnion_band hε E, Measure.restrict_univ]

/-! ## The Hamiltonian and its evolution are nearly scalar on each band -/

/-- On the `k`-th band, multiplication by the energy differs from multiplication
by the **scalar** `kε` by at most `ε`. -/
theorem norm_mul_energy_sub_scalar_le (hε : 0 < ε) (hx : x ∈ band E ε k) (z : ℂ) :
    ‖(E x : ℂ) * z - ((k : ℝ) * ε : ℝ) * z‖ ≤ ε * ‖z‖ := by
  have h : ((E x : ℂ) * z - (((k : ℝ) * ε : ℝ) : ℂ) * z) = ((E x - k * ε : ℝ) : ℂ) * z := by
    push_cast
    ring
  rw [h, norm_mul, Complex.norm_real, Real.norm_eq_abs]
  exact mul_le_mul_of_nonneg_right (energy_sub_scalar_lt hε hx).le (norm_nonneg z)



e: `book.tex`, chapter *"Wave-function parametrization of a probability
measure"*, §*"10. Ensemble forecasting allows the approximation of a non-linear
infinite-dimensional model by a direct sum of linear models with few variables"*
(line ~2048):

> *"We have to show how to decompose an eventually continuous spectrum of the
> quantum time-evolution into a direct sum of sufficiently small intervals of
> energy, each of these intervals described by few variables.  This is not
> obvious, since any continuous interval, no matter how small, is still
> uncountable."*

This file formalizes the part of that programme which is a theorem: **for every
width `ε > 0` a continuous spectrum splits into *countably many* energy bands of
width `ε`, the bands are mutually orthogonal and exhaust the state space, and on
each band the Hamiltonian — and therefore the time evolution — is within `ε`
(resp. `|t| ε`) of a *scalar*.**  What the manuscript defers to "another article"
is the further statement that each band can be described by *few variables*;
that is not claimed here.

## Model

A Hamiltonian with (possibly continuous) spectrum is realized, as everywhere in
this development, as the multiplication operator by a measurable real "energy"
function `E : X → ℝ` on `L²(X, μ)`, and its unitary group is multiplication by
`exp(−i t E(x))`.  The `k`-th band is `band E ε k = E⁻¹([kε, (k+1)ε))`.

## Deliverables

* `mem_band_iff_floor` — every point lies in exactly one band, the one with
  index `⌊E x / ε⌋`; hence `band_pairwise_disjoint` and `iUnion_band`
  (**countably many bands covering the whole space**);
* `measurableSet_band` — the bands are measurable, so they define orthogonal
  projections on `L²`;
* `lintegral_eq_tsum_band` — **Pythagoras**: the `L²` norm of a state is the sum
  of the norms of its band components, i.e. `L²(X) = ⊕ₖ L²(band k)`;
* `bandPart`, `tsum_bandPart` — the band components of a state reassemble it;
* `energy_sub_scalar_lt` and `norm_mul_energy_sub_scalar_le` — on the `k`-th band
  the Hamiltonian differs from the **scalar** `kε` by less than `ε`;
* `norm_evolution_sub_scalar_le` — on the `k`-th band the time evolution differs
  from the scalar phase `exp(−i t kε)` by at most `|t| ε`;
* `evolution_preserves_band` — the evolution leaves each band invariant.
-/

namespace BookProof.EnergyBandDecomposition

open MeasureTheory

variable {X : Type*} {E : X → ℝ} {ε : ℝ} {k : ℤ} {x : X}

/-- The `k`-th **energy band** of width `ε`: the states whose energy lies in
`[kε, (k+1)ε)`. -/
def band (E : X → ℝ) (ε : ℝ) (k : ℤ) : Set X := E ⁻¹' Set.Ico (k * ε) ((k + 1) * ε)

theorem measurableSet_band [MeasurableSpace X] (hE : Measurable E) (ε : ℝ) (k : ℤ) :
    MeasurableSet (band E ε k) := hE measurableSet_Ico

/-- **Every state sits in exactly one band**, the one indexed by `⌊E x / ε⌋`. -/
theorem mem_band_iff_floor (hε : 0 < ε) (E : X → ℝ) (k : ℤ) (x : X) :
    x ∈ band E ε k ↔ k = ⌊E x / ε⌋ := by
  have h : x ∈ band E ε k ↔ (k : ℝ) ≤ E x / ε ∧ E x / ε < k + 1 := by
    simp only [band, Set.mem_preimage, Set.mem_Ico]
    rw [le_div_iff₀ hε, div_lt_iff₀ hε]
  rw [h, eq_comm, Int.floor_eq_iff]

/-- The bands are pairwise disjoint: they are the fibres of the band index. -/
theorem band_pairwise_disjoint (hε : 0 < ε) (E : X → ℝ) :
    Pairwise (Function.onFun Disjoint (band E ε)) := by
  intro j k hjk
  rw [Function.onFun, Set.disjoint_left]
  intro x hj hk
  exact hjk (((mem_band_iff_floor hε E j x).mp hj).trans
    ((mem_band_iff_floor hε E k x).mp hk).symm)

/-- **Countably many bands exhaust the whole space.** -/
theorem iUnion_band (hε : 0 < ε) (E : X → ℝ) : (⋃ k : ℤ, band E ε k) = Set.univ := by
  ext x
  simp only [Set.mem_iUnion, Set.mem_univ, iff_true]
  exact ⟨⌊E x / ε⌋, (mem_band_iff_floor hε E _ x).mpr rfl⟩

/-- On the `k`-th band the energy differs from the scalar `kε` by less than `ε`. -/
theorem energy_sub_scalar_lt (hε : 0 < ε) (hx : x ∈ band E ε k) :
    |E x - k * ε| < ε := by
  obtain ⟨h1, h2⟩ := hx
  rw [abs_lt]
  constructor
  · linarith
  · nlinarith [h2]

/-! ## Band components of a state -/

/-- The component of the state `f` in the `k`-th band. -/
noncomputable def bandPart (E : X → ℝ) (ε : ℝ) (k : ℤ) (f : X → ℂ) : X → ℂ :=
  (band E ε k).indicator f

theorem bandPart_of_mem (hx : x ∈ band E ε k) (f : X → ℂ) :
    bandPart E ε k f x = f x := Set.indicator_of_mem hx f

theorem bandPart_of_not_mem (hx : x ∉ band E ε k) (f : X → ℂ) :
    bandPart E ε k f x = 0 := Set.indicator_of_notMem hx f

/-- **The band components reassemble the state**: at every point all but one
component vanish, and the surviving one is the state itself. -/
theorem tsum_bandPart (hε : 0 < ε) (f : X → ℂ) (x : X) :
    ∑' k : ℤ, bandPart E ε k f x = f x := by
  have hsingle : ∀ k : ℤ, k ≠ ⌊E x / ε⌋ → bandPart E ε k f x = 0 := by
    intro k hk
    exact bandPart_of_not_mem (fun hx => hk ((mem_band_iff_floor hε E k x).mp hx)) f
  rw [tsum_eq_single ⌊E x / ε⌋ hsingle]
  exact bandPart_of_mem ((mem_band_iff_floor hε E _ x).mpr rfl) f

/-- **Pythagoras / orthogonal decomposition**: the squared `L²` norm of a state
is the sum over the (countably many) bands of the squared norms of its
components, i.e. `L²(X, μ) = ⊕ₖ L²(band k, μ)`. -/
theorem lintegral_eq_tsum_band [MeasurableSpace X] {μ : Measure X} (hε : 0 < ε)
    (hE : Measurable E)
    (f : X → ℂ) :
    ∫⁻ x, ‖f x‖ₑ ^ 2 ∂μ = ∑' k : ℤ, ∫⁻ x in band E ε k, ‖f x‖ₑ ^ 2 ∂μ := by
  have hdisj : Pairwise (Function.onFun Disjoint (band E ε)) := band_pairwise_disjoint hε E
  have hmeas : ∀ k : ℤ, MeasurableSet (band E ε k) := fun k => measurableSet_band hE ε k
  rw [← lintegral_iUnion hmeas hdisj, iUnion_band hε E, Measure.restrict_univ]

/-! ## The Hamiltonian and its evolution are nearly scalar on each band -/

/-- On the `k`-th band, multiplication by the energy differs from multiplication
by the **scalar** `kε` by at most `ε`. -/
theorem norm_mul_energy_sub_scalar_le (hε : 0 < ε) (hx : x ∈ band E ε k) (z : ℂ) :
    ‖(E x : ℂ) * z - ((k : ℝ) * ε : ℝ) * z‖ ≤ ε * ‖z‖ := by
  have h : ((E x : ℂ) * z - (((k : ℝ) * ε : ℝ) : ℂ) * z) = ((E x - k * ε : ℝ) : ℂ) * z := by
    push_cast
    ring
  rw [h, norm_mul, Complex.norm_real, Real.norm_eq_abs]
  exact mul_le_mul_of_nonneg_right (energy_sub_scalar_lt hε hx).le (norm_nonneg z)

/-- **Multiplication by `exp(−i t ·)` is Lipschitz in the exponent**: if the
energy at `x` is within `ε` of the scalar `c`, the evolution differs from the
scalar phase `exp(−i t c)` by at most `|t| ε`. -/
theorem norm_evolution_sub_scalar_le' {a : ℝ} (t c : ℝ) (z : ℂ) (h : |a - c| ≤ ε) :
    ‖Complex.exp (-(Complex.I * (t * a))) * z
        - Complex.exp (-(Complex.I * (t * c))) * z‖ ≤ |t| * ε * ‖z‖ := by
  have hrw : ∀ r : ℝ, Complex.exp (-(Complex.I * ((t : ℂ) * (r : ℂ))))
      = Complex.exp (Complex.I * ((-(t * r) : ℝ) : ℂ)) := by
    intro r
    congr 1
    push_cast
    ring
  set u : ℝ := -(t * a) with hu
  set w : ℝ := -(t * c) with hw
  have hfac : Complex.exp (Complex.I * (u : ℂ)) - Complex.exp (Complex.I * (w : ℂ))
      = Complex.exp (Complex.I * (w : ℂ)) * (Complex.exp (Complex.I * ((u - w : ℝ) : ℂ)) - 1) := by
    rw [mul_sub, mul_one, ← Complex.exp_add]
    push_cast
    ring_nf
  have hdiff : ‖Complex.exp (Complex.I * (u : ℂ)) - Complex.exp (Complex.I * (w : ℂ))‖
      ≤ |u - w| := by
    rw [hfac, norm_mul, Complex.norm_exp_I_mul_ofReal, one_mul]
    simpa [Real.norm_eq_abs] using (Real.norm_exp_I_mul_ofReal_sub_one_le (x := u - w))
  have huw : |u - w| ≤ |t| * ε := by
    have hid : u - w = -(t * (a - c)) := by rw [hu, hw]; ring
    rw [hid, abs_neg, abs_mul]
    exact mul_le_mul_of_nonneg_left h (abs_nonneg t)
  calc ‖Complex.exp (-(Complex.I * (t * a))) * z - Complex.exp (-(Complex.I * (t * c))) * z‖
      = ‖Complex.exp (Complex.I * (u : ℂ)) - Complex.exp (Complex.I * (w : ℂ))‖ * ‖z‖ := by
        rw [hrw a, hrw c, ← sub_mul, norm_mul]
    _ ≤ (|t| * ε) * ‖z‖ := mul_le_mul_of_nonneg_right (hdiff.trans huw) (norm_nonneg z)

/-- On the `k`-th band, the time evolution `exp(−i t E(x))` differs from the
**scalar phase** `exp(−i t kε)` by at most `|t| ε`. -/
theorem norm_evolution_sub_scalar_le (hε : 0 < ε) (hx : x ∈ band E ε k) (t : ℝ) (z : ℂ) :
    ‖Complex.exp (-(Complex.I * (t * (E x : ℂ)))) * z
        - Complex.exp (-(Complex.I * (t * ((((k : ℝ) * ε : ℝ)) : ℂ)))) * z‖ ≤ |t| * ε * ‖z‖ :=
  norm_evolution_sub_scalar_le' t ((k : ℝ) * ε) z (energy_sub_scalar_lt hε hx).le

/-- The time evolution, being a multiplication operator, **leaves every band
invariant**. -/
theorem evolution_preserves_band (t : ℝ) (f : X → ℂ) (k : ℤ) :
    Function.support (fun x => Complex.exp (-(Complex.I * (t * E x))) * bandPart E ε k f x)
      ⊆ band E ε k := by
  intro x hx
  by_contra hmem
  exact hx (by simp [bandPart_of_not_mem hmem f])

end BookProof.EnergyBandDecomposition
