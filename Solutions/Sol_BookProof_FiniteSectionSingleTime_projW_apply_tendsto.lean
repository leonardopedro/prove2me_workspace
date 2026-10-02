-- Generated from ChapterFiniteSectionSingleTime.lean — solution of BookProof.FiniteSectionSingleTime.projW_apply_tendsto
import Mathlib
import Definitions.Def_ChapterFiniteSectionSingleTime
import Theorems.Thm_BookProof_FiniteSectionSingleTime_smul_basisVec
import Theorems.Thm_BookProof_FiniteSectionSingleTime_projW_apply



open scoped InnerProductSpace


open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.HashimotoShiftInvert
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato

noncomputable section

variable {ι : Type*} [DecidableEq ι]

variable {ι : Type*} [DecidableEq ι]

set_option maxHeartbeats 1000000 in
theorem solution {W : ℕ → Finset ι} (hW : Exhausts W) (y : L2I ι) :
    Tendsto (fun n => projW (W n) y) atTop (𝓝 y) := by

  have hsum : HasSum (fun k : ι => lp.single 2 k ((y : ι → ℂ) k)) y :=
    lp.hasSum_single (by simp) y
  have hfin : Tendsto (fun F : Finset ι => ∑ c ∈ F, lp.single 2 c ((y : ι → ℂ) c))
      atTop (𝓝 y) := hsum
  have hWtop : Tendsto W atTop (atTop : Filter (Finset ι)) := by
    refine tendsto_atTop.2 fun F => ?_
    exact hW F
  have := hfin.comp hWtop
  refine this.congr fun n => ?_
  rw [projW_apply]
  exact Finset.sum_congr rfl fun c _ => (smul_basisVec c ((y : ι → ℂ) c)).symm
