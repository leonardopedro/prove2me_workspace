import Mathlib
import BookProof.PhysMehler
import RandomMap.RandomMap2

/-!
# The Kopperman tail is infinite dimensional (plan §4.1, Task B2b)

`PhysMehler.substrate_orthonormal_pair` exhibits *two* orthonormal vectors in the
substrate `L²([0,1])` — the `√2`-scaled indicators of the two halves.  This module
generalizes that construction to a **countable** orthonormal family (the scaled
indicators of the disjoint intervals `(1/(n+2), 1/(n+1)]`) and concludes that the
substrate — hence the Kopperman tail `InnerTail` of the Solovay decomposition — is
not finite dimensional.

## Deliverables

* `substrateInterval` / `substrateIntervals_disjoint` — the disjoint intervals and
  their positive measures;
* `substrate_orthonormal_family` — a countable orthonormal family in the
  substrate;
* `substrate_infinite_dimensional` — `¬ FiniteDimensional ℝ Substrate`;
* `tail_infinite_dimensional` — **headline**: `¬ FiniteDimensional ℝ InnerTail`.
  The tail really does carry infinitely many independent directions, so the head /
  tail split of the Solovay decomposition is not a finite-dimensional artefact.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

noncomputable section

open MeasureTheory Set PhysMehler PhysMeasureBasis
open scoped ENNReal

namespace BookProof.ChapterSolovayTailDimension

/-! ## A countable family of disjoint intervals in `[0,1]` -/

/-- The `n`-th interval of the countable partition of `(0,1]` used to build an
orthonormal family in the substrate: `(1/(n+2), 1/(n+1)]`. -/
def substrateInterval (n : ℕ) : Set ℝ := Ioc (1 / (n + 2) : ℝ) (1 / (n + 1) : ℝ)

theorem substrateInterval_measurableSet (n : ℕ) : MeasurableSet (substrateInterval n) :=
  measurableSet_Ioc

theorem substrateInterval_subset (n : ℕ) : substrateInterval n ⊆ Icc (0 : ℝ) 1 := by
  intro x hx
  obtain ⟨h1, h2⟩ := hx
  have hn1 : (0 : ℝ) < (n : ℝ) + 1 := by positivity
  have hn2 : (0 : ℝ) < (n : ℝ) + 2 := by positivity
  constructor
  · have : (0 : ℝ) < 1 / ((n : ℝ) + 2) := by positivity
    linarith
  · have : 1 / ((n : ℝ) + 1) ≤ 1 := by
      rw [div_le_one hn1]; linarith [Nat.cast_nonneg (α := ℝ) n]
    linarith

theorem substrateInterval_measure (n : ℕ) :
    unitMeasure (substrateInterval n)
      = ENNReal.ofReal (1 / ((n : ℝ) + 1) - 1 / ((n : ℝ) + 2)) := by
  have hrestr : unitMeasure = volume.restrict (Icc (0 : ℝ) 1) := rfl
  rw [hrestr, Measure.restrict_apply (substrateInterval_measurableSet n),
    Set.inter_eq_left.mpr (substrateInterval_subset n), substrateInterval, Real.volume_Ioc]

theorem substrateInterval_measure_ne_top (n : ℕ) : unitMeasure (substrateInterval n) ≠ ∞ :=
  measure_ne_top _ _

theorem substrateInterval_measureReal_pos (n : ℕ) :
    0 < unitMeasure.real (substrateInterval n) := by
  have hn1 : (0 : ℝ) < (n : ℝ) + 1 := by positivity
  have hn2 : (0 : ℝ) < (n : ℝ) + 2 := by positivity
  have hlt : 1 / ((n : ℝ) + 2) < 1 / ((n : ℝ) + 1) := by
    apply one_div_lt_one_div_of_lt hn1; linarith
  rw [measureReal_def, substrateInterval_measure, ENNReal.toReal_ofReal (by linarith)]
  linarith

/-- Distinct intervals of the family are disjoint. -/
theorem substrateIntervals_disjoint {m n : ℕ} (h : m ≠ n) :
    substrateInterval m ∩ substrateInterval n = ∅ := by
  wlog hlt : m < n generalizing m n
  · rw [Set.inter_comm]
    exact this (Ne.symm h) (lt_of_le_of_ne (not_lt.mp hlt) (Ne.symm h))
  rw [Set.eq_empty_iff_forall_notMem]
  rintro x ⟨⟨hm1, _⟩, ⟨_, hn2⟩⟩
  have hmn : (m : ℝ) + 2 ≤ (n : ℝ) + 1 := by
    have : (m : ℝ) + 1 ≤ (n : ℝ) := by exact_mod_cast Nat.succ_le_of_lt hlt
    linarith
  have hm2 : (0 : ℝ) < (m : ℝ) + 2 := by positivity
  have hle : 1 / ((n : ℝ) + 1) ≤ 1 / ((m : ℝ) + 2) := by
    apply one_div_le_one_div_of_le hm2 hmn
  linarith

/-! ## A countable orthonormal family -/

/-- The `n`-th member of the orthonormal family: the indicator of
`substrateInterval n`, scaled to unit `L²` norm. -/
def substrateBasisVector (n : ℕ) : Substrate :=
  indicatorConstLp 2 (substrateInterval_measurableSet n) (substrateInterval_measure_ne_top n)
    (Real.sqrt (unitMeasure.real (substrateInterval n)))⁻¹

theorem norm_substrateBasisVector (n : ℕ) : ‖substrateBasisVector n‖ = 1 := by
  have hpos := substrateInterval_measureReal_pos n
  have hs : 0 < Real.sqrt (unitMeasure.real (substrateInterval n)) := Real.sqrt_pos.mpr hpos
  rw [substrateBasisVector, norm_indicatorConstLp (by norm_num) (by norm_num),
    Real.norm_eq_abs, abs_of_nonneg (by positivity),
    show (1 : ℝ) / (2 : ℝ≥0∞).toReal = 1 / 2 by norm_num, ← Real.sqrt_eq_rpow]
  field_simp

/-- **A countable orthonormal family in the substrate.** -/
theorem substrateBasisVector_orthonormal : Orthonormal ℝ substrateBasisVector := by
  rw [orthonormal_iff_ite]
  intro m n
  by_cases h : m = n
  · subst h
    rw [real_inner_self_eq_norm_sq, norm_substrateBasisVector]
    norm_num
  · simp only [if_neg h]
    rw [substrateBasisVector, substrateBasisVector,
      L2.inner_indicatorConstLp_indicatorConstLp, substrateIntervals_disjoint h,
      measureReal_empty, zero_smul]

theorem substrate_orthonormal_family : ∃ e : ℕ → Substrate, Orthonormal ℝ e :=
  ⟨substrateBasisVector, substrateBasisVector_orthonormal⟩

/-! ## The substrate, and hence the tail, is infinite dimensional -/

/-- **The substrate `L²([0,1])` is not finite dimensional.** -/
theorem substrate_infinite_dimensional : ¬ FiniteDimensional ℝ Substrate := by
  intro _
  haveI : Finite ℕ :=
    (substrateBasisVector_orthonormal.linearIndependent).finite_of_isNoetherian
  exact not_finite ℕ

/-- **Headline (plan §4.1).**  The Kopperman tail of the Solovay decomposition is
infinite dimensional: it carries a countable orthonormal family, so no finite set
of coordinates exhausts it. -/
theorem tail_infinite_dimensional : ¬ FiniteDimensional ℝ _root_.InnerTail :=
  substrate_infinite_dimensional

end BookProof.ChapterSolovayTailDimension

end
