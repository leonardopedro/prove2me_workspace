import Mathlib

/-!
# Chapter "Entropy and an irreversible deterministic time-evolution coexist",
§"Irreversible deterministic time-evolution" — irreversibility as an injective,
non-surjective, non-singular self-map.

Source: `book.tex`, chapter *"Entropy and an irreversible deterministic
time-evolution coexist"*, §*"Irreversible deterministic time-evolution"*
(line ~9524).

The book argues:

> *"A process with a dissipative time-evolution is irreversible: the
> deterministic time-evolution is not an invertible function (it is injective
> but not surjective). Then there is time asymmetry."*

and, just above, that the random discrete map *"almost surely maps sets of
non-null measure into sets of non-null measure (that is, it is non-singular)"*.

This module formalizes the self-contained mathematical core of these statements.

## The finite/discrete world admits no irreversible deterministic dynamics

On a **finite** state space (the `n²`-cell discrete world of the same section),
a deterministic self-map is injective iff surjective iff bijective. Hence there
is *no* injective-but-not-surjective self-map: a deterministic reversible/
irreversible dichotomy cannot appear. This is the discrete counterpart of the
book's remark that *"the rationals are not enough"* and *"a mixed standard
probability space ... is unavoidable"*.

* `finite_injective_iff_surjective`, `finite_injective_iff_bijective`.
* `finite_injective_imp_surjective` — an injective self-map of a finite type is
  automatically surjective (so it *is* invertible: reversible).
* `finite_no_irreversible` — there is no injective non-surjective self-map of a
  finite type.

## The continuum admits irreversible deterministic dynamics

On an **infinite** state space (the continuous limit) an injective,
non-surjective self-map exists — an irreversible deterministic time-evolution.

* `exists_injective_not_surjective` — a general Dedekind-infinite witness.
* `nat_succ_injective_not_surjective` — the concrete witness `n ↦ n+1` on `ℕ`.

## A concrete non-singular dissipative map on the unit interval

The book rescales to `[0,1]×[0,1]`. The map `dissipative x = x/2` is a concrete
*non-singular dissipative* deterministic time-evolution on `[0,1]`:

* `dissipative_injective` — it is injective.
* `dissipative_mapsTo_unitInterval` — it maps `[0,1]` into `[0,1]`.
* `dissipative_not_surjective_unitInterval` — but it is **not** onto `[0,1]`
  (`1` is not attained): irreversible.
* `dissipative_image_Icc` — its image of an interval `[a,b]` is `[a/2,b/2]`.
* `dissipative_volume_Icc` — the image has half the Lebesgue length: dissipative.
* `dissipative_nonsingular_Icc` — a positive-length interval is sent to a
  positive-measure set: it is **non-singular** (positive measure ↦ positive
  measure).
-/

namespace BookProof.IrreversibleDynamics

open MeasureTheory Function Set
open scoped ENNReal

/-! ### Finite discrete world: no irreversible deterministic dynamics -/

/-- On a finite type, a self-map is injective iff surjective. -/
theorem finite_injective_iff_surjective {α : Type*} [Finite α] (f : α → α) :
    Function.Injective f ↔ Function.Surjective f :=
  Finite.injective_iff_surjective

/-- On a finite type, a self-map is injective iff bijective. -/
theorem finite_injective_iff_bijective {α : Type*} [Finite α] (f : α → α) :
    Function.Injective f ↔ Function.Bijective f :=
  Finite.injective_iff_bijective

/-- An injective self-map of a finite type is automatically surjective — hence
invertible (reversible). -/
theorem finite_injective_imp_surjective {α : Type*} [Finite α] {f : α → α}
    (hf : Function.Injective f) : Function.Surjective f :=
  (finite_injective_iff_surjective f).1 hf

/-- **No irreversible deterministic dynamics on a finite state space.** There is
no injective, non-surjective self-map of a finite type. -/
theorem finite_no_irreversible {α : Type*} [Finite α] :
    ¬ ∃ f : α → α, Function.Injective f ∧ ¬ Function.Surjective f := by
  rintro ⟨f, hinj, hnsurj⟩
  exact hnsurj (finite_injective_imp_surjective hinj)

/-! ### Infinite (continuous-limit) world: irreversible dynamics exists -/

/-- **Irreversible deterministic dynamics exists on any infinite state space.**
A Dedekind-infinite witness: an injective, non-surjective self-map. -/
theorem exists_injective_not_surjective {α : Type*} [Infinite α] :
    ∃ f : α → α, Function.Injective f ∧ ¬ Function.Surjective f := by
  classical
  obtain e := Infinite.natEmbedding α
  set S : Set α := Set.range e with hS
  refine ⟨fun x => if hx : x ∈ S then e (Classical.choose hx + 1) else x, ?_, ?_⟩
  · intro x y hxy
    simp only at hxy
    by_cases hx : x ∈ S <;> by_cases hy : y ∈ S
    · rw [dif_pos hx, dif_pos hy] at hxy
      have cx := Classical.choose_spec hx
      have cy := Classical.choose_spec hy
      have h1 : Classical.choose hx + 1 = Classical.choose hy + 1 := e.injective hxy
      have h2 : Classical.choose hx = Classical.choose hy := by omega
      rw [← cx, ← cy, h2]
    · rw [dif_pos hx, dif_neg hy] at hxy
      exact absurd (hxy ▸ ⟨_, rfl⟩ : y ∈ S) hy
    · rw [dif_neg hx, dif_pos hy] at hxy
      exact absurd (hxy ▸ ⟨_, rfl⟩ : x ∈ S) hx
    · rw [dif_neg hx, dif_neg hy] at hxy; exact hxy
  · intro hsurj
    obtain ⟨x, hx⟩ := hsurj (e 0)
    simp only at hx
    by_cases hxs : x ∈ S
    · rw [dif_pos hxs] at hx
      have : Classical.choose hxs + 1 = 0 := e.injective hx
      omega
    · rw [dif_neg hxs] at hx
      exact hxs (hx ▸ ⟨_, rfl⟩)

