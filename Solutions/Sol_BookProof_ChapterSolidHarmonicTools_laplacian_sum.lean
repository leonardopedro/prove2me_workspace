-- Generated from ChapterSolidHarmonicTools.lean — solution of BookProof.ChapterSolidHarmonicTools.laplacian_sum
import Mathlib
import Definitions.Def_ChapterSolidHarmonicTools
open BookProof.ChapterSolidHarmonicTools




open Laplacian InnerProductSpace BookProof.ChapterRadialLaplacian
open BookProof.ChapterLaplacianProduct
open scoped RealInnerProductSpace


variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution {ι : Type*} (s : Finset ι) (f : ι → E → ℝ) (x : E)
    (hf : ∀ i ∈ s, ContDiffAt ℝ 2 (f i) x) :
    (Δ fun y => ∑ i ∈ s, f i y) x = ∑ i ∈ s, (Δ (f i)) x := by

  classical
  induction s using Finset.induction with
  | empty =>
      simp only [Finset.sum_empty]
      rw [laplacian_eq_iteratedFDeriv_stdOrthonormalBasis]
      simp
  | insert a s ha ih =>
      have hfa : ContDiffAt ℝ 2 (f a) x := hf a (Finset.mem_insert_self a s)
      have hfs : ∀ i ∈ s, ContDiffAt ℝ 2 (f i) x := fun i hi =>
        hf i (Finset.mem_insert_of_mem hi)
      have hsum : ContDiffAt ℝ 2 (fun y => ∑ i ∈ s, f i y) x := by
        refine ContDiffAt.sum ?_
        intro i hi
        exact hfs i hi
      have hrw : (fun y => ∑ i ∈ insert a s, f i y)
          = (f a) + (fun y => ∑ i ∈ s, f i y) := by
        funext y
        simp [Finset.sum_insert ha]
      rw [hrw, hfa.laplacian_add hsum, ih hfs, Finset.sum_insert ha]
