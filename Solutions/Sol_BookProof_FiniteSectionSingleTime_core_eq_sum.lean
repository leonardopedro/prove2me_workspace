-- Generated from ChapterFiniteSectionSingleTime.lean — solution of BookProof.FiniteSectionSingleTime.core_eq_sum
import Mathlib
import Definitions.Def_ChapterFiniteSectionSingleTime
import Theorems.Thm_BookProof_NavierStokesFlow_mem_lpFiniteModes



open scoped InnerProductSpace


open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.HashimotoShiftInvert
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato

noncomputable section

variable {ι : Type*} [DecidableEq ι]

variable {ι : Type*} [DecidableEq ι]
variable (H : lpFiniteModes ι →ₗ[ℂ] L2I ι)

set_option maxHeartbeats 1000000 in
theorem solution (x : lpFiniteModes ι) :
    x = ∑ k ∈ (Set.Finite.toFinset (mem_lpFiniteModes.mp x.2)),
      (((x : L2I ι) : ι → ℂ) k) • coreVec k := by

  refine Subtype.ext ?_
  refine lp.ext ?_
  funext j
  classical
  set S := (Set.Finite.toFinset (mem_lpFiniteModes.mp x.2)) with hS
  have hcoe : ((∑ k ∈ S, (((x : L2I ι) : ι → ℂ) k) • coreVec k : lpFiniteModes ι) : L2I ι)
      = ∑ k ∈ S, (((x : L2I ι) : ι → ℂ) k) • basisVec k := by
    push_cast
    rfl
  rw [hcoe]
  have hfun : ((∑ k ∈ S, (((x : L2I ι) : ι → ℂ) k) • basisVec k : L2I ι) : ι → ℂ) j
      = ∑ k ∈ S, (((x : L2I ι) : ι → ℂ) k) * (if j = k then 1 else 0) := by
    rw [lp.coeFn_sum]
    simp only [Finset.sum_apply, lp.coeFn_smul, Pi.smul_apply, smul_eq_mul, basisVec]
    refine Finset.sum_congr rfl fun k _ => ?_
    by_cases hjk : j = k
    · subst hjk; simp [lp.single_apply]
    · simp [lp.single_apply, hjk]
  rw [hfun]
  by_cases hj : j ∈ S
  · rw [Finset.sum_eq_single j]
    · simp
    · intro k _ hkj; simp [Ne.symm hkj]
    · intro h; exact absurd hj h
  · have hzero : ((x : L2I ι) : ι → ℂ) j = 0 := by
      by_contra hne
      exact hj (by simpa [hS, Set.Finite.mem_toFinset, Function.mem_support] using hne)
    rw [hzero]
    refine (Finset.sum_eq_zero fun k hk => ?_).symm
    by_cases hjk : j = k
    · exact absurd (hjk ▸ hk) hj
    · simp [hjk]