/-- The concrete irreversible witness on `ℕ`: the successor map is injective but
not surjective. -/
theorem nat_succ_injective_not_surjective :
    Function.Injective Nat.succ ∧ ¬ Function.Surjective Nat.succ :=
  ⟨Nat.succ_injective, by
    intro h; obtain ⟨n, hn⟩ := h 0; exact Nat.succ_ne_zero n hn⟩

/-! ### A concrete non-singular dissipative map on the unit interval -/

/-- The dissipative time-evolution `x ↦ x/2` (rescaled to the book's unit
square). -/
noncomputable def dissipative : ℝ → ℝ := fun x => x / 2

@[simp] theorem dissipative_apply (x : ℝ) : dissipative x = x / 2 := rfl

/-- The dissipative map is injective. -/
theorem dissipative_injective : Function.Injective dissipative := by
  intro a b h
  simp only [dissipative_apply] at h
  linarith

/-- The dissipative map sends the unit interval into itself. -/
theorem dissipative_mapsTo_unitInterval :
    Set.MapsTo dissipative (Set.Icc (0 : ℝ) 1) (Set.Icc (0 : ℝ) 1) := by
  intro x hx
  simp only [Set.mem_Icc, dissipative_apply] at hx ⊢
  constructor <;> linarith [hx.1, hx.2]

/-- The dissipative map is **not** surjective onto the unit interval: `1` is not
attained. Hence the deterministic time-evolution is irreversible. -/
theorem dissipative_not_surjective_unitInterval :
    ∃ y ∈ Set.Icc (0 : ℝ) 1, y ∉ dissipative '' Set.Icc (0 : ℝ) 1 := by
  refine ⟨1, by norm_num, ?_⟩
  rintro ⟨x, hx, hxy⟩
  simp only [Set.mem_Icc, dissipative_apply] at hx hxy
  linarith [hx.2]

/-- The image of an interval `[a,b]` under the dissipative map is `[a/2, b/2]`. -/
theorem dissipative_image_Icc (a b : ℝ) :
    dissipative '' Set.Icc a b = Set.Icc (a / 2) (b / 2) := by
  ext y
  simp only [dissipative_apply, Set.mem_image, Set.mem_Icc]
  constructor
  · rintro ⟨x, ⟨h1, h2⟩, rfl⟩; exact ⟨by linarith, by linarith⟩
  · rintro ⟨h1, h2⟩; exact ⟨2 * y, ⟨by linarith, by linarith⟩, by ring⟩

/-- **Dissipation.** The dissipative map halves the Lebesgue length of an
interval. -/
theorem dissipative_volume_Icc (a b : ℝ) :
    volume (dissipative '' Set.Icc a b) = ENNReal.ofReal ((b - a) / 2) := by
  rw [dissipative_image_Icc, Real.volume_Icc]
  congr 1; ring

/-- **Non-singularity.** A positive-length interval is sent to a set of positive
Lebesgue measure: the dissipative map maps sets of non-null measure into sets of
non-null measure. -/
theorem dissipative_nonsingular_Icc {a b : ℝ} (h : a < b) :
    0 < volume (dissipative '' Set.Icc a b) := by
  rw [dissipative_volume_Icc]
  simp only [ENNReal.ofReal_pos]
  linarith

/-- **Dissipation, general form.**  The dissipative map halves the Lebesgue
measure of an *arbitrary* set, not just of an interval. -/
theorem dissipative_volume_image (A : Set ℝ) :
    volume (dissipative '' A) = volume A / 2 := by
  open Pointwise in
  have h : dissipative '' A = (2⁻¹ : ℝ) • A := by
    ext y
    constructor
    · rintro ⟨x, hx, rfl⟩
      exact ⟨x, hx, by simp [dissipative, smul_eq_mul]; ring⟩
    · rintro ⟨x, hx, rfl⟩
      exact ⟨x, hx, by simp [dissipative, smul_eq_mul]; ring⟩
  rw [h, Measure.addHaar_smul]
  simp only [Module.finrank_self, pow_one, abs_inv, Nat.abs_ofNat, Nat.ofNat_pos,
    ENNReal.ofReal_inv_of_pos, ENNReal.ofReal_ofNat]
  rw [ENNReal.div_eq_inv_mul]

/-- **Non-singularity, general form.**  The dissipative map sends every set of
positive Lebesgue measure to a set of positive Lebesgue measure. -/
theorem dissipative_nonsingular {A : Set ℝ} (h : 0 < volume A) :
    0 < volume (dissipative '' A) := by
  rw [dissipative_volume_image]
  simp [ENNReal.div_pos_iff, h.ne']

end BookProof.IrreversibleDynamics
