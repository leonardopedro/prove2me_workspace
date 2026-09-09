import Mathlib

/-!
# Riesz–Fischer for the PA-free completion: the finitely-supported core in `ℓ²(ℕ)`

`BookProof/ChapterPaFreeCompletion.lean` and `BookProof/ChapterDefinabilityFragment.lean`
describe the "PA-free completion" architecture: the *dense core* of term-denotable
vectors is the space `ℕ →₀ ℝ` of finitely-supported sequences, and the ambient
Hilbert space is its completion `ℓ²(ℕ)`.  Those two files record the
finite-support side of the story; the analytic side (the actual Riesz–Fischer
content) is proved here.

The three facts that make the architecture precise are:

* **completeness** (`ell2_completeSpace`): `ℓ²(ℕ)` is a Hilbert space, so no
  Cauchy sequence of core vectors escapes it;
* **Riesz–Fischer / density** (`riesz_fischer_hasSum`, `finSupport_dense`): every
  vector of `ℓ²(ℕ)` is the norm-limit of its finitely-supported truncations, so
  the completion adds *only* limit points of the core;
* **properness** (`finSupport_ne_univ`): the completion is strictly larger than
  the core — the geometric vector `n ↦ 2⁻ⁿ` lies in `ℓ²(ℕ)` and has infinite
  support — so the passage to the completion is not vacuous.

Together these say exactly what the chapter claims: the completion is the
smallest Hilbert space containing the finitely-supported core, and every one of
its elements is approximated to arbitrary precision by core elements.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open Filter
open scoped ENNReal

namespace BookProof.ChapterRieszFischer

/-- The real sequence space `ℓ²(ℕ)`: the completion of the finitely-supported
core `ℕ →₀ ℝ`. -/
abbrev Ell2 := lp (fun _ : ℕ => ℝ) 2

/-- The **dense core** inside `ℓ²(ℕ)`: the vectors with finite support, i.e. the
image of `ℕ →₀ ℝ`.  These are the term-denotable vectors of the chapter. -/
def FinSupport : Set Ell2 := {f | (Function.support ((f : ℕ → ℝ))).Finite}

/-- `ℓ²(ℕ)` is complete: the completion of the core is a Hilbert space. -/
theorem ell2_completeSpace : CompleteSpace Ell2 := inferInstance

/-- **Riesz–Fischer.** Every vector of `ℓ²(ℕ)` is the unconditional sum of its
coordinate components, i.e. the norm-limit of its finitely-supported
truncations. -/
theorem riesz_fischer_hasSum (f : Ell2) :
    HasSum (fun i => lp.single 2 i ((f : ℕ → ℝ) i)) f :=
  lp.hasSum_single (by simp) f

/-- Each finite truncation of a vector of `ℓ²(ℕ)` lies in the core. -/
theorem sum_single_mem_finSupport (f : Ell2) (s : Finset ℕ) :
    (∑ i ∈ s, lp.single 2 i ((f : ℕ → ℝ) i)) ∈ FinSupport := by
  refine Set.Finite.subset s.finite_toSet ?_
  intro j hj
  by_contra hjs
  apply hj
  simp only []
  rw [lp.coeFn_sum]
  simp only [Finset.sum_apply, lp.single_apply]
  refine Finset.sum_eq_zero fun i hi => ?_
  have hij : i ≠ j := by rintro rfl; exact hjs hi
  simp [hij]

/-- **The core is dense in the completion.**  Nothing but limit points is added
by passing from the finitely-supported core to `ℓ²(ℕ)`. -/
theorem finSupport_dense : Dense FinSupport := by
  intro f
  refine mem_closure_of_tendsto (riesz_fischer_hasSum f) ?_
  filter_upwards with s using sum_single_mem_finSupport f s

/-- The geometric sequence `n ↦ 2⁻ⁿ` is square-summable. -/
theorem memℓp_geom : Memℓp (fun n : ℕ => (1 / 2 : ℝ) ^ n) 2 := by
  apply memℓp_gen
  have h : ∀ n : ℕ, ‖(1 / 2 : ℝ) ^ n‖ ^ ((2 : ℝ≥0∞).toReal) = ((1 / 4 : ℝ)) ^ n := by
    intro n
    rw [Real.norm_eq_abs, abs_of_nonneg (by positivity)]
    simp only [ENNReal.toReal_ofNat]
    have h2 : ((1 / 2 : ℝ) ^ n) ^ (2 : ℝ) = ((1 / 2 : ℝ) ^ n) ^ (2 : ℕ) := by
      simp []
    rw [h2, ← pow_mul, mul_comm, pow_mul]
    norm_num
  simp only [h]
  exact summable_geometric_of_lt_one (by norm_num) (by norm_num)

/-- The geometric vector `n ↦ 2⁻ⁿ`, an element of the completion with infinite
support. -/
noncomputable def geomVec : Ell2 := ⟨fun n : ℕ => (1 / 2 : ℝ) ^ n, memℓp_geom⟩

/-- The geometric vector is **not** in the finitely-supported core. -/
theorem geomVec_not_mem_finSupport : geomVec ∉ FinSupport := by
  intro h
  simp only [FinSupport, Set.mem_setOf_eq] at h
  have hsupp : Function.support ((geomVec : ℕ → ℝ)) = Set.univ := by
    ext n
    simp [geomVec, Function.mem_support]
  rw [hsupp] at h
  exact Set.infinite_univ h

/-- **The completion is strictly larger than the core.**  Hence the Riesz–Fischer
completion is not a vacuous operation: it genuinely adds limit points. -/
theorem finSupport_ne_univ : FinSupport ≠ (Set.univ : Set Ell2) := by
  intro h
  exact geomVec_not_mem_finSupport (h ▸ Set.mem_univ geomVec)

/-- **Summary of the PA-free completion architecture.**  The finitely-supported
core is a proper, dense subset of the complete space `ℓ²(ℕ)`. -/
theorem core_proper_and_dense :
    Dense FinSupport ∧ FinSupport ≠ (Set.univ : Set Ell2) :=
  ⟨finSupport_dense, finSupport_ne_univ⟩

end BookProof.ChapterRieszFischer
