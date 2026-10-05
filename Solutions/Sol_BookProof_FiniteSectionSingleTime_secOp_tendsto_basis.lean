-- Generated from ChapterFiniteSectionSingleTime.lean — solution of BookProof.FiniteSectionSingleTime.secOp_tendsto_basis
import Mathlib
import Definitions.Def_ChapterFiniteSectionSingleTime
import Theorems.Thm_BookProof_FiniteSectionSingleTime_projW_apply_tendsto
import Theorems.Thm_BookProof_FiniteSectionSingleTime_secOp_apply
open BookProof.FiniteSectionSingleTime



open scoped InnerProductSpace


open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.QgTruncationResolvent BookProof.SirkSingleTime BookProof.QgTimeIndependent
open BookProof.HashimotoShiftInvert
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato

noncomputable section

variable {ι : Type*} [DecidableEq ι]

variable {ι : Type*} [DecidableEq ι]
variable (H : lpFiniteModes ι →ₗ[ℂ] L2I ι)

set_option maxHeartbeats 1000000 in
theorem solution {W : ℕ → Finset ι} (hW : Exhausts W) (k : ι) :
    Tendsto (fun n => secOp H (W n) (basisVec k)) atTop (𝓝 (H (coreVec k))) := by

  have heq : (fun n => secOp H (W n) (basisVec k))
      =ᶠ[atTop] fun n => projW (W n) (H (coreVec k)) := by
    filter_upwards [hW {k}] with n hn
    have hk : k ∈ W n := hn (Finset.mem_singleton_self k)
    rw [secOp_apply]
    rw [Finset.sum_eq_single k]
    · simp [basisVec, lp.single_apply]
    · intro b _ hbk
      have hb0 : ((basisVec k : L2I ι) : ι → ℂ) b = 0 := by
        simp [basisVec, lp.single_apply, hbk]
      simp [hb0]
    · intro h; exact absurd hk h
  exact Tendsto.congr' heq.symm (projW_apply_tendsto hW (H (coreVec k)))
