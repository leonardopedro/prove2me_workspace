-- Generated from ChapterCoreBoundsEsa.lean — solution of BookProof.CoreBounds.tendsto_trunc
import Mathlib
import Definitions.Def_ChapterCoreBoundsEsa
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_sum_single_mem_finiteModes
open BookProof.CoreBounds




open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.OperatorSeries
open Filter Topology

noncomputable section

variable {ι : Type*} {c : ι → ℝ}

variable {ι : Type*} {c : ι → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution [DecidableEq ι] (c : ι → ℝ) (x : maxDom c) :
    Tendsto (fun S : Finset ι => ((trunc c x S : lpFiniteModes ι) : L2I ι)) atTop
      (𝓝 ((x : L2I ι))) := by

  classical
  have h : HasSum (fun i : ι => lp.single 2 i (((x : L2I ι) : ι → ℂ) i)) ((x : L2I ι)) :=
    lp.hasSum_single (by norm_num) _
  simp [trunc]
  exact h
