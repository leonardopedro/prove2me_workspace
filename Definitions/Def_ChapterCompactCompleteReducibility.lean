import Mathlib


/-!
# Weyl's unitarian trick for a compact group: complete reducibility by Haar averaging

Source: `book.tex`, chapter *"Real representations, CPT theorem and the relativistic position
operator"*, **Note 23** (Weyl): *finite-dimensional representations are completely reducible*.
The manuscript quotes the theorem as an external input, and in the development it is carried
as the named hypothesis `BookProof.ChapterA3w.WeylCompleteReducibility`.

Two special cases are already theorems in this development:

* `BookProof.ChapterUnitaryCompleteReducibility` — for a **unitary** representation of an
  arbitrary group (the orthogonal complement of an invariant subspace is invariant);
* `BookProof.ChapterMaschkeFiniteGroup` — for a **finite** group (Maschke's averaging).

This file proves the remaining classical case, the one Weyl's *unitarian trick* is named for:
a **compact** group, where the finite average of Maschke's argument is replaced by the Haar
integral.  No inner product is assumed on the representation space and the group is arbitrary
compact (in particular `SU(N)`, the gauge groups of the book's field-theory chapters).

## Results

* `avgOp` — the Haar average `p = ∫_G ρ(g) ∘ T ∘ ρ(g)⁻¹ dg` of an arbitrary continuous
  projection `T` onto the invariant subspace `W`;
* `avgOp_apply_mem`, `avgOp_apply_eq_self` — `p` still maps into `W` and is the identity on
  `W`, so it is again a projection onto `W`;
* **`avgOp_comm`** — `p` commutes with the representation, which is what the averaging is
  for;
* **`compact_invariant_complement`** — hence every invariant subspace of a
  finite-dimensional continuous representation of a compact group has an **invariant
  complement**: the kernel of `p`.  This is the shape assumed by
  `ChapterA3w.WeylCompleteReducibility`, here proved for compact groups;
* `compact_invariant_complement_haar` — the same with no measure to choose: the normalized
  Haar measure of the compact group does the averaging.

Everything is `sorry`-free and uses only the standard axioms; no `EXTERNAL` hypothesis and no
`axiom` is introduced.
-/

namespace BookProof.ChapterCompactCompleteReducibility

open MeasureTheory

variable {G : Type*} [Group G] [TopologicalSpace G] [IsTopologicalGroup G] [CompactSpace G]
  [MeasurableSpace G] [BorelSpace G] {μ : Measure G} [IsProbabilityMeasure μ]
  [μ.IsMulLeftInvariant]
variable {V : Type*} [NormedAddCommGroup V] [NormedSpace ℂ V] [FiniteDimensional ℂ V]

/-- The conjugate `ρ(g) ∘ T ∘ ρ(g)⁻¹` of an operator by the representation. -/
noncomputable def conjOp (ρ : G →* (V ≃L[ℂ] V)) (T : V →L[ℂ] V) (g : G) : V →L[ℂ] V :=
  ((ρ g : V →L[ℂ] V).comp (T.comp ((ρ g).symm : V →L[ℂ] V)))





/-- **The Haar average of a projection.** -/
noncomputable def avgOp (μ : Measure G) (ρ : G →* (V ≃L[ℂ] V)) (T : V →L[ℂ] V) : V →L[ℂ] V :=
  ∫ g, conjOp ρ T g ∂μ











/-- The normalized Haar measure of a compact Hausdorff group is a probability measure. -/
instance isProbabilityMeasure_haarMeasure_top [T2Space G] :
    IsProbabilityMeasure (Measure.haarMeasure (⊤ : TopologicalSpace.PositiveCompacts G)) := by
  constructor
  simpa using Measure.haarMeasure_self (K₀ := (⊤ : TopologicalSpace.PositiveCompacts G))erator"*, **Note 23** (Weyl): *finite-dimensional representations are completely reducible*.
The manuscript quotes the theorem as an external input, and in the development it is carried
as the named hypothesis `BookProof.ChapterA3w.WeylCompleteReducibility`.

Two special cases are already theorems in this development:

* `BookProof.ChapterUnitaryCompleteReducibility` — for a **unitary** representation of an
  arbitrary group (the orthogonal complement of an invariant subspace is invariant);
* `BookProof.ChapterMaschkeFiniteGroup` — for a **finite** group (Maschke's averaging).

This file proves the remaining classical case, the one Weyl's *unitarian trick* is named for:
a **compact** group, where the finite average of Maschke's argument is replaced by the Haar
integral.  No inner product is assumed on the representation space and the group is arbitrary
compact (in particular `SU(N)`, the gauge groups of the book's field-theory chapters).

## Results

* `avgOp` — the Haar average `p = ∫_G ρ(g) ∘ T ∘ ρ(g)⁻¹ dg` of an arbitrary continuous
  projection `T` onto the invariant subspace `W`;
* `avgOp_apply_mem`, `avgOp_apply_eq_self` — `p` still maps into `W` and is the identity on
  `W`, so it is again a projection onto `W`;
* **`avgOp_comm`** — `p` commutes with the representation, which is what the averaging is
  for;
* **`compact_invariant_complement`** — hence every invariant subspace of a
  finite-dimensional continuous representation of a compact group has an **invariant
  complement**: the kernel of `p`.  This is the shape assumed by
  `ChapterA3w.WeylCompleteReducibility`, here proved for compact groups;
* `compact_invariant_complement_haar` — the same with no measure to choose: the normalized
  Haar measure of the compact group does the averaging.

Everything is `sorry`-free and uses only the standard axioms; no `EXTERNAL` hypothesis and no
`axiom` is introduced.
-/

namespace BookProof.ChapterCompactCompleteReducibility

open MeasureTheory

variable {G : Type*} [Group G] [TopologicalSpace G] [IsTopologicalGroup G] [CompactSpace G]
  [MeasurableSpace G] [BorelSpace G] {μ : Measure G} [IsProbabilityMeasure μ]
  [μ.IsMulLeftInvariant]
variable {V : Type*} [NormedAddCommGroup V] [NormedSpace ℂ V] [FiniteDimensional ℂ V]

/-- The conjugate `ρ(g) ∘ T ∘ ρ(g)⁻¹` of an operator by the representation. -/
noncomputable def conjOp (ρ : G →* (V ≃L[ℂ] V)) (T : V →L[ℂ] V) (g : G) : V →L[ℂ] V :=
  ((ρ g : V →L[ℂ] V).comp (T.comp ((ρ g).symm : V →L[ℂ] V)))

omit [CompactSpace G] [MeasurableSpace G] [BorelSpace G] [FiniteDimensional ℂ V] in
theorem continuous_conjOp {ρ : G →* (V ≃L[ℂ] V)}
    (hρ : Continuous fun g => (ρ g : V →L[ℂ] V)) (T : V →L[ℂ] V) :
    Continuous (conjOp ρ T) := by
  have hinv : Continuous fun g : G => ((ρ g).symm : V →L[ℂ] V) := by
    have : (fun g : G => ((ρ g).symm : V →L[ℂ] V)) = fun g : G => ((ρ g⁻¹ : V ≃L[ℂ] V) :
        V →L[ℂ] V) := by
      funext g
      congr 1
      rw [map_inv]
      rfl
    rw [this]
    exact hρ.comp continuous_inv
  exact hρ.clm_comp (continuous_const.clm_comp hinv)

omit [μ.IsMulLeftInvariant] [FiniteDimensional ℂ V] in
theorem integrable_conjOp {ρ : G →* (V ≃L[ℂ] V)}
    (hρ : Continuous fun g => (ρ g : V →L[ℂ] V)) (T : V →L[ℂ] V) :
    Integrable (conjOp ρ T) μ :=
  (continuous_conjOp hρ T).integrable_of_hasCompactSupport
    (HasCompactSupport.of_compactSpace _)

/-- **The Haar average of a projection.** -/
noncomputable def avgOp (μ : Measure G) (ρ : G →* (V ≃L[ℂ] V)) (T : V →L[ℂ] V) : V →L[ℂ] V :=
  ∫ g, conjOp ρ T g ∂μ

omit [μ.IsMulLeftInvariant] [FiniteDimensional ℂ V] in
theorem avgOp_apply {ρ : G →* (V ≃L[ℂ] V)} (hρ : Continuous fun g => (ρ g : V →L[ℂ] V))
    (T : V →L[ℂ] V) (v : V) :
    avgOp μ ρ T v = ∫ g, ρ g (T ((ρ g).symm v)) ∂μ :=
  ContinuousLinearMap.integral_apply (integrable_conjOp hρ T) v

omit [μ.IsMulLeftInvariant] in
/-- The average still takes its values in the invariant subspace. -/
theorem avgOp_apply_mem {ρ : G →* (V ≃L[ℂ] V)} (hρ : Continuous fun g => (ρ g : V →L[ℂ] V))
    {W : Submodule ℂ V} {T : V →L[ℂ] V} (hT : ∀ v, T v ∈ W)
    (hW : ∀ g : G, ∀ x ∈ W, ρ g x ∈ W) (v : V) :
    avgOp μ ρ T v ∈ W := by
  rw [avgOp_apply hρ]
  have hconv : Convex ℝ (W : Set V) := (W.restrictScalars ℝ).convex
  have hclosed : IsClosed (W : Set V) := W.closed_of_finiteDimensional
  have hint : Integrable (fun g => ρ g (T ((ρ g).symm v))) μ := by
    have := (integrable_conjOp (μ := μ) hρ T).apply_continuousLinearMap v
    simpa [conjOp] using this
  refine hconv.integral_mem hclosed ?_ hint
  exact Filter.Eventually.of_forall fun g => hW g _ (hT _)

omit [μ.IsMulLeftInvariant] in
/-- The average is the identity on the invariant subspace, so it is again a projection
onto it. -/
theorem avgOp_apply_eq_self {ρ : G →* (V ≃L[ℂ] V)} (hρ : Continuous fun g => (ρ g : V →L[ℂ] V))
    {W : Submodule ℂ V} {T : V →L[ℂ] V} (hTid : ∀ w ∈ W, T w = w)
    (hW : ∀ g : G, ∀ x ∈ W, ρ g x ∈ W) {w : V} (hw : w ∈ W) :
    avgOp μ ρ T w = w := by
  rw [avgOp_apply hρ]
  have hpt : ∀ g : G, ρ g (T ((ρ g).symm w)) = w := by
    intro g
    have hmem : ((ρ g).symm w) ∈ W := by
      have : ((ρ g).symm w) = ρ g⁻¹ w := by
        rw [map_inv]
        rfl
      rw [this]
      exact hW _ _ hw
    rw [hTid _ hmem]
    exact (ρ g).apply_symm_apply w
  simp only [hpt]
  simp

/-- **The averaged projection commutes with the representation.** -/
theorem avgOp_comm {ρ : G →* (V ≃L[ℂ] V)} (hρ : Continuous fun g => (ρ g : V →L[ℂ] V))
    (T : V →L[ℂ] V) (h : G) (v : V) :
    avgOp μ ρ T (ρ h v) = ρ h (avgOp μ ρ T v) := by
  have hint : Integrable (fun g => ρ g (T ((ρ g).symm v))) μ := by
    have := (integrable_conjOp (μ := μ) hρ T).apply_continuousLinearMap v
    simpa [conjOp] using this
  rw [avgOp_apply hρ, avgOp_apply hρ]
  have hpull : ∫ g, ρ h (ρ g (T ((ρ g).symm v))) ∂μ = ρ h (∫ g, ρ g (T ((ρ g).symm v)) ∂μ) :=
    ContinuousLinearMap.integral_comp_comm (ρ h : V →L[ℂ] V) hint
  rw [← hpull]
  have hshift := integral_mul_left_eq_self (μ := μ)
    (fun g : G => ρ g (T ((ρ g).symm (ρ h v)))) h
  rw [← hshift]
  have hmul : ∀ (a b : G) (x : V), ρ (a * b) x = ρ a (ρ b x) := by
    intro a b x
    rw [map_mul]
    rfl
  refine integral_congr_ae (Filter.Eventually.of_forall fun k => ?_)
  have hkey : (ρ (h * k)).symm (ρ h v) = (ρ k).symm v := by
    have happ : ρ (h * k) ((ρ k).symm v) = ρ h v := by
      rw [hmul, (ρ k).apply_symm_apply]
    rw [← happ, (ρ (h * k)).symm_apply_apply]
  simp only [hkey, hmul]

/-- **Complete reducibility for a compact group** (Weyl's unitarian trick): every invariant
subspace of a finite-dimensional continuous representation of a compact group has an
invariant complement. -/
theorem compact_invariant_complement {ρ : G →* (V ≃L[ℂ] V)}
    (hρ : Continuous fun g => (ρ g : V →L[ℂ] V)) (μ : Measure G) [IsProbabilityMeasure μ]
    [μ.IsMulLeftInvariant] (W : Submodule ℂ V) (hW : ∀ g : G, ∀ x ∈ W, ρ g x ∈ W) :
    ∃ W' : Submodule ℂ V, (∀ g : G, ∀ x ∈ W', ρ g x ∈ W') ∧ IsCompl W W' := by
  -- an arbitrary continuous projection onto `W`
  obtain ⟨W₀, hW₀⟩ := W.exists_isCompl
  set T₀ : V →ₗ[ℂ] V := W.subtype.comp (W.projectionOnto W₀ hW₀) with hT₀
  set T : V →L[ℂ] V := LinearMap.toContinuousLinearMap T₀ with hT
  have hTmem : ∀ v, T v ∈ W := by
    intro v
    exact (W.projectionOnto W₀ hW₀ v).2
  have hTid : ∀ w ∈ W, T w = w := by
    intro w hw
    have h2 : W.projectionOnto W₀ hW₀ w = ⟨w, hw⟩ :=
      Submodule.projectionOnto_apply_of_mem_left hW₀ hw
    have hT₀w : T₀ w = w := by
      rw [hT₀, LinearMap.comp_apply, h2]
      rfl
    show T w = w
    exact hT₀w
  -- the averaged projection
  set p : V →L[ℂ] V := avgOp μ ρ T with hp
  have hpmem : ∀ v, p v ∈ W := fun v => avgOp_apply_mem hρ hTmem hW v
  have hpid : ∀ w ∈ W, p w = w := fun w hw => avgOp_apply_eq_self hρ hTid hW hw
  have hpcomm : ∀ (h : G) (v : V), p (ρ h v) = ρ h (p v) := fun h v => avgOp_comm hρ T h v
  -- its kernel is the invariant complement
  set f : V →ₗ[ℂ] W := (p : V →ₗ[ℂ] V).codRestrict W (fun v => hpmem v) with hf
  refine ⟨LinearMap.ker f, ?_, ?_⟩
  · intro g x hx
    have hx0 : p x = 0 := by
      have := hx
      rw [LinearMap.mem_ker] at this
      simpa [hf, Subtype.ext_iff] using congrArg (Subtype.val) this
    rw [LinearMap.mem_ker]
    have : p (ρ g x) = 0 := by rw [hpcomm, hx0, map_zero]
    simp [hf, Subtype.ext_iff, this]
  · refine LinearMap.isCompl_of_proj ?_
    intro x
    have := hpid (x : V) x.2
    simp [hf, Subtype.ext_iff, this]

/-- The normalized Haar measure of a compact Hausdorff group is a probability measure. -/
instance isProbabilityMeasure_haarMeasure_top [T2Space G] :
    IsProbabilityMeasure (Measure.haarMeasure (⊤ : TopologicalSpace.PositiveCompacts G)) := by
  constructor
  simpa using Measure.haarMeasure_self (K₀ := (⊤ : TopologicalSpace.PositiveCompacts G))

/-- **Complete reducibility for a compact group, with the Haar measure supplied.**  No measure
has to be chosen: the normalized Haar measure of the compact group does the averaging. -/
theorem compact_invariant_complement_haar [T2Space G] {ρ : G →* (V ≃L[ℂ] V)}
    (hρ : Continuous fun g => (ρ g : V →L[ℂ] V)) (W : Submodule ℂ V)
    (hW : ∀ g : G, ∀ x ∈ W, ρ g x ∈ W) :
    ∃ W' : Submodule ℂ V, (∀ g : G, ∀ x ∈ W', ρ g x ∈ W') ∧ IsCompl W W' :=
  compact_invariant_complement hρ (Measure.haarMeasure ⊤) W hW

end BookProof.ChapterCompactCompleteReducibility
