-- Generated from ChapterFiniteSectionSingleTime.lean — solution of BookProof.FiniteSectionSingleTime.secOp_tendsto_core
import Mathlib
import Definitions.Def_ChapterFiniteSectionSingleTime
import Theorems.Thm_BookProof_FiniteSectionSingleTime_core_eq_sum
import Theorems.Thm_BookProof_FiniteSectionSingleTime_secOp_tendsto_basis
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
theorem solution {W : ℕ → Finset ι} (hW : Exhausts W) (x : lpFiniteModes ι) :
    Tendsto (fun n => secOp H (W n) ((x : L2I ι))) atTop (𝓝 (H x)) := by

  classical
  set S := (Set.Finite.toFinset (mem_lpFiniteModes.mp x.2)) with hS
  have hx := core_eq_sum x
  have hlhs : ∀ n, secOp H (W n) ((x : L2I ι))
      = ∑ k ∈ S, (((x : L2I ι) : ι → ℂ) k) • secOp H (W n) (basisVec k) := by
    intro n
    conv_lhs => rw [hx]
    push_cast
    rw [map_sum]
    refine Finset.sum_congr rfl fun k _ => ?_
    rw [map_smul]
    rfl
  have hrhs : H x = ∑ k ∈ S, (((x : L2I ι) : ι → ℂ) k) • H (coreVec k) := by
    conv_lhs => rw [hx]
    rw [map_sum]
    exact Finset.sum_congr rfl fun k _ => by rw [map_smul]
  rw [hrhs]
  simp only [hlhs]
  exact tendsto_finset_sum _ fun k _ =>
    (secOp_tendsto_basis H hW k).const_smul (((x : L2I ι) : ι → ℂ) k)
