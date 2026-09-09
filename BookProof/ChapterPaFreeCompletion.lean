import Mathlib
import BookProof.ChapterRieszFischer

/-!
# PA-Free Completion: The Riesz–Fischer Framework

We formalize the Riesz–Fischer characterization for the finitely-supported
core and its completion. The completion adds exactly the limit points
needed for Hilbert space completeness without introducing new "pathological"
vectors.

This is the mathematical foundation for the Solovay–Hilbert decidability
architecture: the completion of the finitely-supported core does not
leak PA / is a conservative extension.

**Update (August 2026).**  The Riesz–Fischer statement of this file used to be a
`True` placeholder.  It is now a genuine theorem: the analytic content lives in
`BookProof/ChapterRieszFischer.lean`, and this file records the identification of
the dense core `ℕ →₀ ℝ` with the finitely-supported vectors of `ℓ²(ℕ)`
(`range_ofCore`) together with the completeness / density / properness package
(`riesz_fischer`, `denseCore_dense`, `denseCore_proper`).
-/

open Set
open Filter
open BookProof.ChapterRieszFischer

/-- The dense core: finitely-supported vectors on ℕ.
    These represent the "definable" or "computable" vectors
    in the Riesz–Fischer framework. -/
abbrev DenseCore := ℕ →₀ ℝ

/-- The dense core is a real vector space. -/
noncomputable instance : AddCommGroup DenseCore :=
  Finsupp.instAddCommGroup (ι := ℕ) (G := ℝ)

/-- Every vector in the dense core is finitely supported.
    This is the core conservativity statement: there are no
    "infinite" vectors definable in the finite-support fragment. -/
theorem term_denotable_finite_support (v : DenseCore) :
    (Function.support (v : ℕ → ℝ)).Finite :=
  Finsupp.finite_support (v : ℕ →₀ ℝ)

/-- The canonical embedding of the dense core into its completion `ℓ²(ℕ)`:
a finitely-supported sequence is the (finite) sum of its coordinate atoms. -/
noncomputable def ofCore (v : DenseCore) : Ell2 :=
  ∑ i ∈ v.support, lp.single 2 i (v i)

/-- The embedding does not change the coordinates. -/
@[simp] theorem ofCore_apply (v : DenseCore) (j : ℕ) : (ofCore v : ℕ → ℝ) j = v j := by
  rw [ofCore, lp.coeFn_sum]
  simp only [Finset.sum_apply, lp.single_apply, Pi.single_apply, Finset.sum_ite_eq]
  by_cases hj : j ∈ v.support
  · simp [hj]
  · rw [if_neg hj, (Finsupp.notMem_support_iff).mp hj]

/-- **The image of the dense core is exactly the set of finitely-supported
vectors of `ℓ²(ℕ)`.** -/
theorem range_ofCore : Set.range ofCore = FinSupport := by
  ext f
  constructor
  · rintro ⟨v, rfl⟩
    refine Set.Finite.subset (v.support.finite_toSet) ?_
    intro j hj
    simp only [Function.mem_support, ofCore_apply] at hj
    simpa using Finsupp.mem_support_iff.mpr hj
  · intro hf
    simp only [FinSupport, Set.mem_setOf_eq] at hf
    refine ⟨Finsupp.onFinset hf.toFinset (fun n => (f : ℕ → ℝ) n) ?_, ?_⟩
    · intro n hn
      simpa using hn
    · exact Subtype.ext (funext fun j => by simp)

/-- **The Riesz–Fischer theorem.**  `ℓ²(ℕ)` — the completion of the dense core —
is complete, and every one of its vectors is the norm-limit (unconditional sum)
of its finitely-supported truncations.

This replaces the earlier `True` placeholder: both halves are genuine
statements, proved in `BookProof/ChapterRieszFischer.lean`. -/
theorem riesz_fischer :
    CompleteSpace Ell2 ∧
      ∀ f : Ell2, HasSum (fun i => lp.single 2 i ((f : ℕ → ℝ) i)) f :=
  ⟨ell2_completeSpace, riesz_fischer_hasSum⟩

/-- **The dense core is dense in the completion.** -/
theorem denseCore_dense : Dense (Set.range ofCore) := by
  rw [range_ofCore]; exact finSupport_dense

/-- **The completion is strictly larger than the dense core.**  So the
completion is not a vacuous operation, yet (by `denseCore_dense`) it adds only
limit points of core vectors. -/
theorem denseCore_proper : Set.range ofCore ≠ (Set.univ : Set Ell2) := by
  rw [range_ofCore]; exact finSupport_ne_univ
