-- Generated from ChapterPaFreeCompletion.lean — solution of range_ofCore
import Mathlib
import Definitions.Def_ChapterPaFreeCompletion
import Definitions.Def_ChapterRieszFischer
import Definitions.Def_ChapterA4



open Set
open Filter
open BookProof.ChapterRieszFischer


@[simp] private theorem ofCore_apply (v : DenseCore) (j : ℕ) : (ofCore v : ℕ → ℝ) j = v j := by
  rw [ofCore, lp.coeFn_sum]
  simp only [Finset.sum_apply, lp.single_apply, Pi.single_apply, Finset.sum_ite_eq]
  by_cases hj : j ∈ v.support
  · simp [hj]
  · rw [if_neg hj, (Finsupp.notMem_support_iff).mp hj]

set_option maxHeartbeats 1000000 in
theorem solution : Set.range ofCore = FinSupport := by

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
